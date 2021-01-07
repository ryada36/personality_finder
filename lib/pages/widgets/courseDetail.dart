import 'package:flutter/material.dart';

class CourseDetail extends StatelessWidget {
  final int index;
  Map myState = {'open': false};

  CourseDetail({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Text(
                    "Choose a method for state management",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Divider(),
                  FlatButton(
                    child: Text("Using Bloc ",
                        style: TextStyle(color: Colors.blue)),
                    onPressed: () => {},
                  )
                ],
              ),
            ),
            StatefulBuilder(builder: (context, setState) {
              return AnimatedContainer(
                duration: Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
                width: double.infinity,
                height: double.infinity,
                color: Colors.orangeAccent,
                padding: EdgeInsets.all(20.0),
                margin:
                    EdgeInsets.only(left: MediaQuery.of(context).size.width),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.keyboard_arrow_left),
                  ],
                ),
              );
            })
          ],
        ),
      )),
    );
  }
}
