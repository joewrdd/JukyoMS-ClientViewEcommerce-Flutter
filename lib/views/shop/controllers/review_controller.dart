import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jukyo_ms/data/repos/reviews/review_repository.dart';
import 'package:jukyo_ms/utils/constants/images.dart';
import 'package:jukyo_ms/utils/popups/loaders.dart';
import 'package:jukyo_ms/views/shop/models/review_model.dart';
import 'package:jukyo_ms/data/repos/user/user_repository.dart';

class ReviewController extends GetxController {
  static ReviewController get instance => Get.find();

  final reviewRepository = Get.put(ReviewRepository());
  final userRepository = Get.put(UserRepository());
  final reviews = <ReviewModel>[].obs;
  final isLoading = false.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;
  final rating = 0.0.obs;
  final reviewTextController = TextEditingController();
  final productStats = Rx<Map<String, dynamic>>({
    'average': 0.0,
    'total': 0,
    'ratingCounts': List.filled(5, 0),
  });

  final currentProductId = RxString('');

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      currentProductId.value = Get.arguments;
      // Remove the following line to avoid state changes during build
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   loadProductReviews(currentProductId.value);
      // });
    }
  }

  // Load reviews for a product
  Future<void> loadProductReviews(String productId) async {
    try {
      currentProductId.value = productId; // Store current product ID
      hasError.value = false;
      errorMessage.value = '';
      isLoading.value = true;

      // Load reviews and stats concurrently
      final results = await Future.wait([
        reviewRepository.getProductReviews(productId),
        reviewRepository.getProductRatingStats(productId),
      ]);

      reviews.value = results[0] as List<ReviewModel>;
      productStats.value = results[1] as Map<String, dynamic>;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Add a new review
  Future<void> addReview(
      String productId, double ratingValue, String comment) async {
    try {
      final userDetails = await userRepository.fetchUserDetails();

      final review = ReviewModel(
        id: '',
        userId: userDetails.id,
        userName: '${userDetails.firstName} ${userDetails.lastName}'.trim(),
        userImage: userDetails.profilePicture.isNotEmpty
            ? userDetails.profilePicture
            : ConstantImages.userProfileImage1,
        productId: productId,
        rating: ratingValue,
        comment: comment,
        createdAt: DateTime.now(),
      );

      await reviewRepository.addReview(review);
      await loadProductReviews(productId);
      reviewTextController.clear();
      rating.value = 0;
      Loaders.successSnackBar(
          title: 'Success', message: 'Review added successfully');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  // Delete a review
  Future<void> deleteReview(String reviewId, String productId) async {
    try {
      await reviewRepository.deleteReview(reviewId);
      await loadProductReviews(productId);
      Loaders.successSnackBar(
          title: 'Success', message: 'Review deleted successfully');
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  @override
  void onClose() {
    reviewTextController.dispose();
    super.onClose();
  }
}
