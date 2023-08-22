import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';

part 'category_model.g.dart';

@HiveType(typeId: 5)
class CategoryModel {
  @HiveField(0)
  String categoryName;
  @HiveField(1)
  RxList<AddItemModel> items;
  @HiveField(2)
  RxInt itemsInCategory;
  @HiveField(3)
  String categoryId;

  CategoryModel({
    required this.categoryName,
    required this.categoryId,
    required this.items,
    required this.itemsInCategory,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryName: map['categoryName'] ?? '',
      categoryId: map['categoryId'] ?? '',
      items: map['items'] ?? '',
      itemsInCategory: map['itemsInCategory'] ?? '',
    );
  }

  // populated to map, that is serializing the store object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "categoryName": categoryName,
      "categoryId": categoryId,
      "items": items,
      "itemsInCategory": itemsInCategory,
    };
  }
}
