import 'package:distributed/src/routes.dart';
import 'package:distributed/src/ui/screens/base/base.dart';
import 'package:distributed/src/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class GameEndScreen extends StatelessWidget {
  const GameEndScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChipsBaseScreen(
      escapeTrigger: () {
        Navigator.of(context).pop();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              //lineargradient
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFe8e9eb),
                  Color(0xFFc5cad6),
                ],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100.0, bottom: 10),
                  child: Text(
                    'Game Over',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Text(
                  'You can view all stats from the previous game here',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      ChipsRoute.homeScreen.route,
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back_rounded,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Back to Home',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              'Stats',
            ),
          ),
        ],
      ),
    );
  }
}
