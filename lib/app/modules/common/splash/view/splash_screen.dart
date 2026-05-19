import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/deviceConstants/appColors.dart';
import '../../../../core/utils/deviceConstants/appImages.dart';
import '../../../../core/utils/deviceConstants/appStrings.dart';
import '../../../../core/utils/deviceUtility/deviceResponsive.dart';
import '../getx/controllers/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            AppImages.splash,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xff000000).withValues(alpha: 0.0),
                  Color(0xff1A050A).withValues(alpha: 0.90),
                  Color(0xff0F0104).withValues(alpha: 1.0),
                ],
                stops: <double>[0.0, 0.64, 0.80],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: DeviceResponsive.w(context, 24),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: DeviceResponsive.h(context, 64),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        AppImages.appLogo,
                        width: DeviceResponsive.w(context, 120),
                        height: DeviceResponsive.w(context, 120),
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: DeviceResponsive.h(context, 22)),
                      Text(
                        AppStrings.splashTagline,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textOnDark,
                          fontSize: DeviceResponsive.sp(context, 16),
                          height: 1.28,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
