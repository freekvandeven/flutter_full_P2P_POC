import 'package:flutter/material.dart';

class JoinLobbyDialog extends StatelessWidget {
  const JoinLobbyDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Join the lobby'),
      content: const Text(
        'Are you sure you want to join this Game?.\n'
        ' You will take up valuable space.',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Back'),
          child: const Text('Go Back to the Browser'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Join');
          },
          child: const Text('Join Game'),
        ),
      ],
    );
  }
}
