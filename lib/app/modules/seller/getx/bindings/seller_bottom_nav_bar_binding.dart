import 'package:get/get.dart';

import '../../tabs/sellerDashboard_tab/getx/controllers/seller_dashboard_controller.dart';
import '../controllers/seller_bottom_nav_bar_controller.dart';

class SellerBottomNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerBottomNavBarController>(
      () => SellerBottomNavBarController(),
    );
    Get.lazyPut<SellerDashboardController>(() => SellerDashboardController());
  }
}
