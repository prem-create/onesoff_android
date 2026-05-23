import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/orders/getx/controllers/vendor1_orders_controller.dart';

class Vendor1OrdersSection extends GetView<Vendor1OrdersController> {
  const Vendor1OrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppStrings.vendor1OrdersTitle,
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
          AppStrings.vendor1OrdersSubtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: DeviceResponsive.sp(context, 12, minScale: 0.9),
          ),
        ),
        SizedBox(height: DeviceResponsive.h(context, 16)),
        _OrderMetricGrid(items: controller.metrics),
        SizedBox(height: DeviceResponsive.h(context, 16)),
        const _OrdersFilterCard(),
        SizedBox(height: DeviceResponsive.h(context, 14)),
        const _OrdersEmptyStateCard(),
      ],
    );
  }
}

class _OrderMetricGrid extends StatelessWidget {
  const _OrderMetricGrid({required this.items});

  final List<Vendor1OrderMetricItem> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int crossAxisCount = constraints.maxWidth >= 620 ? 5 : 2;
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
                  child: _OrderMetricTile(item: item),
                ),
              )
              .toList(growable: false),
        );
      },
    );
  }
}

class _OrderMetricTile extends StatelessWidget {
  const _OrderMetricTile({required this.item});

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

class _OrdersFilterCard extends GetView<Vendor1OrdersController> {
  const _OrdersFilterCard();

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
      child: Obx(
        () => Row(
          children: <Widget>[
            const Expanded(child: _OrdersSearchBar()),
            SizedBox(width: DeviceResponsive.w(context, 8)),
            SizedBox(
              width: DeviceResponsive.w(context, 138),
              child: _OrdersStatusDropdown(
                value: controller.selectedOrderStatus.value,
                items: controller.orderStatusOptions,
                onChanged: controller.setOrderStatus,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrdersSearchBar extends StatelessWidget {
  const _OrdersSearchBar();

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
              AppStrings.vendor1OrdersSearchHint,
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

class _OrdersStatusDropdown extends StatelessWidget {
  const _OrdersStatusDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceResponsive.h(context, 44),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.textSecondary,
          size: DeviceResponsive.r(context, 18),
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: DeviceResponsive.w(context, 8),
            vertical: DeviceResponsive.h(context, 11),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
            borderSide: const BorderSide(color: Color(0xFFD5D8DF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: DeviceResponsive.sp(context, 10.5, minScale: 0.84),
          fontWeight: FontWeight.w600,
        ),
        dropdownColor: Colors.white,
        items: items
            .map(
              (String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            )
            .toList(growable: false),
        onChanged: onChanged,
      ),
    );
  }
}

class _OrdersEmptyStateCard extends StatelessWidget {
  const _OrdersEmptyStateCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 18),
        vertical: DeviceResponsive.h(context, 28),
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
              Icons.receipt_long_outlined,
              color: AppColors.primary,
              size: DeviceResponsive.r(context, 22),
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          Text(
            AppStrings.vendor1OrdersNoOrdersFound,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: DeviceResponsive.sp(context, 15, minScale: 0.9),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
