import 'dart:io';

import 'package:flutter/material.dart';

class QuitAppDialog extends StatelessWidget {
  const QuitAppDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure you want to exit?'),
      content: const Text(
        'You will have to restart the application to continue playing.\n'
        ' All active host information will be lost!',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            exit(0);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
