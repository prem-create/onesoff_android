import 'package:get/get.dart';

import '../controllers/seller_earnings_controller.dart';

class SellerEarningsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerEarningsController>(() => SellerEarningsController());
  }
}
