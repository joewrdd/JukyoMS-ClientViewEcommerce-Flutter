import 'package:jukyo_ms/routes/routes.dart';
import 'package:jukyo_ms/views/auth/screens/login/login.dart';
import 'package:jukyo_ms/views/auth/screens/onboarding/onboarding.dart';
import 'package:jukyo_ms/views/auth/screens/password_config/forget_password.dart';
import 'package:jukyo_ms/views/auth/screens/signup/signup.dart';
import 'package:jukyo_ms/views/auth/screens/signup/verify_email.dart';
import 'package:jukyo_ms/views/personalization/screens/address/address.dart';
import 'package:jukyo_ms/views/personalization/screens/profile/profile.dart';
import 'package:jukyo_ms/views/personalization/screens/settings/settings.dart';
import 'package:jukyo_ms/views/shop/screens/cart/cart.dart';
import 'package:jukyo_ms/views/shop/screens/checkout/checkout.dart';
import 'package:jukyo_ms/views/shop/screens/home/home.dart';
import 'package:jukyo_ms/views/shop/screens/order/orders.dart';
import 'package:jukyo_ms/views/shop/screens/product_reviews/product_reviews.dart';
import 'package:jukyo_ms/views/shop/screens/store/store.dart';
import 'package:jukyo_ms/views/shop/screens/wishlist/wishlist.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: CustomRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: CustomRoutes.store,
      page: () => const StoreScreen(),
    ),
    GetPage(
      name: CustomRoutes.favourites,
      page: () => const WishlistScreen(),
    ),
    GetPage(
      name: CustomRoutes.settings,
      page: () => const SettingsScreen(),
    ),
    GetPage(
      name: CustomRoutes.productReviews,
      page: () => ProductReviewsScreen(productId: Get.arguments),
    ),
    GetPage(
      name: CustomRoutes.order,
      page: () => const OrdersScreen(),
    ),
    GetPage(
      name: CustomRoutes.checkout,
      page: () => const CheckoutScreen(),
    ),
    GetPage(
      name: CustomRoutes.cart,
      page: () => const CartScreen(),
    ),
    GetPage(
      name: CustomRoutes.userProfile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: CustomRoutes.userAddress,
      page: () => const AddressScreen(),
    ),
    GetPage(
      name: CustomRoutes.signup,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: CustomRoutes.verifyEmail,
      page: () => const VerifyEmailScreen(),
    ),
    GetPage(
      name: CustomRoutes.signIn,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: CustomRoutes.forgetPassword,
      page: () => const ForgetPasswordScreen(),
    ),
    GetPage(
      name: CustomRoutes.onBoarding,
      page: () => const OnBoardingScreen(),
    ),
  ];
}
