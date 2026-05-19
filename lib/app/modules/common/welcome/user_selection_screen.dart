import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/controllers/app_session_controller.dart';
import '../../../routes/appRoutes.dart';
import '../../../core/utils/deviceConstants/appColors.dart';
import '../../../core/utils/deviceConstants/appImages.dart';
import '../../../core/utils/deviceConstants/appStrings.dart';
import '../../../core/utils/deviceUtility/deviceResponsive.dart';

class UserSelectionScreen extends StatelessWidget {
  const UserSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = DeviceResponsive.screenSize(context);
    final AppSessionController session = Get.find<AppSessionController>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.52,
            child: Image.asset(
              AppImages.userSelection,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: size.height * 0.24,
            height: size.height * 0.30,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      const Color(0xFFFFFFFF).withValues(alpha: 0.0),
                      const Color(0xFFF2F2F2).withValues(alpha: 1.0),
                    ],
                    stops: const <double>[0.61, 0.86],
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: DeviceResponsive.w(context, 22),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: DeviceResponsive.h(context, 28),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: constraints.maxHeight * 0.46),
                          Text(
                            AppStrings.chooseYourExperience,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: DeviceResponsive.sp(context, 22, minScale: 0.92, maxScale: 1.2),
                              fontWeight: FontWeight.w700,
                              height: 1.1,
                            ),
                          ),
                          SizedBox(height: DeviceResponsive.h(context, 12)),
                          Text(
                            AppStrings.userSelectionDescription,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: DeviceResponsive.sp(context, 15, minScale: 0.92, maxScale: 1.16),
                              fontWeight: FontWeight.w400,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: DeviceResponsive.h(context, 46)),
                          SizedBox(
                            width: double.infinity,
                            height: DeviceResponsive.h(context, 58),
                            child: ElevatedButton(
                              onPressed: () {
                                session.setRole('customer');
                                Get.offAllNamed(AppRoutes.customerDashboard);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.textOnDark,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    DeviceResponsive.r(context, 9),
                                  ),
                                ),
                              ),
                              child: Text(
                                AppStrings.continueAsCustomer,
                                style: TextStyle(
                                  fontSize: DeviceResponsive.sp(context, 17, minScale: 0.92, maxScale: 1.16),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: DeviceResponsive.h(context, 12)),
                          SizedBox(
                            width: double.infinity,
                            height: DeviceResponsive.h(context, 58),
                            child: OutlinedButton(
                              onPressed: () => Get.toNamed(AppRoutes.vendorOnboarding),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side: const BorderSide(
                                  color: AppColors.border,
                                  width: 1.3,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    DeviceResponsive.r(context, 9),
                                  ),
                                ),
                              ),
                              child: Text(
                                AppStrings.registerAsVendor,
                                style: TextStyle(
                                  fontSize: DeviceResponsive.sp(context, 17, minScale: 0.92, maxScale: 1.16),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
