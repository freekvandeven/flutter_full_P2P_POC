import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
