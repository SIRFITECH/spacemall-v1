import 'package:spacemall/src/features/core_app/check_out/application/check_out_controller.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';

class UserModel {
  String profilePic;
  String firstName;
  String lastName;
  String email;
  String gender;
  String contactNumber;
  String whatsappNumber;
  String homeAddress;
  String state;
  String city;
  String country;
  String zipCode;
  String bio;
  String uid;
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
    required this.cart,
  });

  // populated from map, that is serializing the user object from server
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      cart: CheckOutItemController.instance.convertCartItems(map['cart'] ?? []),
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
      uid: map['uid'] ?? '',
    );
  }

  // populated to map, that is serializing the user object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "cart": cart,
      "profilePic": profilePic,
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
      "uid": uid,
    };
  }
}
