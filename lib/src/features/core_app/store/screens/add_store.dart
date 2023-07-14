import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/general/custom_button.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/profile/screens/text_feild_widget.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';

class AddStore extends StatelessWidget {
  const AddStore({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    final StoreController storeController = Get.find();

    var logo = storeController.logo;
    return Scaffold(
        appBar: MyAppBar(
          isDarkMood: isDarkMood,
          title: kAddStoreAppBarText,
          automaticallyImplyLeading: false,
        ),
        body: Obx(
          () => Stack(
            children: [
              Container(
                padding: EdgeInsets.all(screenSize.width * 0.05),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: screenSize.width * 0.1),
                      child: Column(
                        children: [
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                storeController.selectLogo(context);
                              },
                              child: logo.value == null
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundColor: isDarkMood
                                            ? kDarkComplementColor
                                                .withOpacity(0.2)
                                            : kMainComplimemtColorLight
                                                .withOpacity(0.2),
                                        child: SizedBox(
                                          child: ClipOval(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(34.0),
                                              child: SvgPicture.asset(
                                                kMallIcon,
                                                color: isDarkMood
                                                    ? kMainComplimemtColorLight
                                                    : kMainColorLight,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 60,
                                      backgroundImage: FileImage(
                                          storeController.logo.value!),
                                    ),
                            ),
                          ),
                          Text(
                            kLogoText,
                            style: Theme.of(context).textTheme.labelSmall,
                          )
                        ],
                      ),
                    ),
                    // Store details
                    TextFeildWidget(
                      screenSize: screenSize,
                      isDarkMood: isDarkMood,
                      controller: storeController.storeName,
                      keyboardType: TextInputType.text,
                      width: screenSize.width * 0.84,
                      height: screenSize.width * 0.1,
                      hintText: '',
                      labelText: kStoreNameText,
                      maxLines: 1,
                    ),

                    TextFeildWidget(
                      screenSize: screenSize,
                      isDarkMood: isDarkMood,
                      controller: storeController.contact,
                      keyboardType: TextInputType.emailAddress,
                      width: screenSize.width * 0.84,
                      height: screenSize.width * 0.1,
                      hintText: 'email@gmail.com',
                      labelText: kStoreBusinessContactText,
                      maxLines: 1,
                    ),

                    TextFeildWidget(
                      screenSize: screenSize,
                      isDarkMood: isDarkMood,
                      controller: storeController.bankName,
                      keyboardType: TextInputType.text,
                      width: screenSize.width * 0.84,
                      height: screenSize.width * 0.1,
                      hintText: '',
                      labelText: kStoreBankNameText,
                      maxLines: 1,
                    ),
                    TextFeildWidget(
                      screenSize: screenSize,
                      isDarkMood: isDarkMood,
                      controller: storeController.accountNumber,
                      keyboardType: TextInputType.number,
                      hintText: '',
                      labelText: kStoreAccountNumberText,
                      maxLines: 1,
                      width: screenSize.width * 0.84,
                      height: screenSize.width * 0.1,
                    ),
                    CustomButton(
                      screenSize: screenSize,
                      onPress: () {
                        storeController.addNewStoreToPhone();
                      },
                      title: kSave,
                      width: screenSize.width * 0.3,
                    )
                  ],
                ),
              ),
              storeController.isLoading.value
                  ? Positioned(
                      child: Container(
                          height: screenSize.height,
                          width: screenSize.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          )),
                    )
                  : Container(),
            ],
          ),
        ));
  }
}
