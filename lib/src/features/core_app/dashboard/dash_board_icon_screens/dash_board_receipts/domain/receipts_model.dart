import 'dart:io';
import 'package:hive/hive.dart';

import '../../../../check_out/domain/check_out_item_model.dart';
part 'receipts_model.g.dart';

@HiveType(typeId: 2)
class ReceiptsModel {
  @HiveField(0)
  File? logo;
  @HiveField(1)
  String customerName;
  @HiveField(2)
  String businessEmail;
  @HiveField(3)
  String cartTotal;
  @HiveField(4)
  DateTime date;
  @HiveField(5)
  String receiptNo;
  @HiveField(6)
  String attendant;
  @HiveField(7)
  String receiptId;
  @HiveField(8)
  String cartId;
  @HiveField(9)
  String itemsInCart;
  @HiveField(11)
  String paymentMethod;
  @HiveField(12)
  String staffId;
  @HiveField(13)
  List<CartItemModel> cart;

  ReceiptsModel({
    required this.logo,
    required this.customerName,
    required this.businessEmail,
    required this.cartTotal,
    required this.date,
    required this.receiptNo,
    required this.attendant,
    required this.receiptId,
    required this.cartId,
    required this.itemsInCart,
    required this.paymentMethod,
    required this.staffId,
    required this.cart,
  });

  // populated from map, that is serializing the stock object from server
  factory ReceiptsModel.fromMap(Map<String, dynamic> map) {
    return ReceiptsModel(
      logo: File(map['logo'] ?? ''),
      customerName: map['customerName'] ?? '',
      businessEmail: map['businessEmail'] ?? '',
      cartTotal: map['cartTotal'] ?? '',
      date: map['date'] ?? '',
      receiptNo: map['receiptNo'] ?? '',
      attendant: map['attendant'] ?? '',
      receiptId: map['receiptId'] ?? '',
      cartId: map['cartId'] ?? '',
      itemsInCart: map['itemsInCart'] ?? '',
      paymentMethod: map['paymentMethod'] ?? '',
      staffId: map['staffId'] ?? '',
      cart: map['cart'] ?? [],
    );
  }

  // populated to map, that is serializing the stock object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "logo": logo?.path,
      'customerName': customerName,
      "businessEmail": businessEmail,
      "cartTotal": cartTotal,
      "date": date,
      'receiptNo': receiptNo,
      "attendant": attendant,
      "receiptId": receiptId,
      "cartId": cartId,
      "itemsInCart": itemsInCart,
      "paymentMethod": paymentMethod,
      "staffId": staffId,
      "cart": cart,
    };
  }
}
