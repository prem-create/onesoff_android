import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/earnings/getx/controllers/vendor1_earnings_controller.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/earnings/view/sections/vendor1_earnings_section.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/earnings/view/sections/vendor1_raise_claims_section.dart';

class Vendor1EarningsTab extends GetView<Vendor1EarningsController> {
  const Vendor1EarningsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          DeviceResponsive.w(context, 16),
          DeviceResponsive.h(context, 16),
          DeviceResponsive.w(context, 16),
          0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _EarningsSectionToggle(),
            SizedBox(height: DeviceResponsive.h(context, 16)),
            Obx(
              () => _selectedSection(controller.selectedEarningsSection.value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectedSection(String section) {
    switch (section) {
      case AppStrings.vendor1EarningsSectionRaiseClaims:
        return const Vendor1RaiseClaimsSection();
      case AppStrings.vendor1EarningsSectionEarnings:
      default:
        return const Vendor1EarningsSection();
    }
  }
}

class _EarningsSectionToggle extends GetView<Vendor1EarningsController> {
  const _EarningsSectionToggle();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: DeviceResponsive.w(context, 8),
        runSpacing: DeviceResponsive.h(context, 8),
        children: controller.earningsSections
            .map(
              (String section) => _EarningsSectionButton(
                label: section,
                isSelected: controller.selectedEarningsSection.value == section,
                onTap: () => controller.setEarningsSection(section),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _EarningsSectionButton extends StatelessWidget {
  const _EarningsSectionButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: DeviceResponsive.w(context, 12),
          vertical: DeviceResponsive.h(context, 8),
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFD5D8DF),
          ),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontSize: DeviceResponsive.sp(context, 12, minScale: 0.86),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
