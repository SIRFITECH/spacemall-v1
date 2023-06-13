import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/profile/data/profile_repo.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';

class CheckOutItemController extends GetxController {
  static CheckOutItemController get instance => Get.put(
        CheckOutItemController(),
      );
  final profileRepo = Get.put(ProfileRepo());

  int numberOfItemSelect = -1;

  RxBool isSelected = false.obs;
  RxInt totalCartPrice = 0.obs;

  // first attempt to render based on variable change,
  // starting with tapedIndex

  RxInt tapedIndex = (-1).obs;
  RxInt items = 0.obs;

  void setTapedIndex(int index) {
    tapedIndex.value = index;
  }

  RxList<CheckOutItemModel> cartItems = <CheckOutItemModel>[].obs;

  removeItemFromCart(
    int index,
  ) {
    cartItems.removeAt(index);
  }

  UserModel? _userModel;
  UserModel get userModel {
    return _userModel ??
        UserModel(
          profilePic: '',
          firstName: '',
          lastName: '',
          email: '',
          gender: '',
          contactNumber: '',
          whatsappNumber: '',
          homeAddress: '',
          zipCode: '',
          state: '',
          city: '',
          country: '',
          bio: '',
          uid: '',
          cart: <CheckOutItemModel>[],
        );
  }

  addToCart(
    CheckOutItemModel newItem,
    int index,
    BuildContext context,
  ) async {
    String id = cartItems.length > index ? cartItems[index].itemId : '';
    // UserModel? user =  _userModel ?? await profileRepo.getProfileDataFromPhone();
    // UserModel? phoneUser = await profileRepo.getProfileDataFromPhone();
    if (!itemExistInCart(newItem, id)) {
      UserModel? user;
      // user = UserModel(
      //   profilePic: '',
      //   firstName: '',
      //   lastName: '',
      //   email: '',
      //   gender: '',
      //   contactNumber: '',
      //   whatsappNumber: '',
      //   homeAddress: '',
      //   zipCode: '',
      //   state: '',
      //   city: '',
      //   country: '',
      //   bio: '',
      //   uid: '',
      //   cart: <CheckOutItemModel>[],
      // );

      if (_userModel == null) {
        user = await profileRepo.getProfileDataFromPhone();
        // user!.cart.add(newItem);
        // cartItems.value = user.cart;
        // print('User cart has ${user.cart.length} items');
        print(user);
        Get.snackbar(
          'Operation Successful',
          'Item added to cart succeffuly',
          backgroundColor: kWhiteLight,
        );
      } else {
        user = _userModel;
        user!.cart.add(newItem);
        cartItems.value = user.cart;
        print('User cart has ${user.cart.length} items');
      }
    } else {
      Get.snackbar(
        '1 more ${cartItems[index].itemName} add to cart',
        'If you want to delete ${cartItems[index].itemName} from cart just presse and hold',
        backgroundColor: kWhiteLight,
      );
    }
  }

  bool itemExistInCart(CheckOutItemModel newItem, String id) {
    for (CheckOutItemModel item in cartItems) {
      if (item.itemId == id) {
        return true;
      }
    }
    return false;
  }

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
    }
  }

  setSelected(int index, int tapedIndex) {
    if (index == tapedIndex) {
      isSelected.value = true;
      update();
    }
  }
}
