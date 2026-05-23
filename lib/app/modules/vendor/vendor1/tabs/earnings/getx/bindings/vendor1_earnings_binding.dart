import 'package:get/get.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/earnings/getx/controllers/vendor1_earnings_controller.dart';

class Vendor1EarningsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Vendor1EarningsController>(() => Vendor1EarningsController());
  }
}
