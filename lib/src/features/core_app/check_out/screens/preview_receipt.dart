import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/screens/stock.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/application/receipts_controller.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

class PreviewReceipt extends StatelessWidget {
  final pw.Document doc;

  const PreviewReceipt({
    super.key,
    required this.doc,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    // final brightness = media.platformBrightness;
    // final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final ProfileController profileController = Get.find();
    int receiptNo = ReceiptsController.instance.receiptNo.value;
    // ignore: unused_local_variable
    UserModel? user;

    StoreModel store = storeBox.get(
      AddItemRepo.instance.currentStore.value,
      defaultValue: StoreModel(
        logoLocalPath: '',
        logoRemotePath: '',
        storeName: '',
        bankName: '',
        accountNumber: '',
        contact: '',
        stock: RxList([]),
        receipts: [],
        debts: [],
        staff: [],
        sales: [],
        customer: [],
        storeId: '',
        categories: [],
      ),
    );
// DateTime date =
    return FutureBuilder<UserModel?>(
        future: profileController.getUserDataFromHive(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If the Future is still running, show a loading indicator or placeholder
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // If there's an error fetching the user data, handle it here
            spaceMallSnackBar(
              'Error Fetching User',
              'Error getting user data from Device: ${snapshot.error}',
              kWhiteLight,
              kRedColor,
            );
            return Container();
          } else {
            // If the Future is complete and user data is available
            user = snapshot.data;
          }

          //  UserModel? user = await userBox.get('user_profile');
          if (snapshot.hasData) {
            // print('we have ${user!.stores.length + 1} stores');
            // print(snapshot.data!.stores);
          } else {
            // print('No store detected');
          }

          return Scaffold(
            // appBar: MyAppBar(
            //   isDarkMood: isDarkMood,
            //   title: 'Share Receipt',
            //   automaticallyImplyLeading: false,
            // ),
            body: SafeArea(
              top: true,
              child: PdfPreview(
                build: (format) => doc.save(),
                allowSharing: true,
                allowPrinting: true,
                initialPageFormat: PdfPageFormat.a4,
                pdfFileName: '${store.storeName}_receipt_$receiptNo.pdf.pdf',
                // onShared: (context) {
                //   print('shared ');
                // },
              ),
            ),
            floatingActionButton: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              width: screenSize.width * 0.4,
              height: screenSize.height * 0.11,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.off(() => Stock());
                  },
                  child: const Text(
                    kCompletedText,
                    style: TextStyle(
                      fontSize: kBodyTextFont,
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
          );
        });
  }
}
