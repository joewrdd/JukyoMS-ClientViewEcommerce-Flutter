import 'dart:convert';

import 'package:get/get.dart';
import 'package:jukyo_ms/data/repos/products/product_repository.dart';
import 'package:jukyo_ms/utils/local_storage/storage.dart';
import 'package:jukyo_ms/utils/popups/loaders.dart';
import 'package:jukyo_ms/views/shop/models/product_model.dart';

class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.find();

  //----- Variables -----
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  //----- Initialize Favorites By Reading From Storage -----
  void initFavorites() {
    // Read Favorites From Storage
    final json = LocalStorage.instance().readData('favorites');
    // If Favorites Exist, Assign Them To The Observable
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  //----- Is Item Favorite -----
  bool isFavorite(String productId) {
    return favorites[productId] ?? false;
  }

  //----- Toggle Favorite -----
  void toggleFavorite(String productId) {
    // If Product Is Not In Favorites, Add It
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      Loaders.customToast(message: 'Product Added To The Wishlist.');
    } else {
      // If Product Is In Favorites, Remove It
      LocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      Loaders.customToast(message: 'Product Removed From The Wishlist.');
    }
  }

  //----- Save Favorites To Storage -----
  void saveFavoritesToStorage() {
    // Encode Favorites To JSON
    final encodedJsonFavorites = json.encode(favorites);
    // Save JSON To Storage
    LocalStorage.instance().saveData('favorites', encodedJsonFavorites);
  }

  //----- Get Favorite Products -----
  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance
        .getFavoriteProducts(favorites.keys.toList());
  }
}
