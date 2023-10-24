import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/domain/category_model.dart';

abstract class CategoryRemoteDataBaseAdapter {
  Future<void> saveCategoryToDB({
    required CategoryModel newCategory,
    required Function onSucess,
  });
}
