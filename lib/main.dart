import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/auth/application/login_controller/login_controller.dart';
import 'package:spacemall/src/features/auth/application/otp_controller/otp_controller.dart';
import 'package:spacemall/src/features/auth/data/auth_repo/auth_repo.dart';
import 'package:spacemall/src/features/auth/screens/splash_screen/splash_screen.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/application/add_category_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/domain/category_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/application/add_item_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_modifier/application/add_modifier_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/application/stock_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_customers/domain/customer_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_debts/domain/debts_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_reports/application/report_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/application/sales_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/domain/sales_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_shopfront/application/store_front_controller.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';
import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:spacemall/src/repository/spacial_adotpters.dart';
import 'package:spacemall/src/utils/themes/themes.dart';

import 'firebase_options.dart';
import 'src/features/auth/application/splash_controller/splash_controller.dart';
import 'src/features/core_app/profile/application/date_widget_controller.dart';
import 'src/features/core_app/profile/application/profile_controller.dart';
import 'src/features/core_app/profile/data/profile_repo.dart';

void main() async {
  // final Brightness brightness =
  //     WidgetsBinding.instance.window.platformBrightness;

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        systemNavigationBarColor:
            //  brightness == Brightness.light
            //     ?
            kDarkModeBackgroundColor
        // : kLightModeBackgroundColor
        ),
  );

  //  MediaQuery.of(context).platformBrightness == Brightness.light
  //               ? kDarkModeBackgroundColor
  //               : kLightModeBackgroundColor
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FileAdapter()); // typeId = 0
  Hive.registerAdapter(RxIntAdapter()); // typeId = 6
  Hive.registerAdapter(RxDoubleAdapter()); // typeId = 12
  Hive.registerAdapter(AddItemModelAdapter()); // typeId = 10
  Hive.registerAdapter(ItemListDataAdapter()); // typeId = 1
  Hive.registerAdapter(UserModelAdapter()); // typeId = 3
  Hive.registerAdapter(StoreModelAdapter()); //  typeId = 4
  Hive.registerAdapter(CategoryModelAdapter()); // typeId = 5
  Hive.registerAdapter(CustomerModelAdapter()); // typeId = 8
  Hive.registerAdapter(DebtsModelAdapter()); // typeId = 7
  Hive.registerAdapter(ReceiptsModelAdapter()); // typeId = 2
  Hive.registerAdapter(SalesModelAdapter()); // typeId = 11
  Hive.registerAdapter(CartItemModelAdapter()); // typeId = 9

  stockBox = await Hive.openBox<AddItemModel>('item_list'); // typeId: 10
  receiptsBox = await Hive.openBox<ReceiptsModel>('receipt'); // typeId: 2
  userBox = await Hive.openBox<UserModel>('user'); // typeId: 3
  storeBox = await Hive.openBox<StoreModel>('store'); // typeId: 4
  receiptsBox = await Hive.openBox<CategoryModel>('category'); // typeId: 5
  customersBox = await Hive.openBox<CustomerModel>('customers'); // typeId: 8
  salesBox = await Hive.openBox<SalesModel>('sales'); // typeId: 11
  debtsBox = await Hive.openBox<CustomerModel>('debts'); // typeId: 8
  cartBox = await Hive.openBox<CartItemModel>('cart'); // typeId: 9
  appBox = await Hive.openBox('spacemall');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
    (value) {
      Get.put(
        AddItemController(),
      );
      Get.put(
        AddItemRepo(),
      );

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
        SalesController(),
      );
      Get.put(
        ReportsController(),
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

  runApp(const SpacemallApp());
}

class SpacemallApp extends StatelessWidget {
  static final ValueNotifier<ThemeData> themeNotifier =
      ValueNotifier(SAppTheme.lightTheme);

  const SpacemallApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeController = Get.put(ThemeController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode:
          // themeController.theme,
          ThemeMode.system,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 10),
      // initialBinding: SpaceMallBinding(),

      // initialRoute: '/',
      // onInit: () async {
      //   bool isExistingUser = await AuthRepo.instance.checkExistingUser();
      //   if (isExistingUser) {
      //     Get.offNamed('/dashboard');
      //   } else {
      //     Get.offNamed('/');
      //   }
      // },
      // getPages: [
      //   GetPage(name: '/', page: () => const ChooseUserType()),
      //   GetPage(
      //       name: '/dashboard',
      //       page: () => DashBoard(),
      //       middlewares: [SpaceMallMiddleWare1()]),
      // ],

      home: FutureBuilder<bool>(
        future: AuthRepo.instance.checkExistingUser(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return ShowCaseWidget(
                builder: Builder(
                  builder: (context) => DashBoard(),
                ),
              );
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
