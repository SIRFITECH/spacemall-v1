import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_debts/domain/debts_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';

class CustomerModel {
  String customerId;
  String customerName;
  String phone;
  DebtsModel debts;
  ReceiptsModel receipts;

  CustomerModel({
    required this.customerId,
    required this.customerName,
    required this.phone,
    required this.debts,
    required this.receipts,
  });

  // populated from map, that is serializing the stock object from server
  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      customerId: map['customerId'] ?? '',
      customerName: map['customerName'] ?? '',
      phone: map['phone'] ?? '0',
      debts: map['debts'] ?? '',
      receipts: map['receipts'] ?? 0.0,
    );
  }

  // populated to map, that is serializing the user object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "customerName": customerName,
      "customerId": customerId,
      "phone": phone,
      // // "isPaid": isPaid,
      "debts": debts,
      "receipts": receipts,
    };
  }
}
