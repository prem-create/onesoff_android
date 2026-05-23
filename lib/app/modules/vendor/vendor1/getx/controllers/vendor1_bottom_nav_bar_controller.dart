import 'package:get/get.dart';

class Vendor1BottomNavBarController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;

  void setTab(int index) {
    if (index == selectedTabIndex.value) {
      return;
    }

    selectedTabIndex.value = index;
  }
}
