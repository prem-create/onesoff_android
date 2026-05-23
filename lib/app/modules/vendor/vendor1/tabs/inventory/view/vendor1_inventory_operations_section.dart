import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/inventory/getx/controllers/vendor1_inventory_controller.dart';

class Vendor1InventoryOperationsSection
    extends GetView<Vendor1InventoryController> {
  const Vendor1InventoryOperationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppStrings.vendor1InventoryOperationsTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: DeviceResponsive.sp(context, 20, minScale: 0.9),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: DeviceResponsive.h(context, 4)),
        Text(
          AppStrings.vendor1InventoryOperationsSubtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: DeviceResponsive.sp(context, 12, minScale: 0.9),
          ),
        ),
        SizedBox(height: DeviceResponsive.h(context, 16)),
        _OperationMetricGrid(items: controller.operationMetrics),
        SizedBox(height: DeviceResponsive.h(context, 16)),
        const _OperationFilterCard(),
        SizedBox(height: DeviceResponsive.h(context, 14)),
        Obx(
          () => _OperationEmptyStateCard(
            item: controller.selectedOperationEmptyState,
          ),
        ),
      ],
    );
  }
}

class _OperationMetricGrid extends StatelessWidget {
  const _OperationMetricGrid({required this.items});

  final List<Vendor1InventoryMetricItem> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double spacing = DeviceResponsive.w(context, 8);
        const int crossAxisCount = 3;
        final double itemWidth =
            (constraints.maxWidth - (spacing * (crossAxisCount - 1))) /
            crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: DeviceResponsive.h(context, 8),
          children: items
              .map(
                (Vendor1InventoryMetricItem item) => SizedBox(
                  width: itemWidth,
                  child: _OperationMetricTile(item: item),
                ),
              )
              .toList(growable: false),
        );
      },
    );
  }
}

class _OperationMetricTile extends StatelessWidget {
  const _OperationMetricTile({required this.item});

  final Vendor1InventoryMetricItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceResponsive.h(context, 86),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: DeviceResponsive.w(context, 9),
          vertical: DeviceResponsive.h(context, 10),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
          border: Border.all(color: const Color(0xFFE0E2E7)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              item.label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: DeviceResponsive.sp(context, 10.5, minScale: 0.86),
                height: 1.15,
              ),
            ),
            SizedBox(height: DeviceResponsive.h(context, 7)),
            Text(
              item.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: DeviceResponsive.sp(context, 18, minScale: 0.86),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OperationFilterCard extends GetView<Vendor1InventoryController> {
  const _OperationFilterCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 14),
        vertical: DeviceResponsive.h(context, 14),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: const Color(0xFFE0E2E7)),
      ),
      child: Column(
        children: <Widget>[
          const _OperationSearchBar(),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          Obx(
            () => Wrap(
              spacing: DeviceResponsive.w(context, 8),
              runSpacing: DeviceResponsive.h(context, 8),
              children: controller.operationCategories
                  .map(
                    (String category) => _OperationCategoryButton(
                      label: category,
                      isSelected:
                          controller.selectedOperationCategory.value ==
                          category,
                      onTap: () => controller.setOperationCategory(category),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }
}

class _OperationSearchBar extends StatelessWidget {
  const _OperationSearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceResponsive.fluid(context, min: 44, max: 48),
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 12),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
        border: Border.all(color: const Color(0xFFD5D8DF)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              AppStrings.vendor1InventorySearchHint,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF6E747D),
                fontSize: DeviceResponsive.sp(
                  context,
                  13,
                  minScale: 0.86,
                  maxScale: 1,
                ),
              ),
            ),
          ),
          Icon(
            Icons.search_rounded,
            color: const Color(0xFF2C2F34),
            size: DeviceResponsive.r(context, 24),
          ),
        ],
      ),
    );
  }
}

class _OperationCategoryButton extends StatelessWidget {
  const _OperationCategoryButton({
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

class _OperationEmptyStateCard extends StatelessWidget {
  const _OperationEmptyStateCard({required this.item});

  final Vendor1InventoryEmptyState item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 18),
        vertical: DeviceResponsive.h(context, 26),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: const Color(0xFFE0E2E7)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: DeviceResponsive.r(context, 42),
            height: DeviceResponsive.r(context, 42),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(18),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.primary,
              size: DeviceResponsive.r(context, 22),
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          Text(
            item.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: DeviceResponsive.sp(context, 15, minScale: 0.9),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 6)),
          Text(
            item.subtitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: DeviceResponsive.sp(context, 12, minScale: 0.86),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
