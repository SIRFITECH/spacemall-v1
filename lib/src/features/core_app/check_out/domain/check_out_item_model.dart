import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hive/hive.dart';

part 'check_out_item_model.g.dart';

@HiveType(typeId: 9)
class CartItemModel {
  @HiveField(0)
  String itemId;
  @HiveField(1)
  String itemName;
  @HiveField(2)
  RxInt quantityInCart;
  @HiveField(3)
  String price;
  @HiveField(4)
  String totalItemPrice;
  @HiveField(5)
  RxDouble subTotal;
  @HiveField(6)
  double discount;
  @HiveField(7)
  double tax;

  CartItemModel({
    required this.itemId,
    required this.itemName,
    required this.quantityInCart,
    required this.price,
    required this.totalItemPrice,
    required this.subTotal,
    required this.discount,
    required this.tax,
  });

  // populated from map, that is serializing the stock object from server
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      itemId: map['itemId'] ?? '',
      itemName: map['itemName'] ?? '',
      quantityInCart: map['quantityInCart'] ?? 0,
      price: map['price'] ?? '0.0',
      totalItemPrice: map['totalItemPrice'] ?? '0.0',
      subTotal: map['subTotal'] ?? '0.0',
      discount: map['discount'] ?? '0.0',
      tax: map['tax'] ?? ' 0.0',
    );
  }

  // populated to map, that is serializing the user object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "itemName": itemName,
      "itemId": itemId,
      "quantityInCart": quantityInCart,
      "price": price,
      "totalItemPrice": totalItemPrice,
      "subTotal": subTotal,
      "discount": discount,
      "tax": tax,
    };
  }
}
