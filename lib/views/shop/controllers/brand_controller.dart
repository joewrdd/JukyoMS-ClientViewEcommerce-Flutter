import 'package:get/get.dart';
import 'package:jukyo_ms/data/repos/brands/brand_repository.dart';
import 'package:jukyo_ms/data/repos/products/product_repository.dart';
import 'package:jukyo_ms/utils/popups/loaders.dart';
import 'package:jukyo_ms/views/shop/models/brand_model.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    super.onInit();
    getFeaturedBrands();
  }

  //----- Load Brands -----
  Future<void> getFeaturedBrands() async {
    try {
      // Show Loader
      isLoading.value = true;

      // Get All Brands
      final brands = await brandRepository.getAllBrands();
      allBrands.assignAll(brands);

      // Get Featured Brands
      featuredBrands.assignAll(
          allBrands.where((brand) => brand.isFeatured ?? false).take(4));
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Hide Loader
      isLoading.value = false;
    }
  }

  //----- Get Brands For Category -----
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  //----- Get Brand Specific Products From Your Data Source
  Future<List<ProductModel>> getBrandProducts(
      {required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance
          .getProductsForBrand(brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}
