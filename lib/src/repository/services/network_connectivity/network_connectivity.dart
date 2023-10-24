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
      deviceHasConnection = false;
    }

    if (!deviceHasConnection && !internetConnection) {
      spaceMallSnackBar(
          'Notice', 'You are working offline', kWhiteLight, kRedColor);
    } else {
      spaceMallSnackBar(
          'Network alert', 'Welcome back online', kBlackDark, kGreyColor[400]);
    }
    return deviceHasConnection;
  }

  Future<bool> _hasInternetConnection() async {
    try {
      final response = await http.get(Uri.parse("https://www.google.com"));
      return response.statusCode == 200;
    } catch (e) {
      print('From the connection check method ${e.toString()}');
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
