import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:spacemall/src/constants/colors.dart';
// import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';
import 'package:spacemall/src/utils/app_utils/appp_utils.dart';

class SelectPrinter extends StatefulWidget {
  const SelectPrinter({super.key});

  @override
  State<SelectPrinter> createState() => _SelectPrinterState();
}

class _SelectPrinterState extends State<SelectPrinter> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> devices = [];

  String devicesMsg = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initPrinter());
  }

  Future<void> initPrinter() async {
    // begin scan for bluetooth devices
    bluetoothPrint.startScan(timeout: const Duration(seconds: 2));

    // return is no device is mounted
    if (!mounted) return;

    bluetoothPrint.scanResults.listen((printers) {
      if (!mounted) return;

      setState(() {
        devices = printers;

        if (devices.isEmpty) {
          setState(() {
            devicesMsg = 'No printer found';
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    // final screenSize = media.size;

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: 'Select Printer',
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: devices.isNotEmpty
            ? ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(devices[index].name!),
                    subtitle: Text(devices[index].address!),
                    onTap: () async {
                      await startPrint(devices[index])
                          // .then((value) => bluetoothPrint.disconnect())
                          ;
                      spaceMallSnackBar(
                        'Printing Receipt',
                        'You have sent a print',
                        kWhiteLight,
                        kGreenColor,
                      );
                    },
                  );
                })
            // Text(devices.first.address!)
            : Text(devicesMsg),
      ),
    );
  }

  Future<void> startPrint(BluetoothDevice device) async {
    if (device.address != null) {
      try {
        await bluetoothPrint.connect(device).then((value) async {
          debugPrint('connection successfull');
     
          Map<String, dynamic> config = {};
          config['width'] = 40;
          config['height'] = 70;
          config['gap'] = 2;
          List<LineText> printList = [];

          // List<CartItemModel> cart = [

          //   CartItemModel(
          //     itemId: 'itemId',
          //     itemName: 'Hennessy',
          //     quantityInCart: RxInt(1),
          //     price: 'NGN 50,000',
          //     totalItemPrice: 'NGN 50,0000',
          //     subTotal: RxDouble(1.0),
          //     discount: 1,
          //     tax: 1,
          //   ),
          //   CartItemModel(
          //     itemId: 'itemId',
          //     itemName: 'Monster',
          //     quantityInCart: RxInt(1),
          //     price: 'NGN 400',
          //     totalItemPrice: 'NGN 400',
          //     subTotal: RxDouble(1.0),
          //     discount: 1,
          //     tax: 1,
          //   ),
          //   CartItemModel(
          //     itemId: 'itemId',
          //     itemName: 'Samusa',
          //     quantityInCart: RxInt(1),
          //     price: 'NGN 400',
          //     totalItemPrice: 'NGN 400',
          //     subTotal: RxDouble(1.0),
          //     discount: 1,
          //     tax: 1,
          //   ),
          //   CartItemModel(
          //     itemId: 'itemId',
          //     itemName: 'Egg roll',
          //     quantityInCart: RxInt(1),
          //     price: 'NGN 500',
          //     totalItemPrice: 'NGN 500',
          //     subTotal: RxDouble(1.0),
          //     discount: 1,
          //     tax: 1,
          //   ),
          //   CartItemModel(
          //     itemId: 'itemId',
          //     itemName: 'Bobo',
          //     quantityInCart: RxInt(1),
          //     price: 'NGN 450',
          //     totalItemPrice: 'NGN 450',
          //     subTotal: RxDouble(1.0),
          //     discount: 1,
          //     tax: 1,
          //   ),
          // ];

          printList.add(LineText(
            type: LineText.TYPE_TEXT,
            content: 'spacemall',
            weight: 2,
            width: 2,
            height: 2,
            align: LineText.ALIGN_CENTER,
            linefeed: 1,
          ));

          // for (var cartItem in cart) {
          //   printList.add(LineText(
          //     type: LineText.TYPE_TEXT,
          //     content: cartItem.itemName,
          //     weight: 0,
          //     align: LineText.ALIGN_LEFT,
          //     linefeed: 1,
          //   ));
          //   printList.add(LineText(
          //     type: LineText.TYPE_TEXT,
          //     content: '${cartItem.quantityInCart} x ${cartItem.price}',
          //     weight: 0,
          //     align: LineText.ALIGN_LEFT,
          //     linefeed: 1,
          //   ));
          //   printList.add(LineText(
          //     type: LineText.TYPE_TEXT,
          //     content: cartItem.totalItemPrice,
          //     weight: 0,
          //     align: LineText.ALIGN_RIGHT,
          //     linefeed: 1,
          //   ));
          // }
          // printList.add(LineText(
          //   type: LineText.TYPE_TEXT,
          //   content: 'NGN 50,456',
          //   weight: 3,
          //   align: LineText.ALIGN_RIGHT,
          //   linefeed: 1,
          // ));

          await bluetoothPrint
              .printReceipt(config, printList)
              .then((value) => print('Printing receipt...'));
        });
      } catch (e) {
        debugPrint('error happened: ${e.toString()}');
      }
    } else {
      debugPrint('Could not connect to printer');
    }
  }
}
