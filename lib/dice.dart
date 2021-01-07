import 'dart:async';

import 'package:flutter/material.dart';

class Dice extends StatefulWidget {
  final Function tapHanlder;
  final int currentAnswer;
  Dice({Key key, this.tapHanlder, this.currentAnswer})
      : super(key: key ?? ValueKey([currentAnswer]));

  @override
  _DiceState createState() {
    print('====> ${currentAnswer}');
    return new _DiceState(tapHanlder, currentAnswer);
  }
}

class _DiceState extends State<Dice> with SingleTickerProviderStateMixin {
  AnimationController controller;
  final Function updateQuestion;
  int currentAnswer;
  _DiceState(this.updateQuestion, this.currentAnswer);

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    super.initState();
  }

  @override
  dispose() {
    controller.dispose(); // you need this
    super.dispose();
  }

  void handleTap() {
    controller.forward(from: 0.0);
    // updateQuestion();
    var future =
        new Future.delayed(const Duration(milliseconds: 500), updateQuestion);
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            }
          });
    print('random number .. ${currentAnswer}');
    return AnimatedBuilder(
        animation: offsetAnimation,
        builder: (buildContext, child) {
          if (offsetAnimation.value < 0.0) {}
          // print('${offsetAnimation.value + 8.0}');
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 24.0),
            padding: EdgeInsets.only(
                left: offsetAnimation.value + 24.0,
                right: 24.0 - offsetAnimation.value),
            child: Center(
                child: Center(
                    child: Container(
              height: 80.0,
              child: FlatButton(
                child: Image.asset(
                  'images/dice${currentAnswer == 0 ? 6 : currentAnswer}.png',
                  height: 80.0,
                ),
                onPressed: handleTap,
              ),
            ))),
          );
        });
  }
}
