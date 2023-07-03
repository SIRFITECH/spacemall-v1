import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';

class DebtsModel {
  String debtId;
  String customerName;
  DateTime payDate;
  String phone;
  bool isPaid;
  CartItemModel cart; //
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
