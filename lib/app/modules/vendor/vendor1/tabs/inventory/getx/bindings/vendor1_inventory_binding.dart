import 'package:get/get.dart';

import '../controllers/vendor1_inventory_controller.dart';

class Vendor1InventoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Vendor1InventoryController>(() => Vendor1InventoryController());
  }
}
