import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:spacemall/src/features/core_app/check_out/application/check_out_controller.dart';
// import 'package:spacemall/src/features/core_app/check_out/data/check_out_repo.dart';
// import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/domain/sales_item_model.dart';
// import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';
import 'package:spacemall/src/localizations/currency.dart';
import 'package:spacemall/src/repository/services/phone_storage/sales_phone_services.dart';
// import 'package:spacemall/src/repository/hive_boxes.dart';
import 'package:spacemall/src/utils/helpers/helper.dart';

import '../../../dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipt_pdf.dart';

// generate a list of header texts
TableRow createHeaderRow(List<String> head, TextStyle style) {
  PdfColor pdfBackgroundColor = PdfColors.grey;
  return TableRow(
    children: head
        .asMap()
        .map((index, text) {
          if (index == 0) {
            // Align the first item to the left
            return MapEntry(
              index,
              Container(
                color: pdfBackgroundColor,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      text,
                      style: style,
                    ),
                  ),
                ),
              ),
            );
          } else {
            // Align the rest of the items to the center right
            return MapEntry(
              index,
              Container(
                color: pdfBackgroundColor,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      text,
                      style: style,
                    ),
                  ),
                ),
              ),
            );
          }
        })
        .values
        .toList(),
  );
}

// style for header texts
TextStyle headerTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 14,
);
// take a list of cartItems and generate a list of string
List<List<String>> mapCartItemsToStringList(List<SalesItemModel> cart) {
  List<List<String>> result = [];

  for (var item in cart) {
    List<String> itemInfo = [
      item.itemName,
      item.quantityInCart.toString(),
      item.itemPrice.toString(),
      nairaFormat.format(
        double.parse(
          item.subTotal.toString(),
        ),
      ),
    ];

    result.add(itemInfo);
  }

  return result;
}

List<TableRow> createBodyRow(List<List<String>> data, TextStyle style) {
  PdfColor pdfBackgroundColor = PdfColors.grey200;
  List<TableRow> tableRows = [];

  for (var datum in data) {
    List<Widget> cells = [];
    for (var index = 0; index < datum.length; index++) {
      var item = datum[index];
      var alignment =
          (index != 0) ? Alignment.centerRight : Alignment.centerLeft;
      var cell = Container(
        color: pdfBackgroundColor,
        child: Align(
          alignment: alignment,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              item,
              style: style,
            ),
          ),
        ),
      );
      cells.add(cell);
    }
    tableRows.add(TableRow(
      verticalAlignment: TableCellVerticalAlignment.middle,
      children: cells,
    ));
  }

  return tableRows;
}

// style for header texts
TextStyle bodyTextStyle = const TextStyle(
  fontSize: 14,
);

// build a title line
Widget buildTitle(ReceiptPDFModel receipt) => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Receipt',
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text('Receipt details'),
        SizedBox(
          height: 10,
        ),
      ],
    );

// build a body line
Widget buildBody(ReceiptPDFModel receipt) {
  var cart = SalesPhoneService()
      .getSalesFromDevice('4b04703c-2667-47a5-93a1-d8e624e7df82');

  List<List<String>> bodyList = mapCartItemsToStringList(cart
      // receipt
      );

  TableRow headers = createHeaderRow(
    [
      'Description',
      'Quantity',
      'Price',
      'Total Cost',
    ],
    headerTextStyle,
  );
  List<TableRow> body = createBodyRow(
    bodyList,
    bodyTextStyle,
  );

  return Table(
    children: [
      headers,
      ...body,
    ],
  );
}

