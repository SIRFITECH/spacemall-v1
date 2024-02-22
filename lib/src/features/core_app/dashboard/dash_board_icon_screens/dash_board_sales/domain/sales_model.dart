import 'package:hive/hive.dart';

part 'sales_model.g.dart';

@HiveType(typeId: 11)
class SalesModel {
  @HiveField(0)
  String saleId;
  @HiveField(1)
  String attendant;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  List<dynamic> cart;
  @HiveField(4)
  String customerName;
  @HiveField(5)
  String cartTotal;
  @HiveField(6)
  String storeName;
  @HiveField(7)
  String subTotal;
  @HiveField(8)
  String discount;
  @HiveField(9)
  String tax;
  @HiveField(10)
  String paymentMode;
  @HiveField(11)
  String salesChannel;
  // @HiveField(7)
  // int quantityInCart;
  // @HiveField(8)
  // String itemPrice;
  // @HiveField(9)
  // String totalItemPrice;

  SalesModel({
    required this.saleId,
    required this.attendant,
    required this.date,
    required this.cart,
    required this.customerName,
    required this.cartTotal,
    required this.storeName,
    required this.discount,
    required this.paymentMode,
    required this.salesChannel,
    required this.subTotal,
    required this.tax,
  });

  // populated from map, that is serializing the stock object from server
  factory SalesModel.fromMap(Map<String, dynamic> map) {
    return SalesModel(
      saleId: map['saleId'] ?? '',
      attendant: map['attendant'] ?? '',
      date: map['date'] ?? '',
      cart: map['cart'] ?? [],
      customerName: map['customerName'] ?? '',
      cartTotal: map['cartTotal'] ?? '',
      storeName: map['storeName'] ?? '',
      discount: map['discount'] ?? 0,
      // itemPrice: map['itemPrice'] ?? '',
      paymentMode: map['paymentMode'] ?? '',
      // quantityInCart: map['quantityInCart'] ?? 0,
      salesChannel: map['salesChannel'] ?? '',
      subTotal: map['subTotal'] ?? 0,
      tax: map['tax'] ?? 0,
      // totalItemPrice: map['totalItemPrice'] ?? '',
    );
  }

  // populated to map, that is serializing the user object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "attendant": attendant,
      "saleId": saleId,
      "date": date,
      "cart": cart,
      "customerName": customerName,
      "cartTotal": cartTotal,
      "storeName": storeName,
      "discount": discount,
      // "itemPrice": itemPrice,
      "paymentMode": paymentMode,
      // "quantityInCart": quantityInCart,
      "salesChannel": salesChannel,
      " subTotal": subTotal,
      "tax": tax,
      // "totalItemPrice": totalItemPrice,
    };
  }
}
