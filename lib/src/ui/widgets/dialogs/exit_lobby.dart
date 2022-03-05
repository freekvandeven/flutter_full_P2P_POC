import 'package:flutter/material.dart';

class ExitLobbyDialog extends StatelessWidget {
  const ExitLobbyDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure you want to leave the lobby?'),
      content: const Text(
        'You will lose connection to all the players.\n'
        ' If you are the host the entire lobby will be gone!',
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
