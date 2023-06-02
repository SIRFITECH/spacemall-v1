import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_model.dart';

class CheckOutController extends GetxController {
  static CheckOutController get instance => Get.put(
        CheckOutController(),
      );

  int numberOfItemSelect = -1;
  RxInt items = 0.obs;
  RxBool isSelected = false.obs;
  RxInt totalCartPrice = 0.obs;

  // RxList<CheckOutModel> cartItems = RxList<CheckOutModel>([
  //   CheckOutModel(
  //     itemPic: null,
  //     itemName: 'itemName',
  //     itemQuantity: 'itemQuantity',
  //     price: 'price',
  //     totalPrice: 'totalPrice',
  //   ),
  // ]);

  // addToCart() {
  //   // cartItems.add(item);
  //   cartItems.length++;
  //   print(cartItems.length);
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  //   ever(profileController.user, (callback) => null)
  // }

  List<CheckOutModel> convertCartItems(List cartFromDb) {
    List<CheckOutModel> result = [];
    cartFromDb.forEach((item) {
      CheckOutModel.fromMap(item);
    });
    return result;
  }

  setNumberOfItemSelect(int index) {
    numberOfItemSelect = index;
    // addToCart();
    update();
    print(' selected index is $numberOfItemSelect');
  }

  increamentItems(int index, int tapedIndex) {
    if (index == tapedIndex) {
      CheckOutController.instance.items.value++;
      update();
      print('Item increament worked, tapedIndex is $tapedIndex');
    }
  }

  setSelected(int index, int tapedIndex) {
    if (index == tapedIndex) {
      isSelected.value = true;
      update();
    }
  }
}
