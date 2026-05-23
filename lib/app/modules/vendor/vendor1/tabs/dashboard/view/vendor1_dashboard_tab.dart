import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/dashboard/getx/controllers/vendor1_dashboard_controller.dart';

class Vendor1DashboardTab extends GetView<Vendor1DashboardController> {
  const Vendor1DashboardTab({super.key});

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
            Text(
              AppStrings.vendor1DashboardTitle,
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
              AppStrings.vendor1DashboardSubtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: DeviceResponsive.sp(context, 12, minScale: 0.9),
              ),
            ),
            SizedBox(height: DeviceResponsive.h(context, 16)),
            _DashboardMetricGrid(items: controller.metrics),
            SizedBox(height: DeviceResponsive.h(context, 20)),
            const _AnalyticsOverviewSection(),
            SizedBox(height: DeviceResponsive.h(context, 20)),
            const _RecentOrdersSection(),
          ],
        ),
      ),
    );
  }
}

class _DashboardMetricGrid extends StatelessWidget {
  const _DashboardMetricGrid({required this.items});

  final List<Vendor1DashboardMetricItem> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int crossAxisCount = constraints.maxWidth >= 620 ? 3 : 2;
        final double spacing = DeviceResponsive.w(context, 8);
        final double itemWidth =
            (constraints.maxWidth - (spacing * (crossAxisCount - 1))) /
            crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: DeviceResponsive.h(context, 8),
          children: items
              .map(
                (Vendor1DashboardMetricItem item) => SizedBox(
                  width: itemWidth,
                  child: _DashboardMetricTile(item: item),
                ),
              )
              .toList(growable: false),
        );
      },
    );
  }
}

class _DashboardMetricTile extends StatelessWidget {
  const _DashboardMetricTile({required this.item});

  final Vendor1DashboardMetricItem item;

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

class _AnalyticsOverviewSection extends GetView<Vendor1DashboardController> {
  const _AnalyticsOverviewSection();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppStrings.vendor1AnalyticsOverviewTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: DeviceResponsive.sp(context, 18, minScale: 0.9),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          _AnalyticsRangeSelector(
            ranges: controller.analyticsRanges,
            selectedRange: controller.selectedAnalyticsRange.value,
            onSelected: controller.setAnalyticsRange,
          ),
          if (controller.selectedAnalyticsRange.value ==
              AppStrings.vendor1AnalyticsRangeCustom) ...<Widget>[
            SizedBox(height: DeviceResponsive.h(context, 12)),
            const _CustomDateRangePickerRow(),
          ],
          SizedBox(height: DeviceResponsive.h(context, 12)),
          const _RevenueByCategoryCard(),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          _OrderRevenueTrendCard(),
        ],
      ),
    );
  }
}

class _AnalyticsRangeSelector extends StatelessWidget {
  const _AnalyticsRangeSelector({
    required this.ranges,
    required this.selectedRange,
    required this.onSelected,
  });

  final List<String> ranges;
  final String selectedRange;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Widget>.generate(ranges.length, (int index) {
        final String range = ranges[index];
        final bool isSelected = selectedRange == range;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: index == ranges.length - 1
                  ? 0
                  : DeviceResponsive.w(context, 6),
            ),
            child: _AnalyticsRangeButton(
              label: range,
              isSelected: isSelected,
              onTap: () => onSelected(range),
            ),
          ),
        );
      }),
    );
  }
}

