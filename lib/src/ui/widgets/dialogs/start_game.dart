import 'package:flutter/material.dart';

class GameStartDialog extends StatelessWidget {
  const GameStartDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Start the Game'),
      content: const Text(
        'Are you sure you want to start the Game?.\n'
        ' The game will begin immediately.',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Back'),
          child: const Text('Go Back to the Lobby'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Start');
          },
          child: const Text('Start the Game'),
        ),
      ],
    );
  }
}
