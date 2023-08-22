import 'package:spacemall/src/features/core_app/check_out/domain/check_out_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_customers/domain/customer_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import 'package:spacemall/src/features/core_app/store/domain/store_model.dart';

class ReceiptPDFModel {
  StoreModel seller;
  CustomerModel customer;
  ReceiptsModel recieptInfo;
  CartItemModel cartItem;
  String cartId;
  String totalCartPrice;
  String subTotal;
  String discount;
  String tax;

  ReceiptPDFModel({
    required this.seller,
    required this.customer,
    required this.recieptInfo,
    required this.cartItem,
    required this.totalCartPrice,
    required this.cartId,
    required this.subTotal,
    required this.discount,
    required this.tax,
  });

  // populated from map, that is serializing the ReceiptPDFModel object from server
  factory ReceiptPDFModel.fromMap(Map<String, dynamic> map) {
    return ReceiptPDFModel(
      seller: map['seller'] ?? '',
      customer: map['customer'] ?? '',
      recieptInfo: map['recieptInfo'] ?? '',
      cartItem: map['cartItem'] ?? 0,
      totalCartPrice: map['totalCartPrice'] ?? '0.0',
      cartId: map['cartId'] ?? '',
      subTotal: map['subTotal'] ?? '0.0',
      discount: map['discount'] ?? '0.0',
      tax: map['tax'] ?? ' 0.0',
    );
  }

  // populated to map, that is serializing the ReceiptPDFModel object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "seller": seller,
      "customer": customer,
      "recieptInfo": recieptInfo,
      "cartItem": cartItem,
      "totalCartPrice": totalCartPrice,
      "cartId": cartId,
      "subTotal": subTotal,
      "discount": discount,
      "tax": tax,
    };
  }
}
