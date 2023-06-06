import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';

class CheckOutItemController extends GetxController {
  static CheckOutItemController get instance => Get.put(
        CheckOutItemController(),
      );

  int numberOfItemSelect = -1;

  RxBool isSelected = false.obs;
  RxInt totalCartPrice = 0.obs;

  // first attempt to render based on variable change,
  // starting with tapedIndex

  RxInt tapedIndex = (-1).obs;
  RxInt items = 0.obs;

  void setTapedIndex(int index) {
    tapedIndex.value = index;
    // incrementItemCount();
  }

  // void incrementItemCount() {
  //   addItemRepo.addItemModel.itemCount++;
  // }

  RxList<CheckOutItemModel> cartItems = [
    CheckOutItemModel(
      itemId: 'itemId',
      itemName: 'Egg Roll',
      quantityInCart: '3',
      price: '60',
      totalItemPrice: '180',
      totalCartPrice: 'totalCartPrice',
      subTotal: '180',
      discount: '0',
      tax: '0',
    ),
    CheckOutItemModel(
      itemId: 'itemId',
      itemName: 'Hennessy',
      quantityInCart: '5',
      price: '100',
      totalItemPrice: '500',
      totalCartPrice: 'totalCartPrice',
      subTotal: '500',
      discount: '0',
      tax: '0',
    ),
    CheckOutItemModel(
      itemId: 'itemId',
      itemName: 'Meat Pie',
      quantityInCart: '2',
      price: '35',
      totalItemPrice: '70',
      totalCartPrice: 'totalCartPrice',
      subTotal: '70',
      discount: '0',
      tax: '0',
    ),
    CheckOutItemModel(
      itemId: 'itemId',
      itemName: 'Samusa',
      quantityInCart: '5',
      price: '60',
      totalItemPrice: '300',
      totalCartPrice: 'totalCartPrice',
      subTotal: '300',
      discount: '0',
      tax: '0',
    ),
  ].obs;

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

  List<CheckOutItemModel> convertCartItems(List cartFromDb) {
    List<CheckOutItemModel> result = [];
    for (var item in cartFromDb) {
      CheckOutItemModel.fromMap(item);
    }
    return result;
  }

  increamentItems(int index, int tapedIndex) {
    if (index == tapedIndex) {
      setTapedIndex(index);
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
