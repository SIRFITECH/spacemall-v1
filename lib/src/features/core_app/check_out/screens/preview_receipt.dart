import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:spacemall/src/features/core_app/general/my_app_bar.dart';

class PreviewReceipt extends StatelessWidget {
  final pw.Document doc;

  const PreviewReceipt({Key? key, required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDarkMood = brightness == Brightness.dark;
    // final screenSize = media.size;

    return Scaffold(
      appBar: MyAppBar(
        isDarkMood: isDarkMood,
        title: 'Receipt Preview',
        automaticallyImplyLeading: false,
      ),
      body: PdfPreview(
        build: (format) => doc.save(),
        allowSharing: true,
        allowPrinting: true,
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: 'receipt_1.pdf',
        // onShared: (context) {
        //   print('shared ');
        // },
      ),
    );
  }
}
