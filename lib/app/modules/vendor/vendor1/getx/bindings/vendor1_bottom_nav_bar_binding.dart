import 'package:get/get.dart';

import '../../tabs/dashboard/getx/controllers/vendor1_dashboard_controller.dart';
import '../../tabs/earnings/getx/controllers/vendor1_earnings_controller.dart';
import '../../tabs/inventory/getx/controllers/vendor1_inventory_controller.dart';
import '../../tabs/orders/getx/controllers/vendor1_orders_controller.dart';
import '../../tabs/profile/getx/controllers/vendor1_profile_controller.dart';
import '../controllers/vendor1_bottom_nav_bar_controller.dart';

class Vendor1BottomNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Vendor1BottomNavBarController>(
      () => Vendor1BottomNavBarController(),
    );
    Get.lazyPut<Vendor1DashboardController>(() => Vendor1DashboardController());
    Get.lazyPut<Vendor1InventoryController>(() => Vendor1InventoryController());
    Get.lazyPut<Vendor1OrdersController>(() => Vendor1OrdersController());
    Get.lazyPut<Vendor1EarningsController>(() => Vendor1EarningsController());
    Get.lazyPut<Vendor1ProfileController>(() => Vendor1ProfileController());
  }
}
