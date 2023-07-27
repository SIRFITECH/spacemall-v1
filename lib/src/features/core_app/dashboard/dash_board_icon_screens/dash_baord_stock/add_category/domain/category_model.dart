import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 5)
class CategoryModel {
  @HiveField(0)
  String categoryName;
  @HiveField(1)
  String itemName;
  @HiveField(2)
  String itemQuantity;
  @HiveField(3)
  String itemId;
  @HiveField(4)
  String categoryId;

  CategoryModel({
    required this.categoryName,
    required this.itemId,
    required this.categoryId,
    required this.itemName,
    required this.itemQuantity,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryName: map['categoryName'] ?? '',
      itemId: map['itemId'] ?? '',
      categoryId: map['categoryId'] ?? '',
      itemName: map['itemName'] ?? '',
      itemQuantity: map['itemQuantity'] ?? '',
    );
  }

  // populated to map, that is serializing the store object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "categoryName": categoryName,
      "itemId": itemId,
      "categoryId": categoryId,
      "itemName": itemName,
      "itemQuantity": itemQuantity,
    };
  }
}
