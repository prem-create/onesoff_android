import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';

import '../getx/controllers/seller_profile_controller.dart';
import 'bankDetailsSection.dart';
import 'editProfileSection.dart';
import 'kycVerificationSection.dart';
import 'personalInformationSection.dart';
import 'profileOverviewSection.dart';

class SellerProfileTab extends GetView<SellerProfileController> {
  const SellerProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          DeviceResponsive.w(context, 16),
          DeviceResponsive.h(context, 16),
          DeviceResponsive.w(context, 16),
          0,
        ),
        child: Column(
          children: <Widget>[
            const _ProfileHeader(),
            Obx(() {
              switch (controller.selectedHeaderTab.value) {
                case AppStrings.sellerProfileTabOverview:
                  return const ProfileOverviewSection();
                case AppStrings.sellerProfileTabPersonalInfo:
                  return const PersonalInformationSection();
                case AppStrings.sellerProfileTabKycVerification:
                  return const KycVerificationSection();
                case AppStrings.sellerProfileTabBankDetails:
                  return const BankDetailsSection();
                case AppStrings.sellerProfileTabEditProfile:
                  return const EditProfileSection();
                default:
                  return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: const Color(0xFFE0E2E7)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[const _ProfileSummary(), const _ProfileHeaderTabs()],
      ),
    );
  }
}

class _ProfileSummary extends StatelessWidget {
  const _ProfileSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 14),
        vertical: DeviceResponsive.h(context, 14),
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: DeviceResponsive.r(context, 22),
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person_outline_rounded,
              color: AppColors.primary,
              size: DeviceResponsive.r(context, 24),
            ),
          ),
          SizedBox(width: DeviceResponsive.w(context, 10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  AppStrings.sellerProfileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: DeviceResponsive.sp(context, 15, minScale: 0.9),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: DeviceResponsive.h(context, 3)),
                Text(
                  AppStrings.sellerProfileEmail,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: DeviceResponsive.sp(context, 11, minScale: 0.9),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: DeviceResponsive.w(context, 8)),
          const _ProfileStatusGroup(),
        ],
      ),
    );
  }
}

class _ProfileStatusGroup extends StatelessWidget {
  const _ProfileStatusGroup();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: DeviceResponsive.w(context, 4),
      runSpacing: DeviceResponsive.h(context, 4),
      alignment: WrapAlignment.end,
      children: const <Widget>[
        _ProfileStatusChip(
          label: AppStrings.sellerProfileStatusActive,
          color: Colors.green,
        ),
        _ProfileStatusChip(
          label: AppStrings.sellerProfileStatusApproved,
          color: Colors.orange,
        ),
      ],
    );
  }
}

class _ProfileStatusChip extends StatelessWidget {
  const _ProfileStatusChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 7),
        vertical: DeviceResponsive.h(context, 4),
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontSize: DeviceResponsive.sp(context, 10, minScale: 0.86),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ProfileHeaderTabs extends GetView<SellerProfileController> {
  const _ProfileHeaderTabs();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 10),
        vertical: DeviceResponsive.h(context, 10),
      ),
      child: Obx(
        () => Wrap(
          spacing: DeviceResponsive.w(context, 6),
          runSpacing: DeviceResponsive.h(context, 6),
          children: controller.headerTabs
              .map(
                (String tab) => _ProfileHeaderTabButton(
                  label: tab,
                  isSelected: controller.selectedHeaderTab.value == tab,
                  onTap: () => controller.setHeaderTab(tab),
                ),
              )
              .toList(growable: false),
        ),
      ),
    );
  }
}

class _ProfileHeaderTabButton extends StatelessWidget {
  const _ProfileHeaderTabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceResponsive.h(context, 36),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isSelected ? AppColors.primary : Colors.grey,
          padding: EdgeInsets.symmetric(
            horizontal: DeviceResponsive.w(context, 10),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
          ),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: DeviceResponsive.sp(context, 12, minScale: 0.86),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
