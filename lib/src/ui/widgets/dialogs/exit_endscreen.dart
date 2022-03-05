import 'package:flutter/material.dart';

class ExitEndScreenDialog extends StatelessWidget {
  const ExitEndScreenDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure you want to the end Screen?'),
      content: const Text(
        'You will go back to the main menu.\n'
        ' The Savefile of the current game can be replayed later.',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Exit');
          },
          child: const Text('Exit'),
        ),
      ],
    );
  }
}
