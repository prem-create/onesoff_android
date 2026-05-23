import 'package:get/get.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/orders/getx/controllers/vendor1_orders_controller.dart';

class Vendor1OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Vendor1OrdersController>(() => Vendor1OrdersController());
  }
}
