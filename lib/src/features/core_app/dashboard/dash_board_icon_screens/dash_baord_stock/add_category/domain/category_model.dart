import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 4)
class CategoryModel {
  @HiveField(0)
  String categoryName;

  CategoryModel({required this.categoryName});

  // populated from map, that is serializing the user object from server
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(categoryName: map['role'] ?? '');
  }

  // populated to map, that is serializing the user object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "categoryName": categoryName,
    };
  }
}
