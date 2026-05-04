import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/deviceConstants/appColors.dart';
import '../../../utils/deviceConstants/appStrings.dart';
import '../../../utils/deviceUtility/deviceResponsive.dart';
import 'getx/onboarding_controller.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double safeBottom = MediaQuery.viewPaddingOf(context).bottom;
    final double controlsBottomPadding = DeviceResponsive.h(context, 22) + safeBottom;
    final double controlsReservedHeight = DeviceResponsive.h(context, 110) + safeBottom;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: controller.pageController,
              itemCount: controller.pages.length,
              onPageChanged: controller.onPageChanged,
              itemBuilder: (BuildContext context, int index) {
                return _OnboardingPage(
                  page: controller.pages[index],
                  controlsReservedHeight: controlsReservedHeight,
                );
              },
            ),
            Positioned(
              left: DeviceResponsive.w(context, 26),
              right: DeviceResponsive.w(context, 26),
              bottom: controlsBottomPadding,
              child: _OnboardingFooter(
                controller: controller,
                pageCount: controller.pages.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.page,
    required this.controlsReservedHeight,
  });

  final OnboardingItem page;
  final double controlsReservedHeight;

  @override
  Widget build(BuildContext context) {
    final Size size = DeviceResponsive.screenSize(context);
    final double panelTop = size.height * 0.36;
    final double slopeDepth = DeviceResponsive.h(context, 96);
    final double imageHeight = panelTop + slopeDepth + DeviceResponsive.h(context, 10);

    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: imageHeight,
          child: Image.asset(
            page.imagePath,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        Positioned.fill(
          top: panelTop,
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: ClipPath(
              clipper: _DiagonalPanelClipper(slopeDepth: slopeDepth),
              child: Container(
                color: AppColors.surface,
                padding: EdgeInsets.fromLTRB(
                  DeviceResponsive.w(context, 30),
                  slopeDepth + DeviceResponsive.h(context, 24),
                  DeviceResponsive.w(context, 30),
                  controlsReservedHeight,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        page.title,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: DeviceResponsive.sp(context, 20, minScale: 0.92, maxScale: 1.26),
                          fontWeight: FontWeight.w700,
                          height: 1.08,
                        ),
                      ),
                      SizedBox(height: DeviceResponsive.h(context, 16)),
                      Text(
                        page.description,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: DeviceResponsive.sp(context, 15, minScale: 0.92, maxScale: 1.22),
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: DeviceResponsive.h(context, 10)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OnboardingFooter extends StatelessWidget {
  const _OnboardingFooter({
    required this.controller,
    required this.pageCount,
  });

  final OnboardingController controller;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: controller.onSkipTap,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(
                    DeviceResponsive.w(context, 56),
                    DeviceResponsive.h(context, 36),
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  AppStrings.skip,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: DeviceResponsive.sp(context, 18, minScale: 0.92, maxScale: 1.20),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(
                  pageCount,
                  (int dotIndex) {
                    final bool isActive = dotIndex == controller.currentIndex.value;
                    final double dotSize = isActive ? 14 : 12;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: DeviceResponsive.r(context, dotSize),
                      height: DeviceResponsive.r(context, dotSize),
                      margin: EdgeInsets.symmetric(horizontal: DeviceResponsive.w(context, 3)),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive ? AppColors.primary : AppColors.inactiveDot,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: _DiamondActionButton(
                label: controller.isLastPage ? AppStrings.start : AppStrings.next,
                onTap: controller.onPrimaryButtonTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DiamondActionButton extends StatelessWidget {
  const _DiamondActionButton({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final double side = DeviceResponsive.r(context, 74);
    return GestureDetector(
      onTap: onTap,
      child: Transform.rotate(
        angle: math.pi / 4,
        child: Container(
          width: side,
          height: side,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 14)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Transform.rotate(
            angle: -math.pi / 4,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.textOnDark,
                  fontSize: DeviceResponsive.sp(context, 18, minScale: 0.92, maxScale: 1.20),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DiagonalPanelClipper extends CustomClipper<Path> {
  const _DiagonalPanelClipper({required this.slopeDepth});

  final double slopeDepth;

  @override
  Path getClip(Size size) {
    final double effectiveDepth = slopeDepth.clamp(24.0, size.height * 0.45).toDouble();
    return Path()
      ..lineTo(size.width, effectiveDepth)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
