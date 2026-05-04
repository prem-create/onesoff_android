import 'package:get/get.dart';

import '../screens/common/auth/getx/login_controller.dart';
import '../screens/common/auth/getx/otp_controller.dart';
import '../screens/common/auth/login_screen.dart';
import '../screens/common/auth/otp_verification_screen.dart';
import '../screens/common/onboarding/getx/onboarding_controller.dart';
import '../screens/common/onboarding/onboarding_screen.dart';
import '../screens/common/splash/getx/splash_controller.dart';
import '../screens/common/splash/splash_screen.dart';
import '../screens/common/welcome/user_selection_screen.dart';
import '../screens/customerPortion/home/getx/customer_home_controller.dart';
import '../screens/customerPortion/home/customer_home_screen.dart';
import '../screens/customerPortion/productDetails/customer_product_details_screen.dart';
import '../screens/customerPortion/search/customer_search_screen.dart';
import '../screens/customerPortion/search/getx/customer_search_controller.dart';
import '../screens/vendorPortion/home/vendor_home_screen.dart';
import '../screens/vendorPortion/onboarding/getx/vendor_onboarding_controller.dart';
import '../screens/vendorPortion/onboarding/vendor_onboarding_screen.dart';
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
      name: AppRoutes.vendorDashboard,
      page: () => const VendorHomeScreen(),
      transition: Transition.cupertino,
    ),
  ];
}
