import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/data/repos/products/product_repository.dart';
import 'package:jukyo_ms/utils/popups/loaders.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final productRepository = ProductRepository.instance;
  // Selected Sort Option
  final RxString selectedSortOption = 'Name'.obs;
  // Products List After Sorting
  final RxList<ProductModel> products = <ProductModel>[].obs;

  //----- Fetch Products By Query -----
  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if (query == null) {
        return [];
      }
      final products = await productRepository.fetchProductsByQuery(query);
      return products;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  //----- Sort Products -----
  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;
    switch (sortOption) {
      case 'Name':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Highest Price':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lowest Price':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Sale':
        products.sort((a, b) {
          if (b.salePrice > 0) {
            return b.salePrice.compareTo(a.salePrice);
          } else if (a.salePrice > 0) {
            return -1;
          } else {
            return 1;
          }
        });
        break;
      case 'Newest':
        products.sort((a, b) => b.date!.compareTo(a.date!));
        break;
      case 'Most Popular':
        products.sort((a, b) => (b.isFeatured ?? false ? 1 : 0)
            .compareTo(a.isFeatured ?? false ? 1 : 0));
        break;
      default:
        products.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  //----- -----
  void assignProducts(List<ProductModel> productsList) {
    products.assignAll(productsList);
    sortProducts('Name');
  }
}
