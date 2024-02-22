import 'package:hive/hive.dart';

class SalesItemModel {
  @HiveField(0)
  String itemId;
  @HiveField(1)
  String itemName;
  @HiveField(2)
  int quantityInCart;
  @HiveField(3)
  String itemPrice;
  @HiveField(4)
  String totalItemPrice;
  @HiveField(5)
  double subTotal;
  @HiveField(6)
  double discount;
  @HiveField(7)
  double tax;
  // @HiveField(8)
  // String itemCategory;
  // @HiveField(9)
  // String seller;
  // @HiveField(10)
  // String buyer;
  // @HiveField(11)
  // String salesId;
  // @HiveField(12)
  // String dateOfSale;
  // @HiveField(13)
  // String paymentMode;
  // @HiveField(14)
  // String salesChannel;
  // @HiveField(15)
  // String storeName;

  SalesItemModel({
    required this.itemId,
    required this.itemName,
    required this.itemPrice,
    required this.quantityInCart,
    required this.discount,
    required this.subTotal,
    required this.tax,
    required this.totalItemPrice,
    // required this.itemCategory,
    // required this.buyer,
    // required this.dateOfSale,
    // required this.paymentMode,
    // required this.salesChannel,
    // required this.salesId,
    // required this.seller,
    // required this.storeName,
  });

  factory SalesItemModel.fromMap(Map<String, dynamic> map) {
    return SalesItemModel(
      itemId: map['itemId'] ?? '',
      itemName: map['itemName'] ?? '',
      itemPrice: map['itemPrice'] ?? '',
      quantityInCart: map['quantityInCart'] ?? 0,
      discount: map['discount'] ?? 0,
      subTotal: map['subTotal'] ?? 0,
      tax: map['tax'] ?? 0,
      totalItemPrice: map['totalItemPrice'] ?? '',
      // itemCategory: map['itemCategory'] ?? '',
      // buyer: map['buyer'] ?? '',
      // dateOfSale: map['dateOfSale'] ?? '',
      // paymentMode: map['paymentMode'] ?? '',
      // salesChannel: map['salesChannel'] ?? '',
      // salesId: map['salesId'] ?? '',
      // seller: map['seller'] ?? '',
      // storeName: map['storeName'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "itemId": itemId,
      "itemName": itemName,
      "itemPrice": itemPrice,
      "quantityInCart": quantityInCart,
      "discount": discount,
      "subTotal": subTotal,
      "tax": tax,
      "totalItemPrice": totalItemPrice,
      // "itemCategory": itemCategory,
      // "buyer": buyer,
      // "dateOfSale": dateOfSale,
      // "paymentMode": paymentMode,
      // "salesChannel": salesChannel,
      // "salesId": salesId,
      // "seller": seller,
      // "storeName": storeName,
    };
  }
}
