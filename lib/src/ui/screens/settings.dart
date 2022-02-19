import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Settings'),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Text('Go back'),
        ),
      ],
    );
  }
}
