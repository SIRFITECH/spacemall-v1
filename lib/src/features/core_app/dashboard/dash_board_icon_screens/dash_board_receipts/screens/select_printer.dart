import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:spacemall/src/constants/colors.dart';
import 'package:spacemall/src/constants/sizes.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_display/screens/dash_board_screen.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/general/custom_divider.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/localizations/currency.dart';
import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:spacemall/src/repository/services/phone_storage/sales_phone_services.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

class SelectPrinter extends StatefulWidget {
  const SelectPrinter({super.key, required this.saleId});
  final String saleId;

  @override
  State<SelectPrinter> createState() => _SelectPrinterState();
}

class _SelectPrinterState extends State<SelectPrinter> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  bool _connected = false;
  BluetoothDevice? _device;

  String tips = 'No printer connected';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: const Duration(seconds: 4));

    bool isConnected = await bluetoothPrint.isConnected ?? false;

    bluetoothPrint.state.listen((state) {
      debugPrint('******************* current device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'connected successfully';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'disconnected successfully';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    final screenSize = media.size;

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

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: 'Print Receipt',
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            bluetoothPrint.startScan(timeout: const Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(tips),
                  ),
                ],
              ),
              // first divider on the screen
              CustomDivider(
                height: screenSize.width * 0.025,
                thickness: screenSize.width * 0.004,
                color: kGreyColor,
                margin: const EdgeInsets.all(kDividerMargin),
              ),
              // const Divider(),
              StreamBuilder<List<BluetoothDevice>>(
                stream: bluetoothPrint.scanResults,
                initialData: const [],
                builder: (context, snapshot) => Column(
                  children: snapshot.data!
                      .map((device) => ListTile(
                            title: Text(
                              device.name ?? '',
                              style: const TextStyle(
                                fontSize: kBodyTextFont,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            subtitle: Text(
                              device.address ?? '',
                              style: const TextStyle(
                                fontSize: kBodyTextFont,
                              ),
                            ),
                            onTap: () async {
                              setState(() {
                                _device = device;
                              });
                            },
                            trailing: _device != null &&
                                    _device!.address == device.address
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : null,
                          ))
                      .toList(),
                ),
              ),
              // Second divider on the screen

              CustomDivider(
                height: screenSize.width * 0.025,
                thickness: screenSize.width * 0.004,
                color: kGreyColor,
                margin: const EdgeInsets.all(kDividerMargin),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _connected
                            ? null
                            : () async {
                                if (_device != null &&
                                    _device!.address != null) {
                                  setState(() {
                                    tips = 'connecting...';
                                  });
                                  await bluetoothPrint.connect(_device!);
                                } else {
                                  setState(() {
                                    tips = 'Please select a Print';
                                  });
                                  spaceMallSnackBar(
                                    'Please select a Print',
                                    'You need to select a printer from the list',
                                    kWhiteLight,
                                    kRedColor,
                                  );
                                  debugPrint('please select printer');
                                }
                              },
                        child: const Text(
                          'connect',
                          style: TextStyle(
                            fontSize: kBodyTextFont,
                          ),
                        ),
                      ),
                      SizedBox(width: screenSize.width * .05),
                      ElevatedButton(
                        onPressed: _connected
                            ? () async {
                                setState(() {
                                  tips = 'disconnecting...';
                                });
                                await bluetoothPrint.disconnect();
                              }
                            : null,
                        child: const Text(
                          'disconnect',
                          style: TextStyle(
                            fontSize: kBodyTextFont,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Third divider
                  CustomDivider(
                    height: screenSize.width * 0.025,
                    thickness: screenSize.width * 0.004,
                    color: kGreyColor,
                    margin: const EdgeInsets.all(kDividerMargin),
                  ),
                  ElevatedButton(
                    onPressed: _connected
                        ? () async {
                            Map<String, dynamic> config = {};

                            List<dynamic> cart = await SalesPhoneService()
                                .getSalesFromDevice(widget.saleId);

                            double total = 0.0;
                            double discount = 0.0;
                            double tax = 0.0;
                            double finalTotal = 0.0;
                            List<LineText> list = [];
                            list.add(
                              LineText(
                                type: LineText.TYPE_TEXT,
                                content:
                                    '----${store.storeName.toUpperCase()} RECEIPT----',
                                weight: 1,
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1,
                              ),
                            );
                            // first item on the receipt
                            for (var i = 0; i < cart.length; i++) {
                              list.add(
                                LineText(
                                  type: LineText.TYPE_TEXT,
                                  content:
                                      '${cart[i]['itemName']} x ${cart[i]['quantityInCart']} ',
                                  weight: 1,
                                  align: LineText.ALIGN_LEFT,
                                  x: 0,
                                  relativeX: 0,
                                  linefeed: 0,
                                ),
                              );
                              list.add(
                                LineText(
                                  type: LineText.TYPE_TEXT,
                                  content: nairaFormat.format(
                                    double.parse(
                                      cart[i]['subTotal'].toString(),
                                    ),
                                  ),
                                  weight: 1,
                                  align: LineText.ALIGN_LEFT,
                                  x: 220,
                                  relativeX: 0,
                                  linefeed: 0,
                                ),
                              );
                            }

                            for (var i = 0; i < cart.length; i++) {
                              total += cart[i]['subTotal'];
                            }
                            discount = total * 0.1;
                            tax = total * 0.075;
                            finalTotal = total - discount + tax;

                            // just to seperate it
                            list.add(
                              LineText(
                                type: LineText.TYPE_TEXT,
                                content: '',
                                align: LineText.ALIGN_LEFT,
                                x: 0,
                                relativeX: 0,
                                linefeed: 0,
                              ),
                            );

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '*************',
                                weight: 1,
                                align: LineText.ALIGN_LEFT,
                                x: 220,
                                relativeX: 0,
                                linefeed: 1));

                            // the total
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'TOTAL',
                                align: LineText.ALIGN_LEFT,
                                x: 0,
                                relativeX: 0,
                                linefeed: 0));

                            list.add(
                              LineText(
                                type: LineText.TYPE_TEXT,
                                content: nairaFormat.format(
                                  double.parse(
                                    finalTotal.toString(),
                                  ),
                                ),
                                weight: 1,
                                align: LineText.ALIGN_LEFT,
                                x: 220,
                                relativeX: 0,
                                linefeed: 1,
                              ),
                            );
                            //bottom divider
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '*************',
                                weight: 1,
                                align: LineText.ALIGN_LEFT,
                                x: 220,
                                relativeX: 0,
                                linefeed: 1));
                            list.add(
                              LineText(linefeed: 1),
                            );

                            await bluetoothPrint.printReceipt(config, list);
                          }
                        : null,
                    child: const Text('print receipt',
                        style: TextStyle(
                          fontSize: kBodyTextFont,
                        )),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder<bool>(
                      stream: bluetoothPrint.isScanning,
                      initialData: false,
                      builder: (context, snapshot) {
                        if (snapshot.data == true) {
                          return ElevatedButton(
                            onPressed: () => bluetoothPrint.stopScan(),
                            child: const Text(
                              'Stop Search',
                            ),
                          );
                        } else {
                          return ElevatedButton(
                            onPressed: () => bluetoothPrint.startScan(
                              timeout: const Duration(seconds: 4),
                            ),
                            child: const Text('Search Printer',
                                style: TextStyle(
                                  fontSize: kBodyTextFont,
                                )),
                          );
                        }
                      },
                    ),
                  ),

                  SizedBox(
                    height: screenSize.height * 0.2,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.off(() => DashBoard());
                      },
                      child: const Text(
                        'Finished Printing',
                        style: TextStyle(
                          fontSize: kBodyTextFont,
                        ),
                      ))
                ]),
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: StreamBuilder<bool>(
      //   stream: bluetoothPrint.isScanning,
      //   initialData: false,
      //   builder: (context, snapshot) {
      //     if (snapshot.data == true) {
      //       return FloatingActionButton(

      //         onPressed: () => bluetoothPrint.stopScan(),
      //         backgroundColor: Colors.red,
      //         child: Icon(Icons.stop),
      //       );
      //     } else {
      //       return FloatingActionButton(

      //           onPressed: () =>
      //               bluetoothPrint.startScan(timeout: Duration(seconds: 4)));
      //     }
      //   },
      // ),
    );
  }
}
