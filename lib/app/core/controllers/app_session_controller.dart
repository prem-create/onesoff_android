import 'package:get/get.dart';

class AppSessionController extends GetxController {
  final RxnString role = RxnString();
  final RxString mobileNumber = ''.obs;

  void setRole(String userRole) {
    role.value = userRole;
  }

  void setMobileNumber(String phone) {
    mobileNumber.value = phone;
  }

  void clearSession() {
    role.value = null;
    mobileNumber.value = '';
  }
}
