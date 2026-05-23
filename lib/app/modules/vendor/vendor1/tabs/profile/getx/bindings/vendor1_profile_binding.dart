import 'package:get/get.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/profile/getx/controllers/vendor1_profile_controller.dart';

class Vendor1ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Vendor1ProfileController>(() => Vendor1ProfileController());
  }
}
