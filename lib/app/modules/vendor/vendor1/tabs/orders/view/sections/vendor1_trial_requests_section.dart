import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/orders/getx/controllers/vendor1_orders_controller.dart';

class Vendor1TrialRequestsSection extends GetView<Vendor1OrdersController> {
  const Vendor1TrialRequestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppStrings.vendor1TrialRequestsTitle,
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
          AppStrings.vendor1TrialRequestsSubtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: DeviceResponsive.sp(context, 12, minScale: 0.9),
          ),
        ),
        SizedBox(height: DeviceResponsive.h(context, 16)),
        _TrialRequestMetricGrid(items: controller.trialRequestMetrics),
        SizedBox(height: DeviceResponsive.h(context, 16)),
        const _TrialRequestFilterCard(),
        SizedBox(height: DeviceResponsive.h(context, 14)),
        const _TrialRequestEmptyStateCard(),
      ],
    );
  }
}

class _TrialRequestMetricGrid extends StatelessWidget {
  const _TrialRequestMetricGrid({required this.items});

  final List<Vendor1OrderMetricItem> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int crossAxisCount = constraints.maxWidth >= 620 ? 6 : 2;
        final double spacing = DeviceResponsive.w(context, 8);
        final double itemWidth =
            (constraints.maxWidth - (spacing * (crossAxisCount - 1))) /
            crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: DeviceResponsive.h(context, 8),
          children: items
              .map(
                (Vendor1OrderMetricItem item) => SizedBox(
                  width: itemWidth,
                  child: _TrialRequestMetricTile(item: item),
                ),
              )
              .toList(growable: false),
        );
      },
    );
  }
}

class _TrialRequestMetricTile extends StatelessWidget {
  const _TrialRequestMetricTile({required this.item});

  final Vendor1OrderMetricItem item;

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

class _TrialRequestFilterCard extends GetView<Vendor1OrdersController> {
  const _TrialRequestFilterCard();

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
          _TrialRequestSearchBar(),
              SizedBox(height: DeviceResponsive.w(context, 10)),
              Obx(
                () => _TrialRequestStatusToggle(
                  selectedStatus: controller.selectedTrialRequestStatus.value,
                  statuses: controller.trialRequestStatusOptions,
                  onTap: controller.setTrialRequestStatus,
                ),
              ),
        ],
      ),
    );
  }
}

class _TrialRequestSearchBar extends StatelessWidget {
  const _TrialRequestSearchBar();

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
              AppStrings.vendor1TrialRequestsSearchHint,
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

class _TrialRequestStatusToggle extends StatelessWidget {
  const _TrialRequestStatusToggle({
    required this.selectedStatus,
    required this.statuses,
    required this.onTap,
  });

  final String selectedStatus;
  final List<String> statuses;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: DeviceResponsive.w(context, 6),
      runSpacing: DeviceResponsive.h(context, 6),
      children: statuses
          .map(
            (String status) => _TrialRequestStatusButton(
              label: status,
              isSelected: selectedStatus == status,
              onTap: () => onTap(status),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _TrialRequestStatusButton extends StatelessWidget {
  const _TrialRequestStatusButton({
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
          horizontal: DeviceResponsive.w(context, 10),
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
            fontSize: DeviceResponsive.sp(context, 11, minScale: 0.84),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _TrialRequestEmptyStateCard extends StatelessWidget {
  const _TrialRequestEmptyStateCard();

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
              Icons.assignment_outlined,
              color: AppColors.primary,
              size: DeviceResponsive.r(context, 22),
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          Text(
            AppStrings.vendor1TrialRequestsEmptyTitle,
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
            AppStrings.vendor1TrialRequestsEmptySubtitle,
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
