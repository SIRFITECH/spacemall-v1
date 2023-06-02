import 'package:flutter/material.dart';
import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/image_strings.dart';
import 'package:spacemall/src/features/core_app/general/custom_divider.dart';

class ConfirmPayment extends StatelessWidget {
  const ConfirmPayment({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        height: screenSize.height * 0.9,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(kBackGroundCart),
            fit: BoxFit.contain,
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  color: kMainComplimemtColorDark,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: screenSize.height * 0.1,
                        child: Column(
                          children: [
                            const ListTile(
                              title: Text('5alive(Medium)'),
                              subtitle: Text('2 x N1,000'),
                              trailing: Text('N 2,000'),
                            ),
                            CustomDivider(
                              height: screenSize.height * 0.0002,
                              thickness: screenSize.height * 0.002,
                              color: kWhiteLight,
                              margin: const EdgeInsets.all(0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.1,
                        child: Column(
                          children: [
                            const ListTile(
                              title: Text('5alive(Medium)'),
                              subtitle: Text('2 x N1,000'),
                              trailing: Text('N 2,000'),
                            ),
                            CustomDivider(
                              height: screenSize.height * 0.0002,
                              thickness: screenSize.height * 0.002,
                              color: kWhiteLight,
                              margin: const EdgeInsets.all(0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.1,
                        child: Column(
                          children: [
                            const ListTile(
                              title: Text('5alive(Medium)'),
                              subtitle: Text('2 x N1,000'),
                              trailing: Text('N 2,000'),
                            ),
                            CustomDivider(
                              height: screenSize.height * 0.0002,
                              thickness: screenSize.height * 0.002,
                              color: kWhiteLight,
                              margin: const EdgeInsets.all(0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.1,
                        child: Column(
                          children: [
                            const ListTile(
                              title: Text('5alive(Medium)'),
                              subtitle: Text('2 x N1,000'),
                              trailing: Text('N 2,000'),
                            ),
                            CustomDivider(
                              height: screenSize.height * 0.0002,
                              thickness: screenSize.height * 0.002,
                              color: kWhiteLight,
                              margin: const EdgeInsets.all(0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.1,
                        child: Column(
                          children: [
                            const ListTile(
                              title: Text('5alive(Medium)'),
                              subtitle: Text('2 x N1,000'),
                              trailing: Text('N 2,000'),
                            ),
                            CustomDivider(
                              height: screenSize.height * 0.0002,
                              thickness: screenSize.height * 0.002,
                              color: kWhiteLight,
                              margin: const EdgeInsets.all(0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.1,
                        child: Column(
                          children: [
                            const ListTile(
                              title: Text('5alive(Medium)'),
                              subtitle: Text('2 x N1,000'),
                              trailing: Text('N 2,000'),
                            ),
                            CustomDivider(
                              height: screenSize.height * 0.0002,
                              thickness: screenSize.height * 0.002,
                              color: kWhiteLight,
                              margin: const EdgeInsets.all(0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.1,
                        child: Column(
                          children: [
                            const ListTile(
                              title: Text('5alive(Medium)'),
                              subtitle: Text('2 x N1,000'),
                              trailing: Text('N 2,000'),
                            ),
                            CustomDivider(
                              height: screenSize.height * 0.0002,
                              thickness: screenSize.height * 0.002,
                              color: kWhiteLight,
                              margin: const EdgeInsets.all(0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  color: kMainColorLight,
                  height: 181,
                  child: Column(
                    children: [
                      const Card(
                        elevation: 0,
                        color: kMainColorLight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtitle',
                                style: TextStyle(
                                  color: kWhiteLight,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'N 2,000',
                                style: TextStyle(
                                  color: kWhiteLight,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Card(
                        elevation: 0,
                        color: kMainColorLight,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Discount',
                                style: TextStyle(
                                  color: kWhiteLight,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'N 0.0',
                                style: TextStyle(
                                  color: kWhiteLight,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Card(
                        elevation: 0,
                        color: kMainColorLight,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tax',
                                  style: TextStyle(
                                    color: kWhiteLight,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(
                                'N 200',
                                style: TextStyle(
                                  color: kWhiteLight,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomDivider(
                        height: screenSize.height * 0.002,
                        thickness: screenSize.height * 0.002,
                        color: kWhiteLight,
                        margin: const EdgeInsets.all(0),
                      ),
                      const ListTile(
                        title: Text(
                          'Total',
                          style: TextStyle(
                            color: kWhiteLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          'N 2,000',
                          style: TextStyle(
                              color: kWhiteLight, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                // vertical: 2.0,
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Get.to(() => PayLater());
                    },
                    child: const Text('Pay Later'),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Get.to(() => AddNewToCheckOut());
                    },
                    child: const Text('Add Item'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenSize.height * 0.05),
              child: Center(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  width: 200,
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
                      'Confirm Payment',
                      style: TextStyle(fontSize: 15, color: kWhiteLight),
                    ),
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
