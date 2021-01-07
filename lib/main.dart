import 'dart:math';

import 'package:flutter/material.dart';

import './questionCard.dart';
import './dice.dart';

// importing pages here
import './pages/first.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personality Finder',
      theme: ThemeData(
        // Define the default brightness and colors.
        fontFamily: "Poppins",
        primaryColor: Colors.yellow,
        accentColor: Colors.purple,

        // Define the default font family.
        // fontFamily: 'Georgia',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isStarted = false;
  bool isJourneyCompleted = false;
  int currentQuestionIndex = -1;
  List<int> answers = [];

  static const List<MapEntry<String, List>> questions = [
    MapEntry("Should you be admired for what you are?", []),
    MapEntry("Let's take a swing at your luck index", []),
    MapEntry("Will you get a beautiful wife?", [])
  ];

  void handleSelect() {
    this.setState(() {
      if (!isStarted) {
        currentQuestionIndex++;
      } else {
        currentQuestionIndex = -1;
        answers = [];
        isJourneyCompleted = false;
      }
      isStarted = !isStarted;
    });
  }

  void updateQuestion() {
    this.setState(() {
      if (currentQuestionIndex == questions.length) {
        // may be show the personality widget
      } else {
        Random rnd = new Random();
        int randomNumber = rnd.nextInt(6);
        randomNumber = randomNumber < 3 ? 3 : randomNumber;
        answers.insert(answers.length, randomNumber);
        print('answers array ${answers}');
        if (currentQuestionIndex != questions.length - 1) {
          currentQuestionIndex++;
        } else {
          // quiz completed
          isJourneyCompleted = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: !isStarted
            ? FloatingActionButton(
                child: Icon(
                  Icons.train,
                  size: 24.0,
                ),
                onPressed: handleSelect,
              )
            : FloatingActionButton(
                child: Icon(
                  Icons.restore,
                  size: 24.0,
                ),
                onPressed: handleSelect,
              ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: 150.0,
                color: Colors.yellow,
                child: Center(
                    child: Text(
                  "Find your personality",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                )),
              ),
              Container(
                // alignment: Alignment(10.0, 10.0),
                margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: currentQuestionIndex >= 0
                    ? QuestionCard(
                        question: questions.elementAt(currentQuestionIndex))
                    : Text(
                        "Please tap the train icon to start the journey!",
                        style: TextStyle(),
                      ),
              ),
              Container(
                  child: currentQuestionIndex >= 0 && !isJourneyCompleted
                      ? new Dice(
                          tapHanlder: this.updateQuestion,
                          currentAnswer: answers.length == 0
                              ? 6
                              : answers.elementAt(answers.length - 1))
                      : isJourneyCompleted
                          ? RaisedButton(
                              color: Colors.purpleAccent,
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FirstAnimation())),
                              child: Text(
                                "Next Stage",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : null),
              // Text(answers.length.toString())
            ],
          ),
        ));
  }
}
