import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spacemall/src/features/core_app/check_out/application/check_out_controller.dart';
import 'package:spacemall/src/features/core_app/check_out/domain/check_out_model.dart';
import 'package:spacemall/src/features/core_app/check_out/screens/widgets/single_cart_item.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // CheckOutController checkOutController = Get.find();

    final checkOutController = Get.put(CheckOutController());
    return Obx(() => GridView.count(
        crossAxisCount: 3,
        childAspectRatio: .63,
        padding: const EdgeInsets.all(10),
        mainAxisSpacing: 4,
        crossAxisSpacing: 10,
        children: []
        //     checkOutController.cartItems.map((CheckOutModel cartElement) {
        //   return const SingleCartItemWidget();
        // }).toList(),
        ));
  }
}
