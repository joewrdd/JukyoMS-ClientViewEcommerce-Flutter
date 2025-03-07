import 'package:get/get.dart';
import 'package:jukyo_ms/data/repos/banners/banner_repository.dart';
import 'package:jukyo_ms/utils/dummy/banner_data.dart';
import 'package:jukyo_ms/utils/popups/loaders.dart';
import 'package:jukyo_ms/views/shop/models/banner_model.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  final _bannerRepository = Get.put(BannerRepository());
  final isLoading = false.obs;
  final carousalCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  //----- Update Page Navigational Dots -----
  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  //----- Fetch Banners -----
  Future<void> fetchBanners() async {
    try {
      // Show Loader While Loading Categories
      isLoading.value = true;

      // Fetch Banners
      final banners = await _bannerRepository.fetchBanners();

      // Assign Banners
      this.banners.assignAll(banners);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Remove Loader
      isLoading.value = false;
    }
  }

  //----- Upload Banners From DummyData To App -----
  Future<void> uploadBanners() async {
    try {
      // Set Loading State To True
      isLoading.value = true;

      // Loop Through Each Banner
      for (var banner in BannerDummyData.banners) {
        // Check If Category Already Exists in Firestore
        final existingBanner = await _bannerRepository.getBannerById(banner.id);
        if (existingBanner == null) {
          // If It Doesn't Exist, Upload The Banner
          await _bannerRepository.uploadDummyData([banner]);
        }
      }

      Loaders.successSnackBar(
          title: 'Success!', message: 'Banners Uploaded Successfully.');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error!', message: e.toString());
    } finally {
      // Remove Loading State
      isLoading.value = false;
    }
  }
}
