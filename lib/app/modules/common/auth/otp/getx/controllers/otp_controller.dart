import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/controllers/app_session_controller.dart';
import '../../../../../../routes/appRoutes.dart';

class OtpController extends GetxController {
  final AppSessionController session = Get.find<AppSessionController>();
  final List<TextEditingController> otpControllers = List<TextEditingController>.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> otpFocusNodes = List<FocusNode>.generate(
    6,
    (_) => FocusNode(),
  );

  late final String mobileNumber;

  @override
  void onInit() {
    super.onInit();
    mobileNumber = (Get.arguments as String?) ?? session.mobileNumber.value;
  }

  void onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < otpFocusNodes.length - 1) {
      otpFocusNodes[index + 1].requestFocus();
      return;
    }
    if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
  }

  String get otpValue => otpControllers.map((TextEditingController controller) => controller.text).join();

  void onVerifyOtp() {
    if (otpValue.length < 6) {
      Get.snackbar(
        'OTP Required',
        'Please enter all 6 digits of OTP.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.offAllNamed(AppRoutes.userSelection);
  }

  void onChangeMobileNumber() {
    Get.back();
  }

  @override
  void onClose() {
    for (final TextEditingController controller in otpControllers) {
      controller.dispose();
    }
    for (final FocusNode node in otpFocusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}
