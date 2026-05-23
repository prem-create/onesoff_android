import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/earnings/getx/controllers/vendor1_earnings_controller.dart';

class Vendor1EarningsSection extends GetView<Vendor1EarningsController> {
  const Vendor1EarningsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                AppStrings.vendor1EarningsTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: DeviceResponsive.sp(context, 20, minScale: 0.9),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: DeviceResponsive.w(context, 10)),
            const _EarningsRangeDropdown(),
          ],
        ),
        SizedBox(height: DeviceResponsive.h(context, 4)),
        Text(
          AppStrings.vendor1EarningsSubtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: DeviceResponsive.sp(context, 12, minScale: 0.9),
          ),
        ),
        Obx(
          () =>
              controller.selectedEarningsRange.value ==
                  AppStrings.vendor1EarningsRangeCustomDate
              ? Column(
                  children: <Widget>[
                    SizedBox(height: DeviceResponsive.h(context, 12)),
                    const _EarningsDateRangePickerRow(),
                  ],
                )
              : const SizedBox.shrink(),
        ),
        SizedBox(height: DeviceResponsive.h(context, 16)),
        _EarningsMetricGrid(items: controller.earningsMetrics),
        SizedBox(height: DeviceResponsive.h(context, 16)),
        const _EarningsFilterCard(),
        SizedBox(height: DeviceResponsive.h(context, 14)),
        const _EarningsEmptyStateCard(),
      ],
    );
  }
}

class _EarningsMetricGrid extends StatelessWidget {
  const _EarningsMetricGrid({required this.items});

  final List<Vendor1EarningsMetricItem> items;

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
                (Vendor1EarningsMetricItem item) => SizedBox(
                  width: itemWidth,
                  child: _EarningsMetricTile(item: item),
                ),
              )
              .toList(growable: false),
        );
      },
    );
  }
}

class _EarningsRangeDropdown extends GetView<Vendor1EarningsController> {
  const _EarningsRangeDropdown();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: DeviceResponsive.w(context, 132),
        height: DeviceResponsive.h(context, 38),
        child: DropdownButtonFormField<String>(
          initialValue: controller.selectedEarningsRange.value,
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
              vertical: DeviceResponsive.h(context, 9),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                DeviceResponsive.r(context, 8),
              ),
              borderSide: const BorderSide(color: Color(0xFFD5D8DF)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                DeviceResponsive.r(context, 8),
              ),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: DeviceResponsive.sp(context, 10.5, minScale: 0.84),
            fontWeight: FontWeight.w600,
          ),
          dropdownColor: Colors.white,
          items: controller.earningsRangeOptions
              .map(
                (String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(growable: false),
          onChanged: controller.setEarningsRange,
        ),
      ),
    );
  }
}

class _EarningsMetricTile extends StatelessWidget {
  const _EarningsMetricTile({required this.item});

  final Vendor1EarningsMetricItem item;

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

class _EarningsFilterCard extends StatelessWidget {
  const _EarningsFilterCard();

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
      child: Row(
        children: <Widget>[
          const Expanded(child: _EarningsSearchBar()),
          SizedBox(width: DeviceResponsive.w(context, 10)),
          const Expanded(child: _EarningsSingleDatePicker()),
        ],
      ),
    );
  }
}

class _EarningsSearchBar extends StatelessWidget {
  const _EarningsSearchBar();

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
              AppStrings.vendor1EarningsSearchHint,
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

class _EarningsDateRangePickerRow extends GetView<Vendor1EarningsController> {
  const _EarningsDateRangePickerRow();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: <Widget>[
          Expanded(
            child: _EarningsDatePickerField(
              label: AppStrings.vendor1StartDateLabel,
              value: controller.formatDate(controller.earningsStartDate.value),
              onTap: () async {
                final DateTime? selected = await showDatePicker(
                  context: context,
                  initialDate: controller.earningsStartDate.value,
                  firstDate: DateTime(2020),
                  lastDate: controller.earningsEndDate.value,
                );

                if (selected != null) {
                  controller.setEarningsStartDate(selected);
                }
              },
            ),
          ),
          SizedBox(width: DeviceResponsive.w(context, 10)),
          Expanded(
            child: _EarningsDatePickerField(
              label: AppStrings.vendor1EndDateLabel,
              value: controller.formatDate(controller.earningsEndDate.value),
              onTap: () async {
                final DateTime? selected = await showDatePicker(
                  context: context,
                  initialDate: controller.earningsEndDate.value,
                  firstDate: controller.earningsStartDate.value,
                  lastDate: DateTime.now(),
                );

                if (selected != null) {
                  controller.setEarningsEndDate(selected);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EarningsSingleDatePicker extends GetView<Vendor1EarningsController> {
  const _EarningsSingleDatePicker();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _EarningsDatePickerField(
        label: AppStrings.vendor1StartDateLabel,
        value: controller.formatDate(controller.earningsStartDate.value),
        onTap: () async {
          final DateTime? selected = await showDatePicker(
            context: context,
            initialDate: controller.earningsStartDate.value,
            firstDate: DateTime(2020),
            lastDate: DateTime.now(),
          );

          if (selected != null) {
            controller.setEarningsStartDate(selected);
          }
        },
      ),
    );
  }
}

class _EarningsDatePickerField extends StatelessWidget {
  const _EarningsDatePickerField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: DeviceResponsive.w(context, 10),
          vertical: DeviceResponsive.h(context, 9),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
          border: Border.all(color: const Color(0xFFD5D8DF)),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.calendar_month_outlined,
              color: AppColors.primary,
              size: DeviceResponsive.r(context, 18),
            ),
            SizedBox(width: DeviceResponsive.w(context, 7)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: DeviceResponsive.sp(
                        context,
                        10,
                        minScale: 0.88,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: DeviceResponsive.h(context, 2)),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: DeviceResponsive.sp(
                        context,
                        11.5,
                        minScale: 0.88,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EarningsEmptyStateCard extends StatelessWidget {
  const _EarningsEmptyStateCard();

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
            AppStrings.vendor1EarningsEmptyTransactions,
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
