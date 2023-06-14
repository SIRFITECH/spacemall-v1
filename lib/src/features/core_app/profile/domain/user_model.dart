import 'package:hive_flutter/adapters.dart';
import 'package:spacemall/src/features/core_app/check_out/application/check_out_controller.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 3)
class UserModel {
  @HiveField(0)
  // File? profilePic;
  String profilePic;
  @HiveField(1)
  String firstName;
  @HiveField(2)
  String lastName;
  @HiveField(3)
  String email;
  @HiveField(4)
  String gender;
  @HiveField(5)
  String contactNumber;
  @HiveField(6)
  String whatsappNumber;
  @HiveField(7)
  String homeAddress;
  @HiveField(8)
  String state;
  @HiveField(9)
  String city;
  @HiveField(10)
  String country;
  @HiveField(11)
  String zipCode;
  @HiveField(12)
  String bio;
  @HiveField(13)
  String uid;
  @HiveField(14)
  String role;
  @HiveField(15)
  List<CheckOutItemModel> cart;

  UserModel({
    required this.profilePic,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.contactNumber,
    required this.whatsappNumber,
    required this.homeAddress,
    required this.zipCode,
    required this.state,
    required this.city,
    required this.country,
    required this.bio,
    required this.uid,
    required this.role,
    required this.cart,
  });

  // populated from map, that is serializing the user object from server
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      cart: CheckOutItemController.instance.convertCartItems(map['cart'] ?? []),
      // profilePic: File(map['profilePic'] ?? ''),
      profilePic: map['profilePic'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
      whatsappNumber: map['whatsappNumber'] ?? '',
      homeAddress: map['homeAddress'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      zipCode: map['zipCode'] ?? '',
      bio: map['bio'] ?? '',
      role: map['role'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  // populated to map, that is serializing the user object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "cart": cart,
      "profilePic": profilePic,
      // "profilePic": profilePic?.path,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "gender": gender,
      "contactNumber": contactNumber,
      "whatsappNumber": whatsappNumber,
      "homeAddress": homeAddress,
      "state": state,
      "city": city,
      "country": country,
      "zipCode": zipCode,
      "bio": bio,
      "role": role,
      "uid": uid,
    };
  }
}
