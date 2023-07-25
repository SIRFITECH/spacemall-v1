import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spacemall/src/features/auth/application/login_controller/login_controller.dart';
import 'package:spacemall/src/features/auth/application/otp_controller/otp_controller.dart';
import 'package:spacemall/src/features/auth/data/auth_repo/auth_repo.dart';
import 'package:spacemall/src/features/auth/screens/splash_screen/splash_screen.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/application/add_category_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/domain/category_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/application/add_item_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/file_adapter.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/item_list_data_adapter.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_modifier/application/add_modifier_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/application/stock_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_customers/domain/customer_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_debts/domain/debts_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/domain/sales_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_shopfront/application/store_front_controller.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';
import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:spacemall/src/utils/themes/themes.dart';

import 'firebase_options.dart';
import 'src/features/auth/application/splash_controller/splash_controller.dart';
import 'src/features/core_app/profile/application/date_widget_controller.dart';
import 'src/features/core_app/profile/application/profile_controller.dart';
import 'src/features/core_app/profile/data/profile_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
    (value) {
      Get.put(
        StoreRepo(),
      );

      final StoreRepo storeRepo = StoreRepo();
      final StoreController storeController =
          StoreController(storeRepo: storeRepo);
      storeRepo.storeController = storeController;
      Get.put(
        StoreController(storeRepo: storeRepo),
      );
      Get.put(
        AddItemController(),
      );
      Get.put(
        AuthRepo(),
      );
      Get.put(
        SplashController(),
      );
      Get.put(
        LoginController(),
      );
      Get.put(
        ProfileController(),
      );
      Get.put(
        ProfileRepo(),
      );
      Get.put(
        DateFieldController(),
      );
      Get.put(
        OtpController(),
      );

      Get.put(
        ShopFrontController(),
      );
      Get.put(
        AddCategoryController(),
      );
      Get.put(
        AddModifierController(),
      );
      Get.put(
        StockController(),
      );
    },
  );

  await Hive.initFlutter();
  Hive.registerAdapter(FileAdapter());
  Hive.registerAdapter(ItemListDataAdapter());
  Hive.registerAdapter(AddItemModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(StoreModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(CustomerModelAdapter());
  Hive.registerAdapter(DebtsModelAdapter());
  Hive.registerAdapter(ReceiptsModelAdapter());
  Hive.registerAdapter(SalesModelAdapter());
  stockBox = await Hive.openBox<AddItemModel>('item_list');
  cartBox = await Hive.openBox<CartItemModel>('cart');
  userBox = await Hive.openBox<UserModel>('user');
  storeBox = await Hive.openBox<StoreModel>('store');
  receiptsBox = await Hive.openBox<ReceiptsModel>('receipt');
  receiptsBox = await Hive.openBox<CategoryModel>('category');
  customersBox = await Hive.openBox<CustomerModel>('customers');
  salesBox = await Hive.openBox<SalesModel>('sales');
  debtsBox = await Hive.openBox<CustomerModel>('debts');

  runApp(const SpacemallApp());
}

class SpacemallApp extends StatelessWidget {
  static final ValueNotifier<ThemeData> themeNotifier =
      ValueNotifier(SAppTheme.lightTheme);

  const SpacemallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 50),
      home: FutureBuilder<bool>(
        future: AuthRepo.instance.checkExistingUser(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return DashBoard();
            } else {
              return const ChooseUserType();
            }
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

// class SpacemallApp extends StatelessWidget {
//   static final ValueNotifier<ThemeData> themeNotifier =
//       ValueNotifier(SAppTheme.lightTheme);

//   const SpacemallApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<ThemeData>(
//       valueListenable: themeNotifier,
//       builder: (_, ThemeData currentTheme, __) {
//         return GetMaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: currentTheme,
//           darkTheme: SAppTheme.darkTheme,
//           themeMode: ThemeMode.system,
//           defaultTransition: Transition.leftToRightWithFade,
//           transitionDuration: const Duration(milliseconds: 50),
//           home: FutureBuilder<bool>(
//             future: AuthRepo.instance.checkExistingUser(),
//             builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//               if (snapshot.hasData) {
//                 if (snapshot.data!) {
//                   return DashBoard();
//                 } else {
//                   return const Login();
//                 }
//               }
//               return const Scaffold(
//                 body: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
