import 'package:get/get.dart';

import '../../../../../routes/appRoutes.dart';

class SplashController extends GetxController {
  static const Duration _delay = Duration(seconds: 3);

  @override
  void onReady() {
    super.onReady();
    _moveToOnboarding();
  }

  Future<void> _moveToOnboarding() async {
    await Future<void>.delayed(_delay);
    if (isClosed) return;
    Get.offNamed(AppRoutes.onboarding);
  }
}
