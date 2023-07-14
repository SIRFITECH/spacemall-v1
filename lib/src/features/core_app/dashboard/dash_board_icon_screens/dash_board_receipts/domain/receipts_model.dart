import 'dart:io';

import 'package:hive/hive.dart';

part 'receipts_model.g.dart';

@HiveType(typeId: 10)
class ReceiptsModel {
  @HiveField(0)
  File? logo;
  @HiveField(1)
  String storeName;
  @HiveField(2)
  String businessEmail;
  @HiveField(3)
  String businessPhone;
  @HiveField(4)
  DateTime date;
  @HiveField(5)
  String receiptNo; // start with 00000000, increament and convert to string
  @HiveField(6)
  String attendant;
  @HiveField(7)
  String receiptId;
  @HiveField(8)
  String cartId;

  ReceiptsModel({
    required this.logo,
    required this.storeName,
    required this.businessEmail,
    required this.businessPhone,
    required this.date,
    required this.receiptNo,
    required this.attendant,
    required this.receiptId,
    required this.cartId,
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
      cartId: map['cartId'] ?? '',
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
      "cartId": cartId,
    };
  }
}
