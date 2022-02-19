import 'package:distributed/src/ui/screens/base.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChipsBaseScreen(
      child: Column(
        children: [
          Text('You are playing the game right now'),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text('Back'),
          ),
        ],
      ),
    );
  }
}
