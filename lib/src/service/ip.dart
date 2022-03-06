import 'dart:io';

import 'package:distributed/src/models/network_information.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';

abstract class IpService implements ChangeNotifier {
  IpService._();
  void getIpAddress();
  NetworkInformation? get ipInformation;
}

class ChipsIpService extends ChangeNotifier implements IpService {
  ChipsIpService();
  NetworkInformation? ipInformationMap;
  final NetworkInfo _networkInfo = NetworkInfo();

  @override
  void getIpAddress() {
    if (ipInformationMap == null) {
      _initNetworkInfo();
    } else {
      notifyListeners();
    }
  }

  @override
  NetworkInformation? get ipInformation => ipInformationMap;

  Future<void> _initNetworkInfo() async {
    String? wifiName;
    String? wifiBSSID;
    String? wifiIPv4;
    String? wifiIPv6;
    String? wifiGatewayIP;
    String? wifiBroadcast;
    String? wifiSubmask;
    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiName = await _networkInfo.getWifiName();
        } else {
          wifiName = await _networkInfo.getWifiName();
        }
      } else {
        wifiName = await _networkInfo.getWifiName();
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to get Wifi Name ${e.toString()}');
    }

    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        } else {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        }
      } else {
        wifiBSSID = await _networkInfo.getWifiBSSID();
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to get Wifi BSSID ${e.toString()}');
    }

    try {
      wifiIPv4 = await _networkInfo.getWifiIP();
    } on PlatformException catch (e) {
      debugPrint(
        'Failed to get Wifi IPv4 ${e.toString()}',
      );
    }

    try {
      wifiIPv6 = await _networkInfo.getWifiIPv6();
    } catch (e) {
      if (e is MissingPluginException) {
        debugPrint(
          'WINDOWS ${e.toString()}',
        );
      } else {
        debugPrint(
          'Failed to get Wifi IPv6 ${e.toString()}',
        );
      }
    }

    try {
      wifiSubmask = await _networkInfo.getWifiSubmask();
    } catch (e) {
      if (e is MissingPluginException) {
        debugPrint(
          'WINDOWS ${e.toString()}',
        );
      } else {
        debugPrint(
          'Failed to get Wifi submask address ${e.toString()}',
        );
      }
    }

    try {
      wifiBroadcast = await _networkInfo.getWifiBroadcast();
    } catch (e) {
      if (e is MissingPluginException) {
        debugPrint(
          'WINDOWS ${e.toString()}',
        );
      } else {
        debugPrint(
          'Failed to get Wifi broadcast ${e.toString()}',
        );
      }
    }

    try {
      wifiGatewayIP = await _networkInfo.getWifiGatewayIP();
    } catch (e) {
      if (e is MissingPluginException) {
        debugPrint(
          'WINDOWS ${e.toString()}',
        );
      } else {
        debugPrint(
          'Failed to get Wifi gateway address ${e.toString()}',
        );
      }
    }
    ipInformationMap = NetworkInformation(
      wifiName: wifiName,
      wifiBSSID: wifiBSSID,
      wifiIPv4: wifiIPv4,
      wifiIPv6: wifiIPv6,
      wifiGatewayIP: wifiGatewayIP,
      wifiBroadcast: wifiBroadcast,
      wifiSubmask: wifiSubmask,
    );
    notifyListeners();
  }

  String getNetworkInterface() {
    return ipInformationMap!.networkInterface = 'wlp3s0';
    // NetworkInterface.list().then((value) => print(value));
  }
}
