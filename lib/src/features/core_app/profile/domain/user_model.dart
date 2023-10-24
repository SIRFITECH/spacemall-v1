import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:spacemall/src/features/core_app/check_out/application/cart_item_controller.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 3)
class UserModel {
  @HiveField(0)
  String profilePicLocalPath;
  @HiveField(1)
  String userName;
  @HiveField(2)
  String email;
  @HiveField(3)
  String contactNumber;
  @HiveField(4)
  String role;
  @HiveField(5)
  String uid;
  @HiveField(6)
  String country;
  @HiveField(7)
  String bio;
  @HiveField(8)
  List<CartItemModel> cart;
  @HiveField(9)
  RxList<StoreModel> stores;
  @HiveField(10)
  String createdAt;
  @HiveField(11)
  String profilePicRemotePath;

  UserModel({
    required this.profilePicLocalPath,
    required this.userName,
    required this.email,
    required this.contactNumber,
    required this.uid,
    required this.role,
    required this.bio,
    required this.cart,
    required this.stores,
    required this.country,
    required this.createdAt,
    required this.profilePicRemotePath,
  });

  // populated from map, that is serializing the user object from server
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      cart: CartItemController.instance.convertCartItems(map['cart'] ?? []),
      stores:
          RxList(StoreController.instance.convertStores(map['stores'] ?? [])),
      profilePicLocalPath: map['profilePicLocalPath'] ?? '',
      userName: map['userName'] ?? '',
      email: map['email'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
      country: map['country'] ?? '',
      role: map['role'] ?? '',
      uid: map['uid'] ?? '',
      bio: map['bio'] ?? '',
      createdAt: map['createdAt'] ?? '',
      profilePicRemotePath: map['profilePicLocalPath'] ?? '',
    );
  }

  // populated to map, that is serializing the user object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "cart": cart,
      'stores': stores,
      "profilePicLocalPath": profilePicLocalPath,
      "userName": userName,
      "email": email,
      "contactNumber": contactNumber,
      "country": country,
      "role": role,
      "uid": uid,
      "bio": bio,
      "createdAt": createdAt,
      "profilePicRemotePath": profilePicRemotePath,
    };
  }
}
