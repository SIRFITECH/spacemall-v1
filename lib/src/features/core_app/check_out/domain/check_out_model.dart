import 'dart:io';

class CheckOutModel {
  String itemId;
  File? itemPic;
  String itemName;
  String itemQuantity;
  String price;
  String totalPrice;

  CheckOutModel({
    required this.itemId,
    required this.itemPic,
    required this.itemName,
    required this.itemQuantity,
    required this.price,
    required this.totalPrice,
  });

  // populated from map, that is serializing the stock object from server
  factory CheckOutModel.fromMap(Map<String, dynamic> map) {
    return CheckOutModel(
      itemId: map['itemId'] ?? '',
      itemPic: File(map['itemPic'] ?? ''),
      itemName: map['itemName'] ?? '',
      itemQuantity: map['itemQuantity'] ?? '',
      price: map['price'] ?? '',
      totalPrice: map['totalPrice'] ?? 0,
    );
  }

  // populated to map, that is serializing the user object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "itemPic": itemPic?.path,
      "itemName": itemName,
      "itemId": itemId,
      "itemQuantity": itemQuantity,
      "price": price,
      "totalPrice": totalPrice,
    };
  }
}
