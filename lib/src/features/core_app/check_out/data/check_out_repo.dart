import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/features/core_app/profile/data/profile_repo.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:uuid/uuid.dart';

class CheckOutRepo extends GetxController {
  static CheckOutRepo get instance => Get.put(
        CheckOutRepo(),
      );
  // final CheckOutRepo checkOutRepo = Get.put(CheckOutRepo());
  // ProfileController profileController = Get.find();
  String itemId = const Uuid().v4();

  // UserModel? _userModel;
  // UserModel get userModel {
  //   return _userModel ??
  //       UserModel(
  //           cart: [],
  //           profilePic: '',
  //           firstName: profileController.tFName.text.trim(),
  //           lastName: profileController.tLName.text.trim(),
  //           email: profileController.tEmail.text.trim(),
  //           gender: profileController.selectedGender.value,
  //           contactNumber: profileController.tContact.text.trim(),
  //           whatsappNumber: profileController.tWhatsApp.text.trim(),
  //           homeAddress: profileController.tHomeAddress.text.trim(),
  //           zipCode: profileController.tZipCode.text.trim(),
  //           state: profileController.tState.text.trim(),
  //           city: profileController.tCity.text.trim(),
  //           country: profileController.tCountry.text.trim(),
  //           bio: profileController.tBio.text.trim(),
  //           uid: '');
  // }

  // CheckOutModel newCartItem = CheckOutModel(
  //     itemId: itemId,
  //     itemPic: itemPic,
  //     itemName: itemName,
  //     itemQuantity: itemQuantity,
  //     price: price,
  //     totalPrice: totalPrice);

  // // create a new item
  // AddItemModel newItem = AddItemModel(
  //   itemPic: addItemController.itemPic.value,
  //   itemName: addItemController.itemName.text.trim(),
  //   itemSellingPrice: addItemController.sellingPrice.text.trim(),
  //   itemCategory: addItemController.categoryValue.value,
  //   itemQuantity: addItemController.stockAvailable.text.trim(),
  //   itemCostPrice: addItemController.costPrice.text.trim(),
  //   trackProfit: addItemController.trackProfit.value,
  //   trackLowStock: addItemController.trackLowStock.value,
  //   preventItemSalesWhenOutOfStock:
  //       addItemController.preventItemSalesWhenOutOfStock.value,
  //   trackExpiry: addItemController.trackExpiry.text.trim(),
  //   expiryAlert: addItemController.expiryAlert.text.trim(),
  //   itemCount: 0,
  // );

  void addProductToCart(
      // AddItemModel newItem
      ) async {
    UserModel? userModel = await ProfileRepo.instance.getProfileDataFromPhone();

    print(userModel!.uid);
    // try {
    //   // check if item is already added
    //   if (isItemAlreadyAdded(newItem)) {
    //     Get.snackbar(
    //         'Check your cart', '${newItem.itemName} is already added to cart');
    //   } else {
    //     // profileController.updateUserData(_checkOutModel)
    //      UserModel? userModel = await profileRepo.getProfileDataFromPhone();
    //     Get.snackbar('Item add to cart',
    //         '${newItem.itemName} is added to cart successfully');
    //   }
    // } catch (e) {}
    // ;
  }

  // CheckOutModel? _checkOutModel;
  // CheckOutModel get checkOutModel {
  //   return _checkOutModel ??
  //       CheckOutModel(
  //         itemId: itemId,
  //         itemPic: itemPic,
  //         itemName: itemName,
  //         itemQuantity: itemQuantity,
  //         price: price,
  //         totalPrice: totalPrice,
  //       );
  // }
}
