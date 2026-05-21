import 'package:get/get.dart';

import '../../tabs/sellerDashboard_tab/getx/controllers/seller_dashboard_controller.dart';
import '../../tabs/sellerEarnings_tab/getx/controllers/seller_earnings_controller.dart';
import '../../tabs/sellerProfile_tab/getx/controllers/seller_profile_controller.dart';
import '../../tabs/sellerProducts_tab/getx/controllers/seller_products_controller.dart';
import '../controllers/seller_bottom_nav_bar_controller.dart';

class SellerBottomNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerBottomNavBarController>(
      () => SellerBottomNavBarController(),
    );
    Get.lazyPut<SellerDashboardController>(() => SellerDashboardController());
    Get.lazyPut<SellerProductsController>(() => SellerProductsController());
    Get.lazyPut<SellerEarningsController>(() => SellerEarningsController());
    Get.lazyPut<SellerProfileController>(() => SellerProfileController());
  }
}
