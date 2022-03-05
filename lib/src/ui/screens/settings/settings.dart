import 'package:distributed/src/ui/screens/base/base.dart';
import 'package:distributed/src/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
                    'Settings',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Text(
                  'Change all your client settings',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                  onPressed: () {
                    Navigator.of(context).pop();
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
                        'Back',
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
