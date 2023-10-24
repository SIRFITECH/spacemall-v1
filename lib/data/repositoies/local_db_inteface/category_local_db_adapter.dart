import '../../../src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/domain/category_model.dart';

abstract class CategoryLocalDataBaseAdapter {
 
  Future<void> saveCategoryToDevice(
    CategoryModel newCategory,
  );
}
