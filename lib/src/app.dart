import 'package:distributed/src/config/theme.dart';
import 'package:distributed/src/routes.dart';
import 'package:flutter/material.dart';

class ChipsDistributionGameApp extends StatelessWidget {
  const ChipsDistributionGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getTheme(),
      home: ChipsDistributionGame(),
    );
  }
}

class ChipsDistributionGame extends StatefulWidget {
  const ChipsDistributionGame({Key? key}) : super(key: key);

  @override
  State<ChipsDistributionGame> createState() => _ChipsDistributionGameState();
}

class _ChipsDistributionGameState extends State<ChipsDistributionGame> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getTheme(),
      routes: getRoutes(),
      initialRoute: ChipsRoute.homeScreen.route,
      onGenerateRoute: (settings) {
        var routes = getAnimatedRoutes();
        if (routes.containsKey(settings.name)) {
          return PageRouteBuilder(
            settings: RouteSettings(),
            pageBuilder: routes[settings.name]!,
            transitionDuration: Duration(seconds: 10),
            reverseTransitionDuration: Duration(seconds: 10),
          );
        } else {
          return PageRouteBuilder(
            pageBuilder: routes[ChipsRoute.pageNotExist.route]!,
          );
        }
      },
    );
  }
}
