import 'package:distributed/src/routes.dart';
import 'package:flutter/material.dart';

class ChipsDistributionGameApp extends StatelessWidget {
  const ChipsDistributionGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      routes: getRoutes(),
      initialRoute: ChipsRoute.homeScreen.route,
      onGenerateRoute: (settings) {
        var routes = getRoutes();
        if (routes.containsKey(settings.name)) {
          return MaterialPageRoute(builder: routes[settings.name]!);
        } else {
          return MaterialPageRoute(
            builder: routes[ChipsRoute.pageNotExist.route]!,
          );
        }
      },
    );
  }
}
