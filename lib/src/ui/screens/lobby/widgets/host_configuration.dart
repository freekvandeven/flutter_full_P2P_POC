import 'package:flutter/material.dart';

class HostConfigurationWidget extends StatelessWidget {
  const HostConfigurationWidget({
    required this.ipInformation,
    required this.isHost,
    Key? key,
  }) : super(key: key);
  final bool isHost;
  final Map<String, dynamic> ipInformation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Host configuration:',
          style: Theme.of(context).textTheme.headline2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 200.0,
            vertical: 15.0,
          ),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Column(
                  children: [
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
                  ],
                ),
              ),
              if (!isHost) ...[
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    // transparent darkcolor
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Je Bent geen host!',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
