import 'package:distributed/src/routes.dart';
import 'package:distributed/src/ui/screens/base/base.dart';
import 'package:distributed/src/ui/widgets/buttons/primary_button.dart';
import 'package:distributed/src/ui/widgets/dialogs/game_menu.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChipsBaseScreen(
      escapeTrigger: () async {
        var navigator = Navigator.of(context);
        // open escape menu
        var code = await showDialog(
          context: context,
          builder: (BuildContext context) => GameMenuDialog(),
        );
        if (code == 'Exit') {
          // exit game
          await navigator.pushNamedAndRemoveUntil(
            ChipsRoute.homeScreen.route,
            (route) => false,
          );
        }
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
                    'Game Screen',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Text(
                  'You are playing the game right now',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                      ChipsRoute.endScreen.route,
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.east_rounded,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'End game',
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
              'Agent configuration',
            ),
          ),
        ],
      ),
    );
  }
}
