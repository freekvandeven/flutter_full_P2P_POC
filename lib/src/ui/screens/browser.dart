import 'package:distributed/src/routes.dart';
import 'package:distributed/src/ui/screens/base.dart';
import 'package:flutter/material.dart';

class GameBrowserScreen extends StatelessWidget {
  const GameBrowserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChipsBaseScreen(
      child: Column(
        children: [
          Text('All active Games:'),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => ListTile(
                title: Text('Game $index'),
                onTap: () {
                  Navigator.pushNamed(context, ChipsRoute.gameScreen.route);
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text('Go back'),
          )
        ],
      ),
    );
  }
}
