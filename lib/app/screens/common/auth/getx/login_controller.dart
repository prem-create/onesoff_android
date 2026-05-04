import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/app_session_controller.dart';
import '../../../../routes/appRoutes.dart';

class LoginController extends GetxController {
  final TextEditingController mobileController = TextEditingController();
  final AppSessionController session = Get.find<AppSessionController>();

  String _normalizedPhone(String raw) {
    return raw.replaceAll(RegExp(r'[^0-9]'), '');
  }

  void onRequestOtp() {
    final String phone = _normalizedPhone(mobileController.text.trim());
    if (phone.length != 10) {
      Get.snackbar(
        'Invalid Number',
        'Please enter a valid 10 digit mobile number.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    session.setMobileNumber(phone);
    Get.toNamed(AppRoutes.otpVerification, arguments: phone);
  }

  void onGuestLoginAsCustomer() {
    session.setRole('customer');
    Get.offAllNamed(AppRoutes.customerDashboard);
  }

  @override
  void onClose() {
    mobileController.dispose();
    super.onClose();
  }
}
