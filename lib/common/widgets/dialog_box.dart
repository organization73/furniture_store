import 'package:flutter/material.dart';

class BuildAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String actionText;
  final Function() onpress;
  const BuildAlertDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.onpress,
      required this.actionText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: onpress,
          child: Text(actionText),
        ),
      ],
    );
  }
}
