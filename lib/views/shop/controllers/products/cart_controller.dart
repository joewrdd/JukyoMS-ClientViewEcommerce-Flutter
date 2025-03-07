import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/utils/constants/colors.dart';
import 'package:jukyo_ms/utils/enums/product_type.dart';
import 'package:jukyo_ms/utils/local_storage/storage.dart';
import 'package:jukyo_ms/utils/popups/loaders.dart';
import 'package:jukyo_ms/views/shop/controllers/products/variation_controller.dart';
import 'package:jukyo_ms/views/shop/models/cart_item_model.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  //----- Variables -----
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  //----- Constructor -----
  CartController() {
    loadCartItems();
  }

  //----- Add Items to Cart -----
  void addToCart(ProductModel product) {
    // Quantity Check
    if (productQuantityInCart.value < 1) {
      Loaders.customToast(message: 'Please Select Quantity');
      return;
    }

    // Check If Variation Is Empty
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      Loaders.customToast(message: 'Please Select A Variation');
      return;
    }
    // Out Of Stock Check
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock <= 0) {
        Loaders.warningSnackBar(
            message: 'Product Out Of Stock', title: 'Oops!');
        return;
      }
    } else {
      if (product.stock <= 0) {
        Loaders.warningSnackBar(
            message: 'Product Out Of Stock', title: 'Oops!');
        return;
      }
    }
    // Convert The ProductModel To CartItemModel With Quantity
    final cartItem = convertToCartItem(product, productQuantityInCart.value);

    // Check If The Product Is Already In The Cart
    int index = cartItems.indexWhere((element) =>
        element.productId == cartItem.productId &&
        element.variationId == cartItem.variationId);

    // If The Product Is Already In The Cart, Update The Quantity
    if (index >= 0) {
      cartItems[index].quantity = cartItem.quantity;
    }
    // If The Product Is Not In The Cart, Add It To The Cart
    else {
      cartItems.add(cartItem);
    }

    // Update The Cart
    updateCart();
    Loaders.addedToCartSnackBar(
      title: 'Added To Cart',
    );
  }

  //----- Update Cart -----
  void updateCart() {
    // Update Cart Totals
    updateCartTotals();

    // Save The Cart Items
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    LocalStorage.instance().saveData('cartItems', cartItemStrings);

    // Refresh The Cart Items
    cartItems.refresh();
  }

  //----- Function To Update Card Totals -----
  void updateCartTotals() {
    // Calculate Total Price And No Of Cart Items
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfCartItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfCartItems += item.quantity;
    }
    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfCartItems;
  }

  //----- Load Cart Items -----
  void loadCartItems() {
    final cartItemStrings =
        LocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  //----- Get Product Quantity In Cart -----
  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

//----- Get Variation Quantity In Cart -----
  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
        (item) =>
            item.productId == productId && item.variationId == variationId,
        orElse: () => CartItemModel.empty());
    return foundItem.quantity;
  }

//----- Add One Item To Cart -----
  void addOneItemToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

//----- Remove One Item From Cart -----
  void removeOneItemFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
    }
    updateCart();
  }

//----- Remove Item From Cart -----
  void removeItemFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      cartItems[index].quantity == 1
          ? removeFromCartDialog(index)
          : cartItems.removeAt(index);
    }
    updateCart();
  }

//----- Remove From Cart Dialog -----
  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      radius: 30,
      title: 'Remove From Cart',
      titleStyle: TextStyle(
        color: ConstantColors.dark,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      middleText: 'Are You Sure You Want To Remove This Item From The Cart?',
      middleTextStyle: TextStyle(
        color: ConstantColors.dark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      textConfirm: 'Remove',
      textCancel: 'Cancel',
      cancelTextColor: ConstantColors.dark,
      confirmTextColor: ConstantColors.fourth,
      backgroundColor: ConstantColors.fourth,
      buttonColor: ConstantColors.primary,
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        Loaders.customToast(message: 'Product Removed From Cart');
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );
  }

//----- Clear Cart -----
  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  //----- Function To Convert Product To Cart Item -----
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      variationController.resetSelectedAttributes();
    }
    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0.0
            ? product.salePrice
            : product.price;
    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      image: isVariation ? variation.image : product.thumbnail,
      quantity: quantity,
      variationId: variation.id,
      brandName: product.brand != null ? product.brand!.name : '',
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }

  //----- Intialize Already Added Item's Count In Cart -----
  void updateAlreadyAddedProductCount(ProductModel product) {
    // If Cart Has No Variations, Calculate Cart Entries & Display Total
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      // If Cart Has Variations, Calculate Cart Entries & Display Total
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value =
            getVariationQuantityInCart(product.id, variationId);
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }
}
