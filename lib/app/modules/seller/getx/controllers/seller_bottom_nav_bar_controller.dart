import 'package:get/get.dart';

class SellerBottomNavBarController extends GetxController {
  final RxInt selectedTabIndex = 0.obs;

  void setTab(int index) {
    if (index == selectedTabIndex.value) {
      return;
    }
    selectedTabIndex.value = index;
  }
}
