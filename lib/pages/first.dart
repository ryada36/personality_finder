import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:personality_finder/pages/friends.dart';

class FirstAnimation extends StatefulWidget {
  @override
  _FirstAnimationState createState() => _FirstAnimationState();
}

class _FirstAnimationState extends State<FirstAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  bool isOpen = false;
  static AudioCache audioCache = new AudioCache();
  AudioPlayer audioPlayer = null;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    super.initState();
  }

  void handleTap() {
    this.setState(() {
      isOpen = !isOpen;
    });
    if (isOpen)
      this.controller.forward(from: 0);
    else
      this.controller.reverse();
  }

  @override
  void dispose() {
    print('Dispose called');
    super.dispose();
    controller.dispose();
  }

  void handlePlay(localPath) async {
    // await audioCache.play(localPath);
    if (audioPlayer != null) audioPlayer.pause();
    audioPlayer = await audioCache.play(localPath, volume: 5.0);
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 60.0)
        .chain(CurveTween(curve: Curves.linear))
        .animate(this.controller);

    return SafeArea(
      child: Scaffold(
          body: AnimatedBuilder(
              animation: offsetAnimation,
              builder: (buildContext, child) {
                return Stack(
                  children: <Widget>[
                    Container(
                        color: Colors.blue,
                        padding: EdgeInsets.all(10.0),
                        constraints: BoxConstraints.expand(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 400.0,
                              margin: EdgeInsets.only(
                                  left: 60.0 - offsetAnimation.value),
                              child: AnimatedOpacity(
                                  opacity: isOpen ? 1 : 0,
                                  duration: Duration(milliseconds: 400),
                                  child: GestureDetector(
                                      onTap: () {
                                        this.handleTap();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    new Friends()));
                                      },
                                      child: Text("Artists you may like",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          )))),
                            )
                          ],
                        )),
                    Positioned.fill(
                        child: Container(
                            color: Colors.yellow,
                            child: SingleChildScrollView(
                              // height: double.infinity,
                              // color: Colors.yellow,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.menu,
                                      size: 24.0,
                                    ),
                                    onPressed: handleTap,
                                  ),
                                  Stack(
                                    children: <Widget>[
                                      Positioned(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset('images/guitar.png'),
                                              GestureDetector(
                                                onTap: () => this
                                                    .handlePlay('happy.mp3'),
                                                child: ListTile(
                                                  leading:
                                                      Icon(Icons.music_note),
                                                  title: Text(
                                                    'Happy Birthday Tune',
                                                    style: TextStyle(
                                                      color: Colors.purple,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => this.handlePlay(
                                                    'christmas.mp3'),
                                                child: ListTile(
                                                  leading:
                                                      Icon(Icons.music_note),
                                                  title: Text(
                                                    'Merry Christmans Tune',
                                                    style: TextStyle(
                                                      color: Colors.purple,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.music_note),
                                                title: Text(
                                                  'Tune zindagi me aake zindagi',
                                                  style: TextStyle(
                                                    color: Colors.purple,
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )),
                        // left: offsetAnimation.value * 1.5,
                        top: offsetAnimation.value * 2),
                  ],
                );
              })),
    );
  }
}