class _AnalyticsRangeButton extends StatelessWidget {
  const _AnalyticsRangeButton({
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
      height: DeviceResponsive.h(context, 38),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isSelected ? AppColors.primary : Colors.grey,
          padding: EdgeInsets.symmetric(
            horizontal: DeviceResponsive.w(context, 6),
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

class _CustomDateRangePickerRow extends GetView<Vendor1DashboardController> {
  const _CustomDateRangePickerRow();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: <Widget>[
          Expanded(
            child: _DatePickerField(
              label: AppStrings.vendor1StartDateLabel,
              value: controller.formatDate(controller.customStartDate.value),
              onTap: () async {
                final DateTime? selected = await showDatePicker(
                  context: context,
                  initialDate: controller.customStartDate.value,
                  firstDate: DateTime(2020),
                  lastDate: controller.customEndDate.value,
                );

                if (selected != null) {
                  controller.setCustomStartDate(selected);
                }
              },
            ),
          ),
          SizedBox(width: DeviceResponsive.w(context, 10)),
          Expanded(
            child: _DatePickerField(
              label: AppStrings.vendor1EndDateLabel,
              value: controller.formatDate(controller.customEndDate.value),
              onTap: () async {
                final DateTime? selected = await showDatePicker(
                  context: context,
                  initialDate: controller.customEndDate.value,
                  firstDate: controller.customStartDate.value,
                  lastDate: DateTime.now(),
                );

                if (selected != null) {
                  controller.setCustomEndDate(selected);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DatePickerField extends StatelessWidget {
  const _DatePickerField({
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

class _RevenueByCategoryCard extends StatelessWidget {
  const _RevenueByCategoryCard();

  @override
  Widget build(BuildContext context) {
    return _AnalyticsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _AnalyticsCardTitle(
            title: AppStrings.vendor1RevenueByCategoryTitle,
          ),
          SizedBox(height: DeviceResponsive.h(context, 14)),
          Center(
            child: Text(
              AppStrings.vendor1RevenueByCategoryEmpty,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: DeviceResponsive.sp(context, 12, minScale: 0.9),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderRevenueTrendCard extends GetView<Vendor1DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isNegativeGrowth = controller.growthPercentage < 0;
      final Color growthColor = isNegativeGrowth ? Colors.red : Colors.green;

      return _AnalyticsCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _AnalyticsCardTitle(
              title: AppStrings.vendor1OrdersRevenueTrendTitle,
            ),
            SizedBox(height: DeviceResponsive.h(context, 8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    '${AppStrings.vendor1TotalOrdersLabel} (${controller.totalOrders})',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: DeviceResponsive.sp(context, 11, minScale: 0.9),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: DeviceResponsive.w(context, 8)),
                Flexible(
                  child: Text(
                    '${AppStrings.vendor1GrowthLabel}: ${controller.growthPercentage.toStringAsFixed(0)}%',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: growthColor,
                      fontSize: DeviceResponsive.sp(context, 11, minScale: 0.9),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: DeviceResponsive.h(context, 10)),
            const _TrendLegend(),
            SizedBox(height: DeviceResponsive.h(context, 10)),
            SizedBox(
              height: DeviceResponsive.h(context, 170),
              width: double.infinity,
              child: CustomPaint(
                painter: _OrderRevenueTrendPainter(
                  points: controller.trendPoints,
                  ordersColor: AppColors.primary,
                  revenueColor: Colors.blue,
                  axisColor: const Color(0xFFD5D8DF),
                  labelColor: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _TrendLegend extends StatelessWidget {
  const _TrendLegend();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _LegendItem(
          color: AppColors.primary,
          label: AppStrings.vendor1OrdersLegend,
        ),
        SizedBox(width: DeviceResponsive.w(context, 12)),
        const _LegendItem(
          color: Colors.blue,
          label: AppStrings.vendor1RevenueLegend,
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: DeviceResponsive.r(context, 8),
          height: DeviceResponsive.r(context, 8),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: DeviceResponsive.w(context, 5)),
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: DeviceResponsive.sp(context, 10, minScale: 0.9),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _AnalyticsCardTitle extends StatelessWidget {
  const _AnalyticsCardTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: DeviceResponsive.sp(context, 15, minScale: 0.9),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _AnalyticsCard extends StatelessWidget {
  const _AnalyticsCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 14),
        vertical: DeviceResponsive.h(context, 16),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: const Color(0xFFE0E2E7)),
      ),
      child: child,
    );
  }
}

class _OrderRevenueTrendPainter extends CustomPainter {
  const _OrderRevenueTrendPainter({
    required this.points,
    required this.ordersColor,
    required this.revenueColor,
    required this.axisColor,
    required this.labelColor,
  });

  final List<Vendor1TrendPoint> points;
  final Color ordersColor;
  final Color revenueColor;
  final Color axisColor;
  final Color labelColor;

  @override
  void paint(Canvas canvas, Size size) {
    const double leftPadding = 8;
    const double rightPadding = 8;
    const double topPadding = 10;
    const double bottomPadding = 34;
    final double chartWidth = size.width - leftPadding - rightPadding;
    final double chartHeight = size.height - topPadding - bottomPadding;
    final double baselineY = topPadding + chartHeight;

    final Paint axisPaint = Paint()
      ..color = axisColor
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(leftPadding, baselineY),
      Offset(size.width - rightPadding, baselineY),
      axisPaint,
    );

    if (points.isEmpty) {
      return;
    }

    final List<Offset> orderOffsets = _buildOffsets(
      points.map((Vendor1TrendPoint point) => point.orders).toList(),
      leftPadding,
      topPadding,
      chartWidth,
      chartHeight,
    );
    final List<Offset> revenueOffsets = _buildOffsets(
      points.map((Vendor1TrendPoint point) => point.revenue).toList(),
      leftPadding,
      topPadding,
      chartWidth,
      chartHeight,
    );

    _drawLine(canvas, orderOffsets, ordersColor);
    _drawLine(canvas, revenueOffsets, revenueColor);
    _drawDateLabels(canvas, size, leftPadding, chartWidth, baselineY);
  }

  List<Offset> _buildOffsets(
    List<double> values,
    double leftPadding,
    double topPadding,
    double chartWidth,
    double chartHeight,
  ) {
    final double maxValue = values.fold<double>(
      1,
      (double previous, double value) => value > previous ? value : previous,
    );
    final int lastIndex = values.length - 1;

    return List<Offset>.generate(values.length, (int index) {
      final double x = lastIndex == 0
          ? leftPadding + (chartWidth / 2)
          : leftPadding + (chartWidth * index / lastIndex);
      final double y =
          topPadding + chartHeight - ((values[index] / maxValue) * chartHeight);

      return Offset(x, y);
    });
  }

  void _drawLine(Canvas canvas, List<Offset> offsets, Color color) {
    if (offsets.isEmpty) {
      return;
    }

    final Paint linePaint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final Paint dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final Path path = Path()..moveTo(offsets.first.dx, offsets.first.dy);

    for (final Offset offset in offsets.skip(1)) {
      path.lineTo(offset.dx, offset.dy);
    }

    canvas.drawPath(path, linePaint);

    for (final Offset offset in offsets) {
      canvas.drawCircle(offset, 3, dotPaint);
    }
  }

  void _drawDateLabels(
    Canvas canvas,
    Size size,
    double leftPadding,
    double chartWidth,
    double baselineY,
  ) {
    final int lastIndex = points.length - 1;

    for (int index = 0; index < points.length; index++) {
      final double x = lastIndex == 0
          ? leftPadding + (chartWidth / 2)
          : leftPadding + (chartWidth * index / lastIndex);
      final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: points[index].dateLabel,
          style: TextStyle(
            color: labelColor,
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
      )..layout(maxWidth: 46);
      final double textX = (x - textPainter.width / 2).clamp(
        0,
        size.width - textPainter.width,
      );

      textPainter.paint(canvas, Offset(textX, baselineY + 8));
    }
  }

  @override
  bool shouldRepaint(covariant _OrderRevenueTrendPainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.ordersColor != ordersColor ||
        oldDelegate.revenueColor != revenueColor ||
        oldDelegate.axisColor != axisColor ||
        oldDelegate.labelColor != labelColor;
  }
}

class _RecentOrdersSection extends StatelessWidget {
  const _RecentOrdersSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                AppStrings.vendor1RecentOrdersTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: DeviceResponsive.sp(context, 18, minScale: 0.9),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: DeviceResponsive.w(context, 10)),
            SizedBox(
              height: DeviceResponsive.h(context, 34),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFFFFD84D),
                  foregroundColor: AppColors.textPrimary,
                  padding: EdgeInsets.symmetric(
                    horizontal: DeviceResponsive.w(context, 14),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      DeviceResponsive.r(context, 8),
                    ),
                  ),
                ),
                child: Text(
                  AppStrings.vendor1ViewButton,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: DeviceResponsive.sp(context, 12, minScale: 0.88),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: DeviceResponsive.h(context, 12)),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: DeviceResponsive.w(context, 14),
            vertical: DeviceResponsive.h(context, 24),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              DeviceResponsive.r(context, 10),
            ),
            border: Border.all(color: const Color(0xFFE0E2E7)),
          ),
          alignment: Alignment.center,
          child: Text(
            AppStrings.vendor1NoOrderFound,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: DeviceResponsive.sp(context, 13, minScale: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
