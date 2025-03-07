import 'package:get/get.dart';
import 'package:jukyo_ms/data/repos/products/product_repository.dart';
import 'package:jukyo_ms/utils/dummy/product_data.dart';
import 'package:jukyo_ms/utils/enums/product_type.dart';
import 'package:jukyo_ms/utils/popups/loaders.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  //----- Fetch Featured Products -----
  void fetchFeaturedProducts() async {
    try {
      // Show Loader
      isLoading.value = true;

      // Fetch Featured Products
      final products = await productRepository.getFeaturedProducts();

      // Assign Products To The List
      featuredProducts.assignAll(products);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //----- Fetch All Featured Products
  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      // Fetch All Products
      final products = await productRepository.getAllFeaturedProducts();
      return products;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  //----- Get Product Price -----
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // If No Variations Exist, Return The Simple Price or Sale Price
    if (product.productType == ProductType.single.toString()) {
      return product.salePrice > 0
          ? product.salePrice.toStringAsFixed(2)
          : product.price.toStringAsFixed(2);
    } else {
      // Get The Smallest and Largest Price
      for (var variation in product.productVariations ?? []) {
        // Add null check
        // Determine The Price To Consider (Sale Price If Available, Otherwise Regular Price)
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // Update The Smallest and Largest Price
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      // If The Prices Are The Same, Return The Price
      if (smallestPrice == largestPrice) {
        return smallestPrice.toStringAsFixed(2);
      } else {
        // Otherwise, Return The Price Range
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  //----- Calculate Discount Percentage -----
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice == 0.0) return null;
    if (originalPrice <= 0) return null;
    double discount = originalPrice - salePrice;
    double percentage = (discount / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  //----- Get Stock Status -----
  String getStockStatus(int stock) {
    if (stock > 0) {
      return 'In Stock';
    } else {
      return 'Out of Stock';
    }
  }

  //----- Upload Products From DummyData To App -----
  Future<void> uploadProducts() async {
    try {
      // Set Loading State To True
      isLoading.value = true;

      // Loop Through Each Product
      for (var product in ProductDummyData.products) {
        final existingProduct =
            await productRepository.getProductById(product.id);
        if (existingProduct != null) {
          continue;
        }
        await productRepository.uploadDummyData([product]);
      }

      Loaders.successSnackBar(
          title: 'Success!', message: 'Products Uploaded Successfully.');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error!', message: e.toString());
    } finally {
      // Remove Loading State
      isLoading.value = false;
    }
  }
}
