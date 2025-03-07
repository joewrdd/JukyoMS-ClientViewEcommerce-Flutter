import 'package:get/get.dart';
import 'package:jukyo_ms/data/repos/categories/category_repository.dart';
import 'package:jukyo_ms/data/repos/products/product_repository.dart';
import 'package:jukyo_ms/utils/dummy/category_data.dart';
import 'package:jukyo_ms/utils/popups/loaders.dart';
import 'package:jukyo_ms/views/shop/models/category_model.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  final RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  final RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  //----- Load Category Data -----
  Future<void> fetchCategories() async {
    try {
      // Show Loader While Loading Categories
      isLoading.value = true;

      // Fetch Categories From Data Source (Firestore, API, etc.)
      final categories = await _categoryRepository.getAllCategories();

      // Update The Categories List
      allCategories.assignAll(categories);

      // Filter Featured Categories
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(9)
          .toList());
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Remove Loader
      isLoading.value = false;
    }
  }

  //----- Load Selected Category Data -----
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      // Get Sub Categories For Selected Category
      final subCategories =
          await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  //----- Get Category or Sub-Category Products -----
  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryId, int limit = 4}) async {
    try {
      // Get 4 Limited Products For Each Sub Category
      final products = await ProductRepository.instance
          .getProductsForCategory(categoryId: categoryId, limit: limit);
      return products;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  //----- Upload Categories From DummyData To App -----
  Future<void> uploadCategories() async {
    try {
      // Set Loading State To True
      isLoading.value = true;

      // Loop Through Each Category
      for (var category in CategoryDummyData.categories) {
        // Check If Category Already Exists in Firestore
        final existingCategory =
            await _categoryRepository.getCategoryById(category.id);
        if (existingCategory == null) {
          // If It Doesn't Exist, Upload The Category
          await _categoryRepository.uploadDummyData([category]);
        }
      }

      Loaders.successSnackBar(
          title: 'Success!', message: 'Categories Uploaded Successfully.');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error!', message: e.toString());
    } finally {
      // Remove Loading State
      isLoading.value = false;
    }
  }
}
