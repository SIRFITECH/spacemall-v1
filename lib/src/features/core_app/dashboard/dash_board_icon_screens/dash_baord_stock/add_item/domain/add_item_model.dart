import 'dart:io';
import 'package:hive/hive.dart';

part 'add_item_model.g.dart';

@HiveType(typeId: 1)
class AddItemModel {
  @HiveField(0)
  File? itemPic;
  @HiveField(1)
  String itemName;
  @HiveField(2)
  String itemCostPrice;
  @HiveField(3)
  String itemSellingPrice;
  @HiveField(4)
  // List<CategoryModel> itemCategory;
  String? itemCategory;
  @HiveField(5)
  String itemQuantity;
  @HiveField(6)
  bool trackProfit;
  @HiveField(7)
  bool trackLowStock;
  @HiveField(8)
  bool preventItemSalesWhenOutOfStock;
  @HiveField(9)
  String trackExpiry;
  @HiveField(10)
  String expiryAlert;
  @HiveField(11)
  int itemCount;
  @HiveField(12)
  String itemId;

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
    required this.itemCount,
    required this.itemId,
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
      itemCount: map['itemCount'] ?? 1,
      itemId: map['itemId'] ?? '',
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
      "itemCount": itemCount,
      "itemId": itemId,
    };
  }
}
