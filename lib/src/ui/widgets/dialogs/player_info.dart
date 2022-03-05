import 'package:flutter/material.dart';

class PlayerInfoDialog extends StatelessWidget {
  const PlayerInfoDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Player Info'),
      content: const Text(
        'Here you can configure stuff during the game.\n'
        ' Maybe change your language or darkmode',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Back'),
          child: const Text('Go Back to the Game'),
        ),
      ],
    );
  }
}
