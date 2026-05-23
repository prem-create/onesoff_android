import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/orders/getx/controllers/vendor1_orders_controller.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/orders/view/sections/vendor1_orders_section.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/orders/view/sections/vendor1_trial_requests_section.dart';

class Vendor1OrdersTab extends GetView<Vendor1OrdersController> {
  const Vendor1OrdersTab({super.key});

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
            const _OrdersSectionToggle(),
            SizedBox(height: DeviceResponsive.h(context, 16)),
            Obx(() => _selectedSection(controller.selectedOrdersSection.value)),
          ],
        ),
      ),
    );
  }

  Widget _selectedSection(String section) {
    switch (section) {
      case AppStrings.vendor1OrdersSectionTrailAvailability:
        return const Vendor1TrialRequestsSection();
      case AppStrings.vendor1OrdersSectionOrders:
      default:
        return const Vendor1OrdersSection();
    }
  }
}

class _OrdersSectionToggle extends GetView<Vendor1OrdersController> {
  const _OrdersSectionToggle();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: DeviceResponsive.w(context, 8),
        runSpacing: DeviceResponsive.h(context, 8),
        children: controller.orderSections
            .map(
              (String section) => _OrdersSectionButton(
                label: section,
                isSelected: controller.selectedOrdersSection.value == section,
                onTap: () => controller.setOrdersSection(section),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _OrdersSectionButton extends StatelessWidget {
  const _OrdersSectionButton({
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
