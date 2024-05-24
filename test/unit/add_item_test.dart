import 'dart:developer' as developer;

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/application/add_item_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/add_item/data/add_item_repo.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/application/stock_controller.dart';
import 'package:spacemall/src/features/core_app/dashboard/dash_board_icon_screens/dash_baord_stock/main_stock_screen/domain/stock_model.dart';
import 'package:vm_service/vm_service.dart';
import 'package:vm_service/vm_service_io.dart';

void main() {
  var localStockItem = StockModel(
      itemPic: "",
      itemName: "",
      itemPrice: "",
      itemCategory: "",
      itemQuantity: "");

  // Verify that 'addStock' correctly adds a StockModel to 'stockList'
  test('Verify that addStock correctly adds a StockModel to stockList', () {
    // Arrange
    Get.put(StockController());
    var stockController = StockController.instance;
    var stockItem = localStockItem;
    // Act
    stockController.addStock(stockItem);

    // Assert
    expect(stockController.stockList.contains(stockItem), true);
  });

  // Ensure that removing a stock item decreases the stockList size
  test('Test addStock with null input', () {
    // Arrange
    Get.put(StockController());
    var controller = StockController.instance;
    var stockItem = localStockItem;
    controller.addStock(stockItem);
    var initialSize = controller.stockList.length;

    // Act
    controller.removeStock(stockItem);

    // Assert
    expect(controller.stockList.length, initialSize - 1);
  });

  // EDGE CASES
  // Evaluate performance implications of large stockList manipulations
  test('Verify performance implications of large stockList manipulations', () {
    // Arrange
    Get.put(StockController());
    var controller = StockController.instance;
    // note stockList is instantiated with a single localStockItem
    var stockList = List.generate(10000, (index) => localStockItem);

    // Act
    for (var item in stockList) {
      controller.addStock(item);
    }

    // Assert
    expect(controller.stockList.length, 10001);
  });

// test('Verify memory leaks after adding and removing stocks', () {
//     // Arrange
//     Get.put(StockController());
//     var stockController = StockController.instance;
//     var stockItem = localStockItem;

  Future<int> getHeapMemoryUsage(VmService vmService) async {
    // Retrieve the VM object, which contains a list of isolates.
    VM vm = await vmService.getVM();

    // Assuming there is at least one isolate, take the first one.
    IsolateRef isolateRef = vm.isolates!.first;

    // Get memory usage statistics for the isolate.
    MemoryUsage memoryUsage = await vmService.getMemoryUsage(isolateRef.id!);

    // Calculate the total heap usage.
    int totalHeapUsage = memoryUsage.heapUsage!;

    return totalHeapUsage;
  }

// Check for memory lost
  test('Verify no memory leaks in StockController after operations', () async {
    // Arrange
    Get.put(StockController());
    var controller = StockController.instance;
    var stockList = List.generate(100000, (index) => localStockItem);

    // Connect to VM Service
    final serviceInfo = await developer.Service.getInfo();
    final serviceProtocolUrl = serviceInfo.serverUri?.toString() ??
        "ws://127.0.0.1:55375/GhXlcMzX2fs=/ws";

    final vmService = await vmServiceConnectUri(serviceProtocolUrl);

    // Capture memory usage before operation
    final beforeMemoryUsage = await getHeapMemoryUsage(vmService);

    // Act
    for (var item in stockList) {
      controller.addStock(item);
    }

    // Delay to allow for potential GC
    await Future.delayed(const Duration(seconds: 5));

    // Capture memory usage after operation
    final afterMemoryUsage = await getHeapMemoryUsage(vmService);

    // Assert
    // Define an acceptable memory increase threshold
    const acceptableMemoryIncrease = 1024 * 1024; // 1 MB
    expect(
        afterMemoryUsage - beforeMemoryUsage < acceptableMemoryIncrease, true);

    // Optionally, clean up
    controller.clearStock();
    await Future.delayed(const Duration(seconds: 5));
    final finalMemoryUsage = await getHeapMemoryUsage(vmService);
    expect(
        finalMemoryUsage - beforeMemoryUsage < acceptableMemoryIncrease, true);

    // Close VM Service connection
    await vmService.dispose();
  });

  // // Check addNewItem does not proceed if itemPic is null
  // test('Check addNewItem does not proceed if itemPic is null', () {
  //   // Arrange
  //   final controller = AddItemController();
  //   final mockRepo = MockAddItemRepo();
  //   Get.put<AddItemRepo>(mockRepo);
  //   controller.itemPic.value = null;

  //   // Act
  //   controller.addNewItem();

  //   // Assert
  //   verifyNever(mockRepo.saveItemData());
  // });

}
