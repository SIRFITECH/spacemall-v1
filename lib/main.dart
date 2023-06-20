import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spacemall/src/features/auth/screens/login/login.dart';
import 'package:spacemall/src/features/auth/data/auth_repo/auth_repo.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/file_adapter.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/item_list_data_adapter.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:spacemall/src/utils/themes/themes.dart';

import 'firebase_options.dart';
import 'src/features/core_app/profile/application/date_widget_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
    (value) {
      Get.put(
        AuthRepo(),
      );
      Get.put(
        DateFieldController(),
      );
    },
  );
  await Hive.initFlutter();
  Hive.registerAdapter(FileAdapter());
  Hive.registerAdapter(ItemListDataAdapter());
  Hive.registerAdapter(AddItemModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  stockItemBox = await Hive.openBox<AddItemModel>('item_list');
  cartBox = await Hive.openBox<CheckOutItemModel>('cart');
  userBox = await Hive.openBox<UserModel>('user');

  runApp(const SpacemallApp());
}

class SpacemallApp extends StatelessWidget {
  const SpacemallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      home: FutureBuilder<bool>(
        future: AuthRepo.instance.checkExistingUser(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return DashBoard();
            } else {
              return const Login();
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
