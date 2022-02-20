import 'package:distributed/src/service/api.dart';
import 'package:distributed/src/service/client.dart';
import 'package:distributed/src/service/game.dart';
import 'package:distributed/src/service/ip.dart';
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
        Provider<ApiService>(
          create: (context) => ChipsApiService(),
        ),
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
      ],
      child: child,
    );
  }
}
