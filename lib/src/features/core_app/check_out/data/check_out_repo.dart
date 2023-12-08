import 'dart:io';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:spacemall/src/features/core_app/check_out/screens/preview_receipt.dart';
import 'package:uuid/uuid.dart';

import '../../../../repository/hive_boxes.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_receipts/application/receipts_controller.dart';
import '../../dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipt_pdf.dart';
import '../domain/check_out_item_model.dart';
import '../screens/widgets/receipt_build_widget.dart';

class CheckOutRepo extends GetxController {
  static CheckOutRepo get instance => Get.put(
        CheckOutRepo(),
      );

  String itemId = const Uuid().v4();

  var count = 0.obs;

  // get stores
  List<CartItemModel> getCheckOutCartFromBox() {
    List<CartItemModel> checkOutCart = [];
    for (var key in storeBox.keys) {
      if (key.startsWith('store-')) {
        CartItemModel? cart = cartBox.get(key);
        if (cart != null) {
          checkOutCart.add(cart);
        }
      }
    }
    return checkOutCart;
  }

  void clearCheckOutCart() {
    for (var key in storeBox.keys) {
      if (key.startsWith('store-')) {
        cartBox.delete(key);
      }
    }
  }

  Future<File> generatePDFReceipt(ReceiptPDFModel receipt, int index) async {
    final receiptPDF = pw.Document();
    int receiptNo = ReceiptsController.instance.receiptNo.value;
    receiptPDF.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (context) => buildHeader(receipt),
        build: (context) => [
          buildTitle(receipt),
          buildBody(
            receipt,
            // CartItemController.instance.indexValue,
          ),
          Divider(),
          buildTotal(receipt),
        ],
        footer: (context) => buildFooter(receipt),
      ),
    );

    Get.to(
      () => PreviewReceipt(
        doc: receiptPDF,
      ),
    );

    return savePDF(
        receiptName: 'recipt_$receiptNo.pdf', receiptPDF: receiptPDF);
  }

// fetch the saved pdf for preview
  Future previewReciept(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  Future<File> savePDF({
    required String receiptName,
    required Document receiptPDF,
  }) async {
    final bytes = await receiptPDF.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$receiptPDF');

    await file.writeAsBytes(bytes);

    return file;
  }
}
