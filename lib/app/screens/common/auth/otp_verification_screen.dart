import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/deviceConstants/appColors.dart';
import '../../../utils/deviceConstants/appImages.dart';
import '../../../utils/deviceConstants/appStrings.dart';
import '../../../utils/deviceUtility/deviceResponsive.dart';
import 'getx/otp_controller.dart';

class OtpVerificationScreen extends GetView<OtpController> {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = DeviceResponsive.screenSize(context);
    final double headerHeight = size.height * 0.33;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F5),
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: headerHeight,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(DeviceResponsive.r(context, 34)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        DeviceResponsive.w(context, 20),
                        DeviceResponsive.h(context, 26),
                        DeviceResponsive.w(context, 20),
                        DeviceResponsive.h(context, 20),
                      ),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            AppImages.appLogo,
                            width: DeviceResponsive.r(context, 62),
                            height: DeviceResponsive.r(context, 62),
                            color: Colors.white,
                          ),
                          SizedBox(height: DeviceResponsive.h(context, 14)),
                          Text(
                            AppStrings.loginWelcomeTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textOnDark,
                              fontSize: DeviceResponsive.sp(
                                context,
                                20,
                                minScale: 0.92,
                                maxScale: 1.16,
                              ),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: DeviceResponsive.h(context, 8)),
                          Text(
                            AppStrings.loginWelcomeSubtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.82),
                              fontSize: DeviceResponsive.sp(
                                context,
                                14,
                                minScale: 0.92,
                                maxScale: 1.12,
                              ),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: DeviceResponsive.h(context, 26)),
                          _OtpCard(controller: controller),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _OtpCard extends StatelessWidget {
  const _OtpCard({required this.controller});

  final OtpController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        DeviceResponsive.w(context, 14),
        DeviceResponsive.h(context, 18),
        DeviceResponsive.w(context, 14),
        DeviceResponsive.h(context, 18),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBFC),
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppStrings.verifyOtpTitle,
            style: TextStyle(
              color: AppColors.onSurface,
              fontSize: DeviceResponsive.sp(
                context,
                16,
                minScale: 0.92,
                maxScale: 1.16,
              ),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 6)),
          Text(
            '${AppStrings.otpDescription} +91 ${controller.mobileNumber}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: DeviceResponsive.sp(
                context,
                14,
                minScale: 0.92,
                maxScale: 1.12,
              ),
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 18)),
          Text(
            AppStrings.enterOtpCode,
            style: TextStyle(
              color: AppColors.onSurface,
              fontSize: DeviceResponsive.sp(
                context,
                14,
                minScale: 0.92,
                maxScale: 1.14,
              ),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List<Widget>.generate(
              controller.otpControllers.length,
              (int index) => Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index == controller.otpControllers.length - 1 ? 0 : DeviceResponsive.w(context, 1.5),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: TextField(
                      controller: controller.otpControllers[index],
                      focusNode: controller.otpFocusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      style: TextStyle(
                        fontSize: DeviceResponsive.sp(
                          context,
                          14,
                          minScale: 0.92,
                          maxScale: 1.14,
                        ),
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            DeviceResponsive.r(context, 12),
                          ),
                        ),
                      ),
                      onChanged: (String value) =>
                          controller.onOtpChanged(index, value),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 14)),
          SizedBox(
            width: double.infinity,
            height: DeviceResponsive.h(context, 54),
            child: ElevatedButton(
              onPressed: controller.onVerifyOtp,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
                ),
              ),
              child: Text(
                AppStrings.verifyOtpButton,
                style: TextStyle(
                  fontSize: DeviceResponsive.sp(
                    context,
                    14,
                    minScale: 0.92,
                    maxScale: 1.14,
                  ),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 10)),
          SizedBox(
            width: double.infinity,
            height: DeviceResponsive.h(context, 54),
            child: OutlinedButton.icon(
              onPressed: controller.onChangeMobileNumber,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                backgroundColor: const Color(0xFFF5EFF1),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
                ),
              ),
              icon: const Icon(Icons.arrow_back),
              label: Text(
                AppStrings.changeMobileNumber,
                style: TextStyle(
                  fontSize: DeviceResponsive.sp(
                    context,
                    14,
                    minScale: 0.92,
                    maxScale: 1.14,
                  ),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 16)),
          Center(
            child: Text.rich(
              TextSpan(
                text: AppStrings.termsPrefix,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: DeviceResponsive.sp(
                    context,
                    13,
                    minScale: 0.92,
                    maxScale: 1.1,
                  ),
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: AppStrings.termsLinkText,
                    style: TextStyle(
                      color: const Color(0xFF404E83),
                      decoration: TextDecoration.underline,
                      fontSize: DeviceResponsive.sp(
                        context,
                        13,
                        minScale: 0.92,
                        maxScale: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
