import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';

class SalesModel {
  String saleId;
  String attendant;
  DateTime date;
  CartItemModel cart;

  SalesModel({
    required this.saleId,
    required this.attendant,
    required this.date,
    required this.cart,
  });

  // populated from map, that is serializing the stock object from server
  factory SalesModel.fromMap(Map<String, dynamic> map) {
    return SalesModel(
      saleId: map['saleId'] ?? '',
      attendant: map['attendant'] ?? '',
      date: map['date'] ?? '',
      cart: map['cart'] ?? '',
    );
  }

  // populated to map, that is serializing the user object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "attendant": attendant,
      "saleId": saleId,
      "date": date,
      "cart": cart,
    };
  }
}
