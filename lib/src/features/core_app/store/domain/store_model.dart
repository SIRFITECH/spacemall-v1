import 'package:hive/hive.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/application/stock_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/domain/stock_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_customers/application/customer_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_customers/domain/customer_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_debts/application/debt_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_debts/domain/debts_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/application/reciepts_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_receipts/domain/receipts_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/application/sales_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_sales/domain/sales_model.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_staff/application/staff_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_board_staff/domain/staff_model.dart';

part 'store_model.g.dart';

@HiveType(typeId: 4)
class StoreModel {
  @HiveField(0)
  String logo;
  @HiveField(1)
  String storeName;
  @HiveField(2)
  String bankName;
  @HiveField(3)
  String contact;
  @HiveField(4)
  List<StockModel> stock;
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

  StoreModel({
    required this.logo,
    required this.storeName,
    required this.bankName,
    required this.contact,
    required this.stock,
    required this.receipts,
    required this.debts,
    required this.staff,
    required this.sales,
    required this.customer,
  });

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      logo: '',
      storeName: '',
      bankName: '',
      contact: '',
      stock:
          StockController.instance.convertStockItems(map['stock-item'] ?? []),
      receipts:
          ReceiptsController.instance.convertReceipts(map['reciept'] ?? []),
      debts: DebtController.instance.convertDebts(map['debt'] ?? []),
      staff: StaffController.instance.convertStaff(map['staff'] ?? []),
      sales: SalesController.instance.convertSales(map['sales'] ?? []),
      customer:
          CustomersController.instance.convertCustomers(map['customer'] ?? []),
    );
  }
}
