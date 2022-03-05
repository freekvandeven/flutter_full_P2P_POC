import 'package:flutter/material.dart';

class HostConfigurationWidget extends StatelessWidget {
  const HostConfigurationWidget({
    required this.ipInformation,
    Key? key,
  }) : super(key: key);

  final Map<String, dynamic> ipInformation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Host configuration:',
          style: Theme.of(context).textTheme.headline2,
        ),
        Text(
          'Lobby information:',
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          'Your Server IPv4: ${ipInformation['ipv4']}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          'Your Server IPv6: ${ipInformation['ipv6']}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          'Your Server Port: ${ipInformation['port']}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        // TextField(
        //   decoration: InputDecoration(
        //     hintText: 'Lobby name',
        //   ),
        // ),
      ],
    );
  }
}
