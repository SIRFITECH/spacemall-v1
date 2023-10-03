import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';

import '../../features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import '../../features/core_app/store/domain/store_model.dart';
import '../../repository/hive_boxes.dart';

String truncateString(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength - 3)}...';
  }
}

String formatDateTime(String inputDateTime) {
  final inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  final outputFormatDate = DateFormat('d MMMM, y');
  final outputFormatTime = DateFormat('h:mm a');

  final dateTime = inputFormat.parse(inputDateTime);
  final formattedDate = outputFormatDate.format(dateTime);
  final formattedTime = outputFormatTime.format(dateTime);

  return '$formattedDate, $formattedTime';
}

// store file to storage
Future<String> saveImageToStorage(String ref, File file) async {
  UploadTask uploadTask =
      FirebaseStorage.instance.ref().child(ref).putFile(file);

  TaskSnapshot snapshot = await uploadTask;

  String downloadUrl = await snapshot.ref.getDownloadURL();

  return downloadUrl;
}

StoreModel store = storeBox.get(
  AddItemRepo.instance.currentStore.value,
  defaultValue: StoreModel(
    logo: null,
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
