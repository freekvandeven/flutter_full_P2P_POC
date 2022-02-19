import 'package:distributed/src/ui/screens/base.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChipsBaseScreen(
      child: Column(
        children: [
          Text('Settings'),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text('Go back'),
          ),
        ],
      ),
    );
  }
}
