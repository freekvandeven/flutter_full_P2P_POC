import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';

abstract class IpService implements ChangeNotifier {
  IpService._();
  void getIpAddress();
  Map<String, String>? get ipInformation;
}

class ChipsIpService extends ChangeNotifier implements IpService {
  ChipsIpService();
  Map<String, String>? ipInformationMap;
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
  Map<String, String>? get ipInformation => ipInformationMap;

  Future<void> _initNetworkInfo() async {
    String? wifiName;
    String? wifiBSSID;
    String? wifiIPv4;
    String? wifiIPv6;
    String? wifiGatewayIP;
    String? wifiBroadcast;
    String? wifiSubmask;
    ipInformationMap = {};
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
      wifiName = 'Failed to get Wifi Name';
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
      wifiBSSID = 'Failed to get Wifi BSSID';
    }

    try {
      wifiIPv4 = await _networkInfo.getWifiIP();
    } on PlatformException catch (e) {
      debugPrint(
        'Failed to get Wifi IPv4 ${e.toString()}',
      );
      wifiIPv4 = 'Failed to get Wifi IPv4';
    }

    try {
      wifiIPv6 = await _networkInfo.getWifiIPv6();
    } catch (e) {
      if (e is MissingPluginException) {
        debugPrint(
          'WINDOWS ${e.toString()}',
        );

        wifiIPv6 = 'Failed to get Wifi IPv6 because WINDOWS';
      } else {
        debugPrint(
          'Failed to get Wifi IPv6 ${e.toString()}',
        );
        wifiIPv6 = 'Failed to get Wifi IPv6';
      }
    }

    try {
      wifiSubmask = await _networkInfo.getWifiSubmask();
    } catch (e) {
      if (e is MissingPluginException) {
        debugPrint(
          'WINDOWS ${e.toString()}',
        );

        wifiSubmask = 'Failed to get Wifi submask because WINDOWS';
      } else {
        debugPrint(
          'Failed to get Wifi submask address ${e.toString()}',
        );
        wifiSubmask = 'Failed to get Wifi submask address';
      }
    }

    try {
      wifiBroadcast = await _networkInfo.getWifiBroadcast();
    } catch (e) {
      if (e is MissingPluginException) {
        debugPrint(
          'WINDOWS ${e.toString()}',
        );

        wifiBroadcast = 'Failed to get Wifi broadcast because WINDOWS';
      } else {
        debugPrint(
          'Failed to get Wifi broadcast ${e.toString()}',
        );
        wifiBroadcast = 'Failed to get Wifi broadcast';
      }
    }

    try {
      wifiGatewayIP = await _networkInfo.getWifiGatewayIP();
    } catch (e) {
      if (e is MissingPluginException) {
        debugPrint(
          'WINDOWS ${e.toString()}',
        );

        wifiGatewayIP = 'Failed to get Wifi gateway address because WINDOWS';
      } else {
        debugPrint(
          'Failed to get Wifi gateway address ${e.toString()}',
        );
        wifiGatewayIP = 'Failed to get Wifi gateway address';
      }
    }
    ipInformationMap!['ipv4'] = wifiIPv4 ?? '';
    ipInformationMap!['ipv6'] = wifiIPv6 ?? '';
    ipInformationMap!['submask'] = wifiSubmask ?? '';
    ipInformationMap!['broadcast'] = wifiBroadcast ?? '';
    ipInformationMap!['gateway'] = wifiGatewayIP ?? '';
    ipInformationMap!['bssid'] = wifiBSSID ?? '';
    ipInformationMap!['ssid'] = wifiName ?? '';
    notifyListeners();
  }
}
