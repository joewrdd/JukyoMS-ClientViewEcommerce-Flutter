import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/common/widgets/success_screen/success.dart';
import 'package:jukyo_ms/data/repos/authentication/auth_repo.dart';
import 'package:jukyo_ms/data/repos/orders/order_repository.dart';
import 'package:jukyo_ms/navigation.dart';
import 'package:jukyo_ms/utils/enums/enums.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/popups/fullscreen_loader.dart';
import 'package:jukyo_ms/utils/popups/loaders.dart';
import 'package:jukyo_ms/views/personalization/controllers/address_controller.dart';
import 'package:jukyo_ms/views/shop/controllers/checkout_controller.dart';
import 'package:jukyo_ms/views/shop/controllers/products/cart_controller.dart';
import 'package:jukyo_ms/views/shop/models/order_model.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  //----- Variables -----
  final cartController = Get.put(CartController());
  final addressController = Get.put(AddressController());
  final checkoutController = Get.put(CheckoutController());
  final orderRepository = Get.put(OrderRepository());

  //----- Fetch User's Order History -----
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  //----- Add Methods For Order Processing -----
  void processOrder(double totalAmount) async {
    try {
      // Start Loader
      TFullScreenLoader.openLoadingDialog(
          'Processing Your Order...', ConstantImages.addingNewAddress);

      // Get User Authentication Id
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      // Calculate Delivery Date (3-5 days from now)
      final deliveryDate = DateTime.now().add(Duration(
          days: 3 + (2 * (DateTime.now().millisecondsSinceEpoch % 2))));

      // Add Details
      final order = OrderModel(
          id: UniqueKey().toString(),
          userId: userId,
          status: OrderStatus.pending,
          items: cartController.cartItems.toList(),
          paymentMethod: checkoutController.selectedPaymentMethod.value.name,
          address: addressController.selectedAddress.value,
          totalAmount: totalAmount,
          deliveryDate: deliveryDate,
          orderDate: DateTime.now());

      // Save The Order To Firestore
      await orderRepository.saveOrder(order, userId);

      // Update Cart Status
      cartController.clearCart();

      // Show Success Screen
      Get.off(
        () => SuccessScreen(
          image: ConstantImages.successfullyPurchased,
          title: 'Payment Successful',
          subTitle:
              'Your order has been placed successfully. Thank you for shopping with JukyoMS!',
          onPressed: () => Get.offAll(() => const NavigationMenu()),
        ),
      );
    } catch (e) {
      // Handle Error
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
