import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/text_strings.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';

class ConnectPrinter extends StatefulWidget {
  const ConnectPrinter({super.key});

  @override
  State<ConnectPrinter> createState() => _PrinterSettingsState();
}

class _PrinterSettingsState extends State<ConnectPrinter> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: kConnectPrinterAppBarText,
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.02),
                    child: Center(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        height: 40,
                        width: 130,
                        color: kMainColorLight,
                        child: TextButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const AddModifierSuccess(),
                            //     ));
                          },
                          child: const Text(
                            'Osagie',
                            style: TextStyle(fontSize: 13, color: kWhiteLight),
                          ),
                        ),
                      ),
                    )),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    'PAPER WIDTH',
                    style: TextStyle(
                      color: kBlackDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              RadioListTile(
                value: 'unchecked',
                groupValue: 'groupValue',
                onChanged: (value) {},
                title: const Text('58mm'),
                toggleable: true,
              ),
              RadioListTile(
                value: 'unchecked',
                groupValue: 'groupValue',
                onChanged: (value) {},
                title: const Text('80mm'),
                toggleable: true,
              ),
              const Row(
                children: [
                  Text(
                    'PRINTER CONTENT',
                    style: TextStyle(
                      color: kBlackDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              RadioListTile(
                value: 'unchecked',
                groupValue: 'groupValue',
                onChanged: (value) {},
                title: const Text('RECEIPT'),
                toggleable: true,
              ),
              RadioListTile(
                value: 'unchecked',
                groupValue: 'groupValue',
                onChanged: (value) {},
                title: const Text('KDS ITEM'),
                toggleable: true,
              ),
              const Row(
                children: [
                  Text(
                    'PRINT MODE',
                    style: TextStyle(
                      color: kBlackDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              RadioListTile(
                value: 'unchecked',
                groupValue: 'groupValue',
                onChanged: (value) {},
                title: const Text('TEXT'),
                toggleable: true,
              ),
              RadioListTile(
                value: 'unchecked',
                groupValue: 'groupValue',
                onChanged: (value) {},
                title: const Text('GRAPHICAL'),
                subtitle: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('.Text only (no image)'),
                    Text('.Faster'),
                    Text('.Works currently on most printers'),
                  ],
                ),
                toggleable: true,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Row(
                  children: [
                    Text(
                      'ADDITIONAL OPTIONS',
                      style: TextStyle(
                        color: kBlackDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Container(
                  width: screenSize.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: kMainColorLight),
                  ),
                  child: const Column(
                    children: [
                      ListTile(
                        trailing: Icon(
                          Icons.toggle_off_outlined,
                          size: 40,
                        ),
                        title: Text('Use legacy mode'),
                        subtitle: Text(
                            'only select if normal mode does not work on your printer '),
                      ),
                      ListTile(
                        trailing: Icon(
                          Icons.toggle_on,
                          size: 40,
                        ),
                        title: Text('Print automatically on sale '),
                      ),
                      ListTile(
                        trailing: Icon(
                          Icons.toggle_on,
                          size: 40,
                        ),
                        title: Text('Extra line spacing between items '),
                      ),
                      ListTile(
                        trailing: Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('NGN'),
                          ),
                        ),
                        title: Text('Currency prefix'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
