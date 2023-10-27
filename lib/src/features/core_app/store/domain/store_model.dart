import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_category/domain/category_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/application/add_item_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/domain/add_item_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_customers/application/customer_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_customers/domain/customer_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_debts/application/debt_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_debts/domain/debts_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/application/receipts_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/application/sales_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/domain/sales_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_staff/application/staff_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_staff/domain/staff_model.dart';
import 'package:spacemall/src/features/core_app/store/application/store_controller.dart';

part 'store_model.g.dart';

@HiveType(typeId: 4)
class StoreModel {
  @HiveField(0)
  String logoLocalPath;
  @HiveField(1)
  String storeName;
  @HiveField(2)
  String bankName;
  @HiveField(3)
  String contact;
  @HiveField(4)
  List<AddItemModel> stock;
  @HiveField(5)
  List<ReceiptsModel> receipts;
  @HiveField(6)
  List<DebtsModel> debts;
  @HiveField(7)
  List<StaffModel> staff;
  @HiveField(8)
  List<SalesModel> sales;
  @HiveField(9)
  List<CustomerModel> customer;
  @HiveField(10)
  String storeId;
  @HiveField(11)
  String accountNumber;
  @HiveField(12)
  List<CategoryModel> categories;
  @HiveField(13)
  String logoRemotePath;
  // @HiveField(13)
  // bool storeStatus;
  // @HiveField(14)
  // List<AddItemModel> lowStock;

  // store constructor
  StoreModel({
    required this.logoLocalPath,
    required this.storeName,
    required this.bankName,
    required this.accountNumber,
    required this.contact,
    required this.stock,
    required this.receipts,
    required this.debts,
    required this.staff,
    required this.sales,
    required this.customer,
    required this.storeId,
    required this.categories,
    required this.logoRemotePath,
    // required this.storeStatus
    // required this.lowStock
  });

  // populated from map, that is serializing the store object to string for server use

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      logoLocalPath: map['logoLocalPath'] ?? '',
      storeName: map['storeName'] ?? '',
      bankName: map['bankName'] ?? '',
      contact: map['contact'] ?? '',
      accountNumber: map['accountNumber'] ?? '',
      storeId: map['storeId'] ?? '',
      categories:
          StoreController.instance.convertCategories(map['categories'] ?? []),
      stock: RxList(
        AddItemController.instance.convertStockItems(map['stock-item'] ?? []),
      ),
      receipts:
          ReceiptsController.instance.convertReceipts(map['reciept'] ?? []),
      debts: DebtController.instance.convertDebts(map['debt'] ?? []),
      staff: StaffController.instance.convertStaff(map['staff'] ?? []),
      sales: SalesController.instance.convertSales(map['sales'] ?? []),
      customer:
          CustomersController.instance.convertCustomers(map['customer'] ?? []),
      logoRemotePath: map['logoRemotePath'] ?? '',
    );
  }

  // populated to map, that is serializing the store object to string for server use
  Map<String, dynamic> toMap() {
    return {
      "logoLocalPath": logoLocalPath,
      " storeName": storeName,
      "bankName": bankName,
      "contact": contact,
      "accountNumber": accountNumber,
      "stock": stock.toList(),
      "receipts": receipts,
      "debts": debts,
      'staff': staff,
      "sales": sales,
      "customer": customer,
      "storeId": storeId,
      "categories": categories,
      "logoRemotePath": logoRemotePath,
    };
  }
}
