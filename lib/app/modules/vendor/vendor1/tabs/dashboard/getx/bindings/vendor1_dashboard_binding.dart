import 'package:get/get.dart';

import '../controllers/vendor1_dashboard_controller.dart';

class Vendor1DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Vendor1DashboardController>(() => Vendor1DashboardController());
  }
}
