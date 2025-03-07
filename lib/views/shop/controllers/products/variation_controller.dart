import 'package:get/get.dart';
import 'package:jukyo_ms/views/shop/controllers/products/cart_controller.dart';
import 'package:jukyo_ms/views/shop/controllers/products/image_controller.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';
import 'package:jukyo_ms/views/shop/models/product_variation_model.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  //----- Variables -----
  RxMap selectedAttributes = {}.obs;
  RxString selectedStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;
  Rx<ProductModel?> currentProduct = Rx<ProductModel?>(null);

  //----- Select Attribute & Variation -----
  void onAttributeSelected(
      ProductModel product, String attributeName, String attributeValue) {
    // When Attribute Is Selected We Will First Add That Attribute To The Selected Attributes
    final selectedAttributes =
        Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    // Then We Will Check If The Selected Attributes Match Any Variation
    final selectedVariation = product.productVariations!.firstWhere(
        (variation) => _isSameAttributeValues(
            variation.attributeValues, selectedAttributes),
        orElse: () => ProductVariationModel.empty());

    // Show Selected Variation Image As A Main Image
    if (selectedVariation.image.isNotEmpty) {
      ImageController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    // Show Selected Variation Quantity Already In Cart
    if (selectedVariation.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController
          .getVariationQuantityInCart(product.id, selectedVariation.id);
    }

    // Assign Selected Variation To The Selected Variation Variable
    this.selectedVariation.value = selectedVariation;

    // Update The Stock Status After Selecting A Variation
    getProductVariationStockStatus();
  }

  //----- Check If The Selected Attributes Match Any Variation -----
  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAttributes) {
    if (variationAttributes.length != selectedAttributes.length) {
      return false;
    }

    // If All Attributes Match, Return True
    for (final key in variationAttributes.keys) {
      // If Any Attribute Does Not Match, Return False
      if (variationAttributes[key] != selectedAttributes[key]) {
        return false;
      }
    }
    return true;
  }

  //----- Check Attribute Availability / Stock In Variation -----
  Set<String?> getAttributesAvailabilityInVariation(
      List<ProductVariationModel> variations, String attributeName) {
    // Pass The Variations To Check Which Attributes Are Available & Stock Is Not 0
    final availableVariationAttributeValues = variations
        .where((variation) =>
            variation.attributeValues[attributeName] != null &&
            variation.attributeValues[attributeName]!.isNotEmpty &&
            variation.stock > 0)
        // Fetch All Non-Empty Attributes Of Variations
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();

    return availableVariationAttributeValues;
  }

  //----- Gets Variation Price -----
  String getVariationPrice() {
    return selectedVariation.value.salePrice > 0
        ? selectedVariation.value.salePrice.toStringAsFixed(2)
        : selectedVariation.value.price.toStringAsFixed(2);
  }

  //----- Check Product Variation Stock Status -----
  void getProductVariationStockStatus() {
    selectedStockStatus.value =
        selectedVariation.value.stock > 0 ? 'Available' : 'Out of Stock';
  }

  //----- Reset Selected Attributes When Switching Products
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    selectedStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
    currentProduct.value = null;
  }
}
