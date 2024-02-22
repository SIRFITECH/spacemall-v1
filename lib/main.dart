import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/features/auth/application/login_controller/login_controller.dart';
import 'package:spacemall/src/features/auth/application/otp_controller/otp_controller.dart';
import 'package:spacemall/src/features/auth/data/auth_repo/auth_repo.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
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
import 'package:spacemall/src/features/core_app/main/spacemall.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';
import 'package:spacemall/src/features/core_app/store/data/store_repo.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:spacemall/src/repository/spacial_adotpters.dart';

import 'firebase_options.dart';
import 'src/features/auth/application/splash_controller/splash_controller.dart';
import 'src/features/core_app/profile/application/date_widget_controller.dart';
import 'src/features/core_app/profile/application/profile_controller.dart';
import 'src/features/core_app/profile/data/profile_repo.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        systemNavigationBarColor: kDarkModeBackgroundColor),
  );

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

  receiptsBox = await Hive.openBox<ReceiptsModel>('receipt'); // typeId: 2
  userBox = await Hive.openBox<UserModel>('user'); // typeId: 3
  storeBox = await Hive.openBox<StoreModel>('store'); // typeId: 4
  receiptsBox = await Hive.openBox<CategoryModel>('category'); // typeId: 5
  customersBox = await Hive.openBox<CustomerModel>('customers'); // typeId: 8
  salesBox = await Hive.openBox<ReceiptsModel>('sales'); // typeId: 11
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
        ProfileController(),
      );
      Get.put(
        AuthRepo(
            FirebaseAuth.instance,
            userBox.get(
              'user',
              defaultValue: UserModel(
                  cart: [],
                  stores: RxList([]),
                  profilePicLocalPath: '',
                  bio: '',
                  createdAt: '',
                  email: '',
                  contactNumber: '',
                  country: '',
                  role: '',
                  uid: '',
                  userName: '',
                  profilePicRemotePath: '',
                  storeUIDs: []),
            )),
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
        SplashController(),
      );
      Get.put(
        LoginController(),
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
        AddModifierController(),
      );
      Get.put(
        StockController(),
      );
    },
  );
  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );

  // for crash analytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(
    const SpacemallApp(),
  );
}
