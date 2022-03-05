import 'package:flutter/material.dart';

class PlayerConfigurationWidget extends StatelessWidget {
  const PlayerConfigurationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Player configuration:',
          style: Theme.of(context).textTheme.headline2,
        ),
      ],
    );
  }
}
