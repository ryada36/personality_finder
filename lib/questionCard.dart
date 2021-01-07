import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final MapEntry<String, List> question;

  QuestionCard({this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.question_answer),
          title: Text(question.key),
          subtitle: Text("Please tap the dice",
              style: TextStyle(fontStyle: FontStyle.italic)),
        )
      ],
    )));
  }
}
