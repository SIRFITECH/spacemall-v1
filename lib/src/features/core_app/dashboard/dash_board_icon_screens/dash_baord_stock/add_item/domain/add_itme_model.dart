import 'dart:io';

class AddItemModel {
  File? itemPic;
  String itemName;
  String itemCostPrice;
  String itemSellingPrice;
  String itemCategory;
  String itemQuantity;
  bool trackProfit;
  bool trackLowStock;
  bool preventItemSalesWhenOutOfStock;
  String trackExpiry;
  String expiryAlert;

  AddItemModel({
    required this.itemPic,
    required this.itemName,
    required this.itemSellingPrice,
    required this.itemCategory,
    required this.itemQuantity,
    required this.itemCostPrice,
    required this.trackProfit,
    required this.trackLowStock,
    required this.preventItemSalesWhenOutOfStock,
    required this.trackExpiry,
    required this.expiryAlert,
  });
  // populated from map, that is serializing the stock object from server
  factory AddItemModel.fromMap(Map<String, dynamic> map) {
    return AddItemModel(
      itemPic: File(map['itemPic'] ?? ''),
      itemName: map['itemName'] ?? '',
      itemSellingPrice: map['itemSellingPrice'] ?? '',
      itemCategory: map['itemCategory'] ?? '',
      itemQuantity: map['itemQuantity'] ?? '',
      itemCostPrice: map['itemCostPrice'] ?? '',
      trackProfit: map['trackProfit'] ?? '',
      trackLowStock: map['trackLowStock'] ?? '',
      preventItemSalesWhenOutOfStock:
          map['preventItemSalesWhenOutOfStock'] ?? '',
      trackExpiry: map['trackExpiry'] ?? '',
      expiryAlert: map['expiryAlert'] ?? '',
    );
  }

  // populated to map, that is serializing the user object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "itemPic": itemPic?.path,
      "itemName": itemName,
      "itemSellingPrice": itemSellingPrice,
      "itemCategory": itemCategory,
      "itemQuantity": itemQuantity,
      "itemCostPrice": itemCostPrice,
      "trackProfit": trackProfit,
      "trackLowStock": trackLowStock,
      "preventItemSalesWhenOutOfStock": preventItemSalesWhenOutOfStock,
      "trackExpiry": trackExpiry,
      "expiryAlert": expiryAlert,
    };
  }
}
