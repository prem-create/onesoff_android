import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/appRoutes.dart';
import '../../../../../core/utils/deviceConstants/appImages.dart';
import '../../../../../core/utils/deviceConstants/appStrings.dart';

class OnboardingItem {
  const OnboardingItem({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  final String imagePath;
  final String title;
  final String description;
}

class OnboardingController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final PageController pageController = PageController();

  final List<OnboardingItem> pages = <OnboardingItem>[
    const OnboardingItem(
      imagePath: AppImages.onboarding1,
      title: AppStrings.onboardingOneTitle,
      description: AppStrings.onboardingOneDescription,
    ),
    const OnboardingItem(
      imagePath: AppImages.onboarding2,
      title: AppStrings.onboardingTwoTitle,
      description: AppStrings.onboardingTwoDescription,
    ),
    const OnboardingItem(
      imagePath: AppImages.onboarding3,
      title: AppStrings.onboardingThreeTitle,
      description: AppStrings.onboardingThreeDescription,
    ),
  ];

  bool get isLastPage => currentIndex.value == pages.length - 1;

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  Future<void> onPrimaryButtonTap() async {
    if (isLastPage) {
      goToLogin();
      return;
    }

    await pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  void onSkipTap() {
    goToLogin();
  }

  void goToLogin() {
    Get.offNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
