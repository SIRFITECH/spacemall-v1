import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:hive/hive.dart';

part 'sales_model.g.dart';

@HiveType(typeId: 11)
class SalesModel {
  @HiveField(0)
  String saleId;
  @HiveField(1)
  String attendant;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  CartItemModel cart;
  @HiveField(4)
  String customerName;

  SalesModel({
    required this.saleId,
    required this.attendant,
    required this.date,
    required this.cart,
    required this.customerName,
  });

  // populated from map, that is serializing the stock object from server
  factory SalesModel.fromMap(Map<String, dynamic> map) {
    return SalesModel(
      saleId: map['saleId'] ?? '',
      attendant: map['attendant'] ?? '',
      date: map['date'] ?? '',
      cart: map['cart'] ?? '',
      customerName: map['customerName'] ?? '',
    );
  }

  // populated to map, that is serializing the user object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "attendant": attendant,
      "saleId": saleId,
      "date": date,
      "cart": cart,
      "customerName": customerName,
    };
  }
}
