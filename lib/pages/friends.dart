import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:personality_finder/pages/widgets/model/FriendsModel.dart';
import 'package:transparent_image/transparent_image.dart';
import './widgets/CoronaTracker.dart';
import './widgets/courses.dart';

class Friends extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _FriendsState();
  }
}

class _FriendsState extends State<Friends> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  ScrollController _controller;
  FriendsModel friends;
  int currentPage = 1;

  @override
  void initState() {
    friends = new FriendsModel();
    _controller = new ScrollController();
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset &&
          friends.hasMore) {
        currentPage = currentPage + 1;
        friends.loadMore(pageNo: currentPage);
      }
    });
    super.initState();
  }

  void _onItemTapped(int index) {
    // print('index tapped $index');
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getMyCustomStreamWidget() {
    return StreamBuilder(
      stream: friends.stream,
      builder: (context, snapshot) {
        print('rendering stream widget ..${snapshot.connectionState}');
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(
              onRefresh: () {
                this.currentPage = 1;
                friends.refresh();
                return Future.value();
              },
              child: ListView.builder(
                padding: EdgeInsets.all(20),
                controller: _controller,
                // separatorBuilder: (context, index) => Divider(),
                itemCount: snapshot.data.length + 1,
                itemBuilder: (_context, index) {
                  if (index < snapshot.data.length) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: ClipOval(
                                  child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      fit: BoxFit.cover,
                                      image: snapshot.data[index]['avatar']),
                                ),
                                title: Text(snapshot.data[index]['first_name']),
                                subtitle: Text(
                                    'Music by Julie Gable. Lyrics by Sidney Stein.'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                    ;
                  } else if (friends.hasMore) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.0),
                      child: Center(child: Text('nothing more to load!')),
                    );
                  }
                },
              ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _selectedIndex == 0
              ? getMyCustomStreamWidget()
              : _selectedIndex == 1 ? CoronaTracker() : Courses()),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Artists'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              title: Text('Corona'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              title: Text('Courses'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.purple[800],
          onTap: (index) {
            if (index == 0) {
              this.currentPage = 1;
              friends = new FriendsModel();
            }

            this._onItemTapped(index);
          }),
    );
  }
}
