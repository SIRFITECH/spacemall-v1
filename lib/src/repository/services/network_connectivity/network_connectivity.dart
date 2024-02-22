import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

import '../../../constants/colors.dart';
import '../../../utils/app_utils/appp_utils.dart';

class NetworkConnectivity {
  final _isDeviceConnected = false.obs;

  Future<bool> _getConnectivity() async {
    var deviceHasConnection = await InternetConnectionChecker().hasConnection;
    bool internetConnection = await _hasInternetConnection();

    if (deviceHasConnection && internetConnection == true) {
      setIsDeviceConnected(deviceHasConnection);
    } else {
      spaceMallSnackBar(
        'Bad Internet',
        'Please check your internet connection',
        kWhiteLight,
        kRedColor,
      );
      deviceHasConnection = false;
    }
    return deviceHasConnection;
  }

  Future<bool> _hasInternetConnection() async {
    try {
      final response = await http.get(Uri.parse("https://www.google.com"));
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('From the connection check method: ${e.toString()}');
      return false;
    }
  }

  Future<bool> deviceHasInternet() async {
    bool isConnected = await NetworkConnectivity()._getConnectivity();
    return isConnected;
  }

  void setIsDeviceConnected(bool value) {
    _isDeviceConnected.value = value;
  }
}
