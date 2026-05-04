import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/deviceConstants/appColors.dart';
import '../../../utils/deviceConstants/appImages.dart';
import '../../../utils/deviceConstants/appStrings.dart';
import '../../../utils/deviceUtility/deviceResponsive.dart';
import 'getx/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

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
                          _LoginCard(controller: controller),
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

class _LoginCard extends StatelessWidget {
  const _LoginCard({required this.controller});

  final LoginController controller;

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppStrings.loginTitle,
                      style: TextStyle(
                        color: AppColors.onSurface,
                        fontSize: DeviceResponsive.sp(context, 16, minScale: 0.92, maxScale: 1.16,),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: DeviceResponsive.h(context, 6)),
                    Text(
                      AppStrings.loginDescription,
                      style: TextStyle(color: AppColors.textSecondary, fontSize: DeviceResponsive.sp(context, 14, minScale: 0.92, maxScale: 1.12,),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: DeviceResponsive.w(context, 10)),
              InkWell(
                onTap: controller.onGuestLoginAsCustomer,
                borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 20)),
                child: Container(
                  width: DeviceResponsive.r(context, 34),
                  height: DeviceResponsive.r(context, 34),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: AppColors.textOnDark,
                    size: DeviceResponsive.r(context, 20),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: DeviceResponsive.h(context, 14)),
          Text(
            AppStrings.mobileNumberLabel,
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
          TextField(
            controller: controller.mobileController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            maxLength: 10,
            style: TextStyle(
              fontSize: DeviceResponsive.sp(
                context,
                16,
                minScale: 0.92,
                maxScale: 1.14,
              ),
            ),
            decoration: InputDecoration(
              counterText: '',
              hintText: AppStrings.mobileNumberHint,
              hintStyle: TextStyle(
                color: AppColors.textSecondary,
                fontSize: DeviceResponsive.sp(
                  context,
                  16,
                  minScale: 0.92,
                  maxScale: 1.14,
                ),
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: DeviceResponsive.w(context, 12), right: DeviceResponsive.w(context, 6)),
                child: Center(
                  widthFactor: 1.0,
                  child: Text(
                    '+91',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: DeviceResponsive.sp(
                        context,
                        16,
                        minScale: 0.92,
                        maxScale: 1.14,
                      ),
                    ),
                  ),
                ),
              ),
              prefixIconConstraints: BoxConstraints(minWidth: DeviceResponsive.w(context, 56)),
              contentPadding: EdgeInsets.symmetric(
                horizontal: DeviceResponsive.w(context, 12),
                vertical: DeviceResponsive.h(context, 14),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
                borderSide: const BorderSide(color: Color(0xFF6E7785)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
                borderSide: const BorderSide(color: Color(0xFF6E7785)),
              ),
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 14)),
          SizedBox(
            width: double.infinity,
            height: DeviceResponsive.h(context, 54),
            child: ElevatedButton(
              onPressed: controller.onRequestOtp,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
                ),
              ),
              child: Text(
                AppStrings.requestOtp,
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
