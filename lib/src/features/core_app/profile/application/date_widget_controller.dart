import 'package:get/get.dart';

class DateFieldController extends GetxController {
  var isTapped = false.obs;

  void toggleTapped() {
    isTapped.toggle();
    update();
    print('Toggled');
  }
}
