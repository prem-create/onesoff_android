import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/deviceConstants/appColors.dart';
import '../../../../../core/utils/deviceConstants/appStrings.dart';
import '../../../../../core/utils/deviceUtility/deviceResponsive.dart';
import '../getx/controllers/seller_dashboard_controller.dart';

class SellerDashboardTab extends GetView<SellerDashboardController> {
  const SellerDashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        DeviceResponsive.w(context, 16),
        DeviceResponsive.h(context, 16),
        DeviceResponsive.w(context, 16),
        DeviceResponsive.h(context, 20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: List<Widget>.generate(controller.metrics.length, (
              int index,
            ) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index == controller.metrics.length - 1
                        ? 0
                        : DeviceResponsive.w(context, 8),
                  ),
                  child: _MetricTile(item: controller.metrics[index]),
                ),
              );
            }),
          ),
          SizedBox(height: DeviceResponsive.h(context, 18)),
          _IncomeTrendsChart(items: controller.incomeTrendItems),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.item});

  final SellerMetricItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceResponsive.h(context, 85),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: DeviceResponsive.w(context, 8),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    item.label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: DeviceResponsive.sp(
                        context,
                        10.5,
                        minScale: 0.86,
                      ),
                      height: 1.15,
                    ),
                  ),
                ),
                SizedBox(width: DeviceResponsive.w(context, 2)),
                SizedBox(
                  width: DeviceResponsive.r(context, 22),
                  height: DeviceResponsive.r(context, 22),
                  child: IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      Icons.calendar_month,
                      color: AppColors.textSecondary,
                      size: DeviceResponsive.r(context, 15),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: DeviceResponsive.h(context, 5)),
            Text(
              item.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: DeviceResponsive.sp(context, 17, minScale: 0.86),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IncomeTrendsChart extends StatelessWidget {
  const _IncomeTrendsChart({required this.items});

  final List<SellerIncomeTrendItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 12),
        vertical: DeviceResponsive.h(context, 12),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: const Color(0xFFE0E2E7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppStrings.sellerIncomeTrendsTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: DeviceResponsive.sp(context, 16, minScale: 0.9),
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const IncomeTrendHeaderLine(),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          SizedBox(
            height: DeviceResponsive.fluid(context, min: 188, max: 238),
            child: SellerIncomeBarChart(items: items),
          ),
          SizedBox(height: DeviceResponsive.h(context, 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: DeviceResponsive.r(context, 12),
                width: DeviceResponsive.r(context, 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFDFA3),
                  borderRadius: BorderRadius.circular(
                    DeviceResponsive.r(context, 2),
                  ),
                ),
              ),
              SizedBox(width: DeviceResponsive.w(context, 8)),
              Flexible(
                child: Text(
                  AppStrings.sellerIncomeTrendsLegend,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: DeviceResponsive.sp(context, 11, minScale: 0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class IncomeTrendHeaderLine extends StatelessWidget {
  const IncomeTrendHeaderLine({super.key});

  @override
  Widget build(BuildContext context) {
    final double lineHeight = DeviceResponsive.h(
      context,
      16,
    ).clamp(12, 18).toDouble();

    return SizedBox(
      height: lineHeight,
      width: double.infinity,
      child: CustomPaint(
        painter: _IncomeTrendLinePainter(
          accentStrokeWidth: DeviceResponsive.r(
            context,
            4,
          ).clamp(3, 5).toDouble(),
          baseStrokeWidth: DeviceResponsive.r(
            context,
            1.5,
          ).clamp(1.2, 2).toDouble(),
        ),
      ),
    );
  }
}

class _IncomeTrendLinePainter extends CustomPainter {
  const _IncomeTrendLinePainter({
    required this.accentStrokeWidth,
    required this.baseStrokeWidth,
  });

  final double accentStrokeWidth;
  final double baseStrokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final double lineY = size.height * 0.72;
    final double slantHeight = size.height * 0.82;
    final double accentLineEnd = (size.width * 0.17).clamp(40, 56).toDouble();
    final double slantWidth = (size.width * 0.05).clamp(12, 18).toDouble();
    final double bendStart = (size.width * 0.48)
        .clamp(accentLineEnd + 48, size.width - slantWidth)
        .toDouble();
    final double upperLineY = lineY - slantHeight;

    final bluePaint = Paint()
      ..color = Colors.cyan
      ..strokeWidth = accentStrokeWidth
      ..strokeCap = StrokeCap.square;

    final greyPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = baseStrokeWidth
      ..strokeCap = StrokeCap.square;

    canvas.drawLine(Offset(0, lineY), Offset(accentLineEnd, lineY), bluePaint);

    canvas.drawLine(
      Offset(accentLineEnd, lineY),
      Offset(bendStart, lineY),
      greyPaint,
    );

    canvas.drawLine(
      Offset(bendStart, lineY),
      Offset(bendStart + slantWidth, upperLineY),
      greyPaint,
    );

    canvas.drawLine(
      Offset(bendStart + slantWidth, upperLineY),
      Offset(size.width, upperLineY),
      greyPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _IncomeTrendLinePainter oldDelegate) {
    return oldDelegate.accentStrokeWidth != accentStrokeWidth ||
        oldDelegate.baseStrokeWidth != baseStrokeWidth;
  }
}

class SellerIncomeBarChart extends StatelessWidget {
  const SellerIncomeBarChart({super.key, required this.items});

  final List<SellerIncomeTrendItem> items;

  @override
  Widget build(BuildContext context) {
    final double barWidth = DeviceResponsive.fluid(context, min: 14, max: 24);
    final double leftReservedSize = DeviceResponsive.fluid(
      context,
      min: 28,
      max: 36,
    );
    final double labelFontSize = DeviceResponsive.sp(
      context,
      9,
      minScale: 0.88,
      maxScale: 1.08,
    );
    final double gridStrokeWidth = DeviceResponsive.r(
      context,
      1,
    ).clamp(0.7, 1).toDouble();

    return BarChart(
      BarChartData(
        maxY: 750,
        minY: 0,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 150,
          getDrawingHorizontalLine: (_) => FlLine(
            color: const Color(0xFFBDBDBD),
            strokeWidth: gridStrokeWidth,
            dashArray: const <int>[4, 4],
          ),
          getDrawingVerticalLine: (_) => FlLine(
            color: const Color(0xFFBDBDBD),
            strokeWidth: gridStrokeWidth,
            dashArray: const <int>[4, 4],
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(bottom: BorderSide()),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 150,
              reservedSize: leftReservedSize,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  meta: meta,
                  space: DeviceResponsive.w(context, 4),
                  child: Text(
                    value.toInt().toString(),
                    maxLines: 1,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: labelFontSize,
                    ),
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= items.length) {
                  return const SizedBox.shrink();
                }
                return SideTitleWidget(
                  meta: meta,
                  space: DeviceResponsive.h(context, 6),
                  child: Text(
                    items[index].month,
                    maxLines: 1,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: labelFontSize,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: List<BarChartGroupData>.generate(items.length, (index) {
          return BarChartGroupData(
            x: index,
            barRods: <BarChartRodData>[
              BarChartRodData(
                toY: items[index].income,
                width: barWidth,
                borderRadius: BorderRadius.zero,
                color: const Color(0xFFFFDFA3),
              ),
            ],
          );
        }),
      ),
    );
  }
}
