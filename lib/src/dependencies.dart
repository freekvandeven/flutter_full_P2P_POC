import 'package:distributed/src/service/api.dart';
import 'package:distributed/src/service/ip.dart';
import 'package:distributed/src/service/socket.dart';
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
        ChangeNotifierProvider<IpService>(
          create: (context) => ChipsIpService(),
        ),
        ChangeNotifierProvider<SocketService>(
          create: (context) => ChipsSocketService(),
        ),
      ],
      child: child,
    );
  }
}