// build a total line
Widget buildTotal(ReceiptPDFModel receipt) => Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Subtotal',
                  value: nairaFormat.format(
                    double.parse(
                      CheckOutController.instance.totalCartSubTotal.value
                          .toString(),
                    ),
                  ),
                  unit: true,
                ),
                buildText(
                  title: 'Discount',
                  value: nairaFormat.format(
                    double.parse(
                      CheckOutController.instance.totalCartDiscount.value
                          .toString(),
                    ),
                  ),
                  unit: true,
                ),
                buildText(
                  title: 'Tax',
                  value: nairaFormat.format(
                    double.parse(
                      CheckOutController.instance.totalCartTax.value.toString(),
                    ),
                  ),
                  unit: true,
                ),
                Divider(),
                buildText(
                  title: 'Total',
                  value: nairaFormat.format(
                    double.parse(
                      CheckOutController.instance.totalCartTotal.value
                          .toString(),
                    ),
                  ),
                  unit: true,
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(
                  color: PdfColors.grey,
                  height: 0.5,
                  child: Divider(),
                ),
                SizedBox(height: 1 * PdfPageFormat.mm),
                Container(
                  color: PdfColors.grey,
                  height: 0.5,
                  child: Divider(),
                ),
              ],
            ),
          ),
        ],
      ),
    );

// build a footer line
Widget buildFooter(ReceiptPDFModel receipt) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Divider(),
        SizedBox(height: 2 * PdfPageFormat.mm),
        buildFooterText(title: 'Store Name', value: receipt.seller.storeName),
        SizedBox(height: 1 * PdfPageFormat.mm),
        buildFooterText(title: 'Contact', value: receipt.seller.contact)
      ],
    );

// build a header line
Widget buildHeader(ReceiptPDFModel receipt) => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 1 * PdfPageFormat.cm,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildSupplier(
                storeName: receipt.seller.storeName,
                contact: receipt.seller.contact),
            Text('Store Logo '),
          ],
        ),
        SizedBox(
          height: 1 * PdfPageFormat.cm,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCustomer(customerName: 'customerName', contact: 'contact'),
            buildReceiptInfo(receipt, CheckOutController.instance.indexValue),
          ],
        )
      ],
    );

// build a total text line
Widget buildText({
  required String title,
  required String value,
  double width = double.infinity,
  TextStyle? textStyle,
  bool unit = false,
}) {
  final style = textStyle ??
      TextStyle(
        fontWeight: FontWeight.bold,
      );
  return Container(
    width: width,
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: style,
          ),
        ),
        Text(
          value,
          style: unit ? style : null,
        ),
      ],
    ),
  );
}

// build a footer text line
Widget buildFooterText({
  required String title,
  required String value,
  TextStyle? textStyle,
  bool unit = false,
}) {
  final style = textStyle ??
      TextStyle(
        fontWeight: FontWeight.bold,
      );
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: pw.CrossAxisAlignment.end,
    children: [
      Text(
        title,
        style: style,
      ),
      SizedBox(width: 2 * PdfPageFormat.mm),
      Text(
        value,
        style: unit ? style : null,
      ),
    ],
  );
}

// build a store details line
Widget buildSupplier({
  required String storeName,
  required String contact,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      Text(
        storeName,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      SizedBox(height: 1 * PdfPageFormat.mm),
      Text(
        contact,
      ),
      SizedBox(height: 3 * PdfPageFormat.mm),
    ],
  );
}

// build a customer details line
Widget buildCustomer({
  required String customerName,
  required String contact,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      Text(
        customerName,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      SizedBox(height: 1 * PdfPageFormat.mm),
      Text(
        contact,
      ),
      SizedBox(height: 3 * PdfPageFormat.mm),
    ],
  );
}

// build a receipt details line
Widget buildReceiptInfo(ReceiptPDFModel receipt, int index) {
  final titles = <String>[
    'ReceiptId',
    'Date',
  ];
  final data = <String>[
    truncateString(receipt.recieptInfo.receiptId, 12),
    DateFormat('d MMM, yyyy').format(DateTime.now()),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(
      titles.length,
      (index) {
        final title = titles[index];
        final value = data[index];
        return buildText(title: title, value: value, width: 200);
      },
    ),
  );
}

// build a total text line
Widget buildLogo({
  required StoreModel seller,
}) {
  return SizedBox(
    child: seller.logoLocalPath == ''
        ? Text('Store Logo')
        : Text(' Alternative String'),
  );
}
