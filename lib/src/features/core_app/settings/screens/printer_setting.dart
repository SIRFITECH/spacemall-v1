import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/settings/screens/connect_printer.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';

class PrinterSettings extends StatelessWidget {
  const PrinterSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    // final screenSize = media.size;

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: kSettingsAppBarText,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: isDarkMood
              ? kDarkModeBackgroundColor.withAlpha(2)
              : kWhiteLight.withAlpha(2),
          image: const DecorationImage(
            image: AssetImage(kBackGroundCart),
            fit: BoxFit.contain,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: kMainColorLight),
                  borderRadius: BorderRadius.circular(10),
                ),
                // height: 60,
                child: const ListTile(
                  leading: Icon(
                    Icons.bluetooth,
                    color: kBlack,
                  ),
                  title: Text('Js'),
                  trailing: Icon(Icons.warning_amber_rounded),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: kMainColorLight),
                  borderRadius: BorderRadius.circular(10),
                ),
                // height: 60,
                child: const ListTile(
                  leading: Icon(
                    Icons.print,
                    color: kBlack,
                  ),
                  title: Text('Osagie'),
                  trailing: Icon(Icons.warning_amber_rounded),
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: kMainColorLight),
                  borderRadius: BorderRadius.circular(10),
                ),
                // height: 60,
                child: const ListTile(
                  leading: Icon(
                    Icons.bluetooth,
                    color: kBlack,
                  ),
                  title: Text('Js'),
                  trailing: Icon(Icons.warning_amber_rounded),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: kMainColorLight),
                  borderRadius: BorderRadius.circular(10),
                ),
                // height: 60,
                child: const ListTile(
                  leading: Icon(
                    Icons.bluetooth,
                    color: kBlack,
                  ),
                  title: Text('Js'),
                  trailing: Icon(Icons.warning_amber_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const ConnectPrinter());
        },
        backgroundColor: kMainColorLight,
        child: const Icon(
          Icons.add,
          color: kWhiteLight,
        ),
      ),
    );
  }
}
