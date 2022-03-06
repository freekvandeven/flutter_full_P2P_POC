import 'package:distributed/src/service/client.dart';
import 'package:distributed/src/service/game.dart';
import 'package:distributed/src/service/ip.dart';
import 'package:distributed/src/service/scan.dart';
import 'package:distributed/src/service/server.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DependencyProvider extends StatelessWidget {
  const DependencyProvider({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // specify all services that need to be injected into the app
        ChangeNotifierProvider<GameService>(
          create: (context) => ChipsGameService(),
        ),
        ChangeNotifierProvider<IpService>(
          create: (context) => ChipsIpService(),
        ),
        ChangeNotifierProvider<ClientSocketService>(
          create: (context) => ChipsClientSocketService(
            gameService: context.read(),
          ),
        ),
        ChangeNotifierProvider<ServerSocketService>(
          create: (context) =>
              ChipsServerSocketService(gameService: context.read()),
        ),
        Provider<NetworkScanService>(
          create: (context) => ChipsNetworkScanService(
            ipService: context.read(),
          ),
        ),
      ],
      child: child,
    );
  }
}
