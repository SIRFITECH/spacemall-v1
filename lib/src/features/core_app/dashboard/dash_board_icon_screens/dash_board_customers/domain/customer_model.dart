import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_debts/domain/debts_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import 'package:hive/hive.dart';

part 'customer_model.g.dart';

@HiveType(typeId: 6)
class CustomerModel {
  @HiveField(0)
  String customerId;
  @HiveField(1)
  String customerName;
  @HiveField(2)
  String phone;
  @HiveField(3)
  String totalOrder;
  @HiveField(4)
  DateTime lastOrder;
  @HiveField(5)
  DebtsModel debts;
  @HiveField(6)
  ReceiptsModel receipts;

  CustomerModel({
    required this.customerId,
    required this.customerName,
    required this.phone,
    required this.totalOrder,
    required this.lastOrder,
    required this.debts,
    required this.receipts,
  });

  // populated from map, that is serializing the stock object from server
  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      customerId: map['customerId'] ?? '',
      customerName: map['customerName'] ?? '',
      phone: map['phone'] ?? '0',
      totalOrder: map['totalOrder'] ?? '0',
      lastOrder: map['lastOrder'] ?? DateTime.now(),
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
      "totalOrder": totalOrder,
      "lastOrder": lastOrder,
      "debts": debts,
      "receipts": receipts,
    };
  }
}
