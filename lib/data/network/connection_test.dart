import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionTest {
  static Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return false; // No network at all
    }

    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false; // No actual internet connection
    }
  }
}
