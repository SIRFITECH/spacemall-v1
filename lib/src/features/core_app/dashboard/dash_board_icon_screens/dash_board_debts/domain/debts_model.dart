import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:hive/hive.dart';

part 'debts_model.g.dart';

@HiveType(typeId: 7)
class DebtsModel {
  @HiveField(0)
  String debtId;
  @HiveField(1)
  String customerName;
  @HiveField(2)
  DateTime payDate;
  @HiveField(3)
  String phone;
  @HiveField(4)
  bool isPaid;
  @HiveField(5)
  CartItemModel cart;
  @HiveField(6) //
  double amountPayable;

  DebtsModel({
    required this.debtId,
    required this.customerName,
    required this.payDate,
    required this.phone,
    required this.isPaid,
    required this.cart,
    required this.amountPayable,
  });

  // populated from map, that is serializing the debts object from server
  factory DebtsModel.fromMap(Map<String, dynamic> map) {
    return DebtsModel(
      debtId: map['debtId'] ?? '',
      customerName: map['customerName'] ?? '',
      payDate: map['payDate'] ?? '',
      phone: map['phone'] ?? '0',
      isPaid: map['isPaid'] ?? false,
      cart: map['cart'] ?? '',
      amountPayable: map['amountPayable'] ?? 0.0,
    );
  }

  // populated to map, that is serializing the debts object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "customerName": customerName,
      "debtId": debtId,
      "payDate": payDate,
      "phone": phone,
      "isPaid": isPaid,
      "cart": cart,
      "amountPayable": amountPayable,
    };
  }
}
