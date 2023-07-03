import 'dart:io';

import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';

class ReceiptsModel {
  File? logo;
  String storeName;
  String businessEmail;
  String businessPhone;
  DateTime date;
  String receiptNo; // start with 00000000, increament and convert to string
  String attendant;
  String receiptId;
  CartItemModel cart;

  ReceiptsModel({
    required this.logo,
    required this.storeName,
    required this.businessEmail,
    required this.businessPhone,
    required this.date,
    required this.receiptNo,
    required this.attendant,
    required this.receiptId,
    required this.cart,
  });

  // populated from map, that is serializing the stock object from server
  factory ReceiptsModel.fromMap(Map<String, dynamic> map) {
    return ReceiptsModel(
      logo: File(map['logo'] ?? ''),
      storeName: map['storeName'] ?? '',
      businessEmail: map['businessEmail'] ?? '',
      businessPhone: map['businessPhone'] ?? '',
      date: map['date'] ?? '',
      receiptNo: map['receiptNo'] ?? '',
      attendant: map['attendant'] ?? '',
      receiptId: map['receiptId'] ?? '',
      cart: map['receiptId'] ?? '',
    );
  }

  // populated to map, that is serializing the stock object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "logo": logo?.path,
      'storeName': storeName,
      "businessEmail": businessEmail,
      "businessPhone": businessPhone,
      "date": date,
      'receiptNo': receiptNo,
      "attendant": attendant,
      "receiptId": receiptId,
      "cart": cart,
    };
  }
}
