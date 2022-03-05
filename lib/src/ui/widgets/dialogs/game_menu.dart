import 'package:flutter/material.dart';

class GameMenuDialog extends StatelessWidget {
  const GameMenuDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Game Menu'),
      content: const Text(
        'Here you can configure stuff during the game.\n'
        ' Maybe change your language or darkmode',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Back'),
          child: const Text('Go Back to the Game'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Exit');
          },
          child: const Text('Exit the Game'),
        ),
      ],
    );
  }
}
