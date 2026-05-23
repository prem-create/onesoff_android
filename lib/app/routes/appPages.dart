import 'package:get/get.dart';
import 'package:onesoff/app/modules/vendor/adminAsVendor_module5/tabs/adminAsVendor_tab.dart';
import 'package:onesoff/app/modules/vendor/shopOwner_module4/tabs/shopOwner_tab.dart';

import '../modules/common/auth/login/getx/controllers/login_controller.dart';
import '../modules/common/auth/otp/getx/controllers/otp_controller.dart';
import '../modules/common/auth/login/view/login_screen.dart';
import '../modules/common/auth/otp/view/otp_verification_screen.dart';
import '../modules/common/onboarding/getx/controllers/onboarding_controller.dart';
import '../modules/common/onboarding/view/onboarding_screen.dart';
import '../modules/common/splash/getx/controllers/splash_controller.dart';
import '../modules/common/splash/view/splash_screen.dart';
import '../modules/common/welcome/user_selection_screen.dart';
import '../modules/customer/home/getx/customer_home_controller.dart';
import '../modules/customer/home/customer_home_screen.dart';
import '../modules/customer/productDetails/customer_product_details_screen.dart';
import '../modules/customer/search/customer_search_screen.dart';
import '../modules/customer/search/getx/customer_search_controller.dart';
import '../modules/seller/getx/bindings/seller_bottom_nav_bar_binding.dart';
import '../modules/seller/seller_bottom_nav_bar.dart';
import '../modules/vendor/vendor1/getx/bindings/vendor1_bottom_nav_bar_binding.dart';
import '../modules/vendor/vendor1/vendor1_bottom_nav_bar.dart';

import '../modules/vendor/commonOnboarding/getx/contollers/vendorOnboarding_controller.dart';
import '../modules/vendor/commonOnboarding/vendorOnboarding_screen.dart';
import 'appRoutes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      binding: BindingsBuilder(() {
        Get.put(OnboardingController());
      }),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        Get.put(LoginController());
      }),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () => const OtpVerificationScreen(),
      binding: BindingsBuilder(() {
        Get.put(OtpController());
      }),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.userSelection,
      page: () => const UserSelectionScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.customerDashboard,
      page: () => const CustomerHomeScreen(),
      binding: BindingsBuilder(() {
        Get.put(CustomerHomeController());
      }),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.customerSearch,
      page: () => const CustomerSearchScreen(),
      binding: BindingsBuilder(() {
        Get.put(CustomerSearchController());
      }),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.customerProductDetails,
      page: () => const CustomerProductDetailsScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.vendorOnboarding,
      page: () => const VendorOnboardingScreen(),
      binding: BindingsBuilder(() {
        Get.put(VendorOnboardingController());
      }),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.seller,
      page: () => const SellerBottomNavBar(),
      binding: SellerBottomNavBarBinding(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: AppRoutes.shopOwner,
      page: () => const ShopOwnerTab(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: AppRoutes.adminAsVendor,
      page: () => const AdminAsVendorTab(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.vendor1,
      page: () => const Vendor1BottomNavBar(),
      binding: Vendor1BottomNavBarBinding(),
      transition: Transition.cupertino,
    ),
  ];
}
