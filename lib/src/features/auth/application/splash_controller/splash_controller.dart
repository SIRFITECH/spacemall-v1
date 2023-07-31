import 'package:get/get.dart';
import 'package:spacemall/src/constants/image_strings.dart';

class SplashController extends GetxController {
  static SplashController get instance => Get.find();
  var userRole = ''.obs;
  List icons = [
    kCustomerIcon,
    kMallIcon,
  ];
  List role = [
    'Your Store',
    'Mall',
  ];
}
