import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/inventory/getx/controllers/vendor1_inventory_controller.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/inventory/view/vendor1_inventory_agreements_section.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/inventory/view/vendor1_inventory_operations_section.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/inventory/view/vendor1_inventory_product_list_section.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/inventory/view/vendor1_inventory_rental_availability_section.dart';

class Vendor1InventoryTab extends GetView<Vendor1InventoryController> {
  const Vendor1InventoryTab({super.key});

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
            const _InventorySectionToggle(),
            SizedBox(height: DeviceResponsive.h(context, 16)),
            Obx(
              () => _selectedSection(controller.selectedInventorySection.value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectedSection(String section) {
    switch (section) {
      case AppStrings.vendor1InventorySectionOperations:
        return const Vendor1InventoryOperationsSection();
      case AppStrings.vendor1InventorySectionRentalAvailability:
        return const Vendor1InventoryRentalAvailabilitySection();
      case AppStrings.vendor1InventorySectionAgreements:
        return const Vendor1InventoryAgreementsSection();
      case AppStrings.vendor1InventorySectionProductList:
      default:
        return const Vendor1InventoryProductListSection();
    }
  }
}

class _InventorySectionToggle extends GetView<Vendor1InventoryController> {
  const _InventorySectionToggle();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: DeviceResponsive.w(context, 8),
        runSpacing: DeviceResponsive.h(context, 8),
        children: controller.inventorySections
            .map(
              (String section) => _InventorySectionButton(
                label: section,
                isSelected:
                    controller.selectedInventorySection.value == section,
                onTap: () => controller.setInventorySection(section),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _InventorySectionButton extends StatelessWidget {
  const _InventorySectionButton({
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
