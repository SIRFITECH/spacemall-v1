import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/auth/screens/splash_screen/splash_screen_loader.dart';
import 'package:spacemall/src/features/core_app/check_out/application/check_out_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/screens/select_printer.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/profile/application/profile_controller.dart';
import 'package:spacemall/src/features/core_app/profile/domain/user_model.dart';
import 'package:spacemall/src/repository/services/phone_storage/sales_phone_services.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';
import 'package:spacemall/src/utils/helpers/helper.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../localizations/currency.dart';

class ReceiptView extends StatelessWidget {
  final ReceiptsModel receipt;
  final int? parsedIndex;
  final bool? fromCart;

  const ReceiptView(
      {super.key, required this.receipt, this.parsedIndex, this.fromCart});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final CheckOutController checkOutController = Get.find();
    final ProfileController profileController = Get.find();
    UserModel? user;

    return FutureBuilder<UserModel?>(
        future: profileController.getUserDataFromHive(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If the Future is still running, show a loading indicator or placeholder
            return const SplascreenLoader();
            // CircularProgressIndicator();
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

            return FutureBuilder<dynamic>(
                future: SalesPhoneService().getSalesFromDevice(receipt.cartId),
                builder: (context, cartSnapshot) {
                  if (cartSnapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // or any other loading indicator
                  } else if (cartSnapshot.hasError) {
                    return Text('Error fetching cart: ${cartSnapshot.error}');
                  } else {
                    List<dynamic> cart = cartSnapshot.data as List;

                    // var seller = user!.userName;
                    var userPhoneNo = user!.contactNumber;
                    // the last 6 digits of the user contact number
                    // var sellerID =
                    userPhoneNo.substring(userPhoneNo.length - 6);

                    return Scaffold(
                      appBar: MyAppBar(
                          isDarkMood: isDarkMood,
                          title: 'Receipt Detail',
                          automaticallyImplyLeading: false),
                      body: Column(
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  side: BorderSide(
                                    color: !isDarkMood
                                        ? kTextFieldLightBorderColor
                                            .withOpacity(0.5)
                                        : kTextFieldDarkBorderColor
                                            .withOpacity(0.5),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // first row on the page with cart total and share/print icon
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  nairaFormat.format(
                                                    double.parse(
                                                      receipt.cartTotal,
                                                    ),
                                                  ),
                                                  style: const TextStyle(
                                                    fontSize: kBodyTextFont,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  formatDateTime(
                                                    receipt.date.toString(),
                                                  ),
                                                  style: const TextStyle(
                                                    color: kGreyColor,
                                                    fontSize: kBodyTextFont,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // save or share receipt

                                            Row(
                                              children: [
                                                // container for saving receipt

                                                fromCart != null &&
                                                        fromCart == true
                                                    ? Container(
                                                        decoration: BoxDecoration(
                                                            color: !isDarkMood
                                                                ? kTextFieldLightBorderColor
                                                                    .withOpacity(
                                                                        0.1)
                                                                : kTextFieldDarkBorderColor
                                                                    .withOpacity(
                                                                        0.1),
                                                            shape: BoxShape
                                                                .circle),
                                                        child: IconButton(
                                                          onPressed: () {
                                                            spaceMallSnackBar(
                                                              'Success',
                                                              'You have saved this receipt, Go to Receipts to print it',
                                                              kWhiteLight,
                                                              kGreenColor,
                                                            );
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .save_alt_rounded,
                                                            size: 25,
                                                            color: !isDarkMood
                                                                ? kMainComplimemtColorLight
                                                                : kWhiteLight,
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        decoration: BoxDecoration(
                                                            color: !isDarkMood
                                                                ? kTextFieldLightBorderColor
                                                                    .withOpacity(
                                                                        0.1)
                                                                : kTextFieldDarkBorderColor
                                                                    .withOpacity(
                                                                        0.1),
                                                            shape: BoxShape
                                                                .circle),
                                                        child: IconButton(
                                                          // dialog box for select share or print
                                                          onPressed: () {
                                                            Get.defaultDialog(
                                                              backgroundColor: !isDarkMood
                                                                  ? kDarkModeBackgroundColor
                                                                      .withOpacity(
                                                                          0.1)
                                                                  : kWhiteDark
                                                                      .withOpacity(
                                                                          0.1),
                                                              title:
                                                                  'Select Action',
                                                              titleStyle:
                                                                  const TextStyle(
                                                                color:
                                                                    kWhiteLight,
                                                                fontSize:
                                                                    kBodyTextFont,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                              ),
                                                              content:
                                                                  const Text(
                                                                'Choose an action',
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      kWhiteLight,
                                                                  fontSize:
                                                                      kBodyTextFont,
                                                                ),
                                                              ),
                                                              confirm: Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        screenSize.width *
                                                                            0.05),
                                                                child: Row(
                                                                  children: [
                                                                    // share receipt
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        checkOutController.previewReceipt(
                                                                            receipt.cartId,
                                                                            screenSize);
                                                                      },
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                            kGreyColor,
                                                                      ),
                                                                      child:
                                                                          const Text(
                                                                        'Share Reciept',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              kBodyTextFont,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    ElevatedButton(
                                                                      // print receipt
                                                                      onPressed:
                                                                          () {
                                                                        Get.to(() =>
                                                                            SelectPrinter(
                                                                              saleId: receipt.cartId,
                                                                            ));

                                                                        spaceMallSnackBar(
                                                                          'Success',
                                                                          'You have Printed the receipt ',
                                                                          kWhiteLight,
                                                                          kGreenColor,
                                                                        );
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'Print Receipt',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              kBodyTextFont,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          icon: Icon(
                                                            Icons.ios_share,
                                                            size: 25,
                                                            color: !isDarkMood
                                                                ? kMainComplimemtColorLight
                                                                : kWhiteLight,
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.01,
                                        ),
                                        // Staff and attendant
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Staff - Attendant',
                                              style: TextStyle(
                                                fontSize: kBodyTextFont,
                                              ),
                                            ),
                                            Text(
                                              '${receipt.attendant} - ${receipt.staffId}',
                                              style: const TextStyle(
                                                fontSize: kBodyTextFont,
                                              ),
                                            ),
                                            // Text('$seller -  $sellerID'),
                                          ],
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.01,
                                        ),
                                        const Text(
                                          "Details",
                                          style: TextStyle(
                                            fontSize: kBodyTextFont,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        // List view of items in cart
                                        Container(
                                          height: screenSize.height * 0.6,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: !isDarkMood
                                                  ? const AssetImage(
                                                      kBackGroundCart)
                                                  : const AssetImage(
                                                      kBackGroundCartDarkMood),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          child: ListView.separated(
                                            itemCount: cart.length,
                                            separatorBuilder:
                                                (context, index) => Divider(
                                              color: !isDarkMood
                                                  ? kTextFieldLightBorderColor
                                                      .withOpacity(0.5)
                                                  : kTextFieldDarkBorderColor
                                                      .withOpacity(0.5),
                                              thickness: 1.0,
                                            ),
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          cart[index]
                                                              ['itemName'],
                                                          style: const TextStyle(
                                                              fontSize:
                                                                  kBodyTextFont),
                                                        ),
                                                        Text(
                                                          '${cart[index]['quantityInCart'].toString()} x ${cart[index]['itemPrice']} ',
                                                          style:
                                                              const TextStyle(
                                                            fontSize:
                                                                kBodyTextFont,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                        nairaFormat.format(
                                                          cart[index]
                                                              ['subTotal'],
                                                        ),
                                                        style: const TextStyle(
                                                          fontSize:
                                                              kBodyTextFont,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        )),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        // total summary
                                        Padding(
                                          padding: EdgeInsets.only(
                                            right: 8.0,
                                            top: screenSize.height * 0.0025,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              const Text(
                                                'Total',
                                                style: TextStyle(
                                                  fontSize: kBodyTextFont,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                nairaFormat.format(
                                                  double.parse(
                                                    receipt.cartTotal,
                                                  ),
                                                ),
                                                style: const TextStyle(
                                                  fontSize: kBodyTextFont,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // "completed" button
                      floatingActionButton: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        width: double.infinity,
                        height: screenSize.height * 0.06,
                        child: ElevatedButton(
                          onPressed: () {
                            checkOutController.clearCheckOutCart;
                            Get.offAll(() => DashBoard());
                          },
                          child: const Text(
                            kCompletedText,
                            style: TextStyle(
                              fontSize: kBodyTextFont,
                            ),
                          ),
                        ),
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.miniCenterFloat,
                    );
                  }
                });
          }
        });
  }
}
