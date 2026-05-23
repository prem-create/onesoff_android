import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';

class Vendor1DashboardController extends GetxController {
  final RxString selectedAnalyticsRange =
      AppStrings.vendor1AnalyticsRange7d.obs;
  final Rx<DateTime> customStartDate = DateTime.now()
      .subtract(const Duration(days: 6))
      .obs;
  final Rx<DateTime> customEndDate = DateTime.now().obs;

  final List<String> analyticsRanges = const <String>[
    AppStrings.vendor1AnalyticsRange7d,
    AppStrings.vendor1AnalyticsRange30d,
    AppStrings.vendor1AnalyticsRange90d,
    AppStrings.vendor1AnalyticsRangeCustom,
  ];

  final List<Vendor1DashboardMetricItem> metrics =
      const <Vendor1DashboardMetricItem>[
        Vendor1DashboardMetricItem(
          label: AppStrings.vendor1MetricTotalRentals,
          value: AppStrings.vendor1MetricZeroCount,
        ),
        Vendor1DashboardMetricItem(
          label: AppStrings.vendor1MetricActiveRentalsOutNow,
          value: AppStrings.vendor1MetricZeroCount,
        ),
        Vendor1DashboardMetricItem(
          label: AppStrings.vendor1MetricTotalRevenue,
          value: AppStrings.vendor1MetricZeroRevenue,
        ),
        Vendor1DashboardMetricItem(
          label: AppStrings.vendor1MetricPendingDepositRefund,
          value: AppStrings.vendor1MetricZeroCount,
        ),
        Vendor1DashboardMetricItem(
          label: AppStrings.vendor1MetricReturnsDueToday,
          value: AppStrings.vendor1MetricZeroCount,
        ),
        Vendor1DashboardMetricItem(
          label: AppStrings.vendor1MetricReturnsOverdue,
          value: AppStrings.vendor1MetricZeroCount,
        ),
        Vendor1DashboardMetricItem(
          label: AppStrings.vendor1MetricTrialConversion,
          value: AppStrings.vendor1MetricZeroPercent,
        ),
      ];

  int get totalOrders => 0;

  double get growthPercentage => 0;

  List<Vendor1TrendPoint> get trendPoints {
    final DateTime endDate = _activeEndDate;
    final DateTime startDate = _activeStartDate;
    final int days = endDate.difference(startDate).inDays + 1;
    final int pointCount = days <= 7 ? days.clamp(1, 7) : 7;
    final int step = days <= pointCount ? 1 : (days / (pointCount - 1)).floor();

    return List<Vendor1TrendPoint>.generate(pointCount, (int index) {
      final bool isLast = index == pointCount - 1;
      final DateTime date = isLast
          ? endDate
          : startDate.add(Duration(days: step * index));

      return Vendor1TrendPoint(
        dateLabel: _formatShortDate(date),
        orders: 0,
        revenue: 0,
      );
    });
  }

  void setAnalyticsRange(String value) {
    selectedAnalyticsRange.value = value;
  }

  void setCustomStartDate(DateTime value) {
    customStartDate.value = value;

    if (customEndDate.value.isBefore(value)) {
      customEndDate.value = value;
    }
  }

  void setCustomEndDate(DateTime value) {
    customEndDate.value = value;

    if (customStartDate.value.isAfter(value)) {
      customStartDate.value = value;
    }
  }

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} ${_monthName(date.month)} ${date.year}';
  }

  DateTime get _activeStartDate {
    if (selectedAnalyticsRange.value ==
        AppStrings.vendor1AnalyticsRangeCustom) {
      return customStartDate.value;
    }

    return _activeEndDate.subtract(Duration(days: _selectedDays - 1));
  }

  DateTime get _activeEndDate {
    if (selectedAnalyticsRange.value ==
        AppStrings.vendor1AnalyticsRangeCustom) {
      return customEndDate.value;
    }

    return DateTime.now();
  }

  int get _selectedDays {
    switch (selectedAnalyticsRange.value) {
      case AppStrings.vendor1AnalyticsRange30d:
        return 30;
      case AppStrings.vendor1AnalyticsRange90d:
        return 90;
      default:
        return 7;
    }
  }

  String _formatShortDate(DateTime date) {
    return '${date.day} ${_shortMonthName(date.month)}';
  }

  String _monthName(int month) {
    const List<String> months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return months[month - 1];
  }

  String _shortMonthName(int month) {
    return _monthName(month);
  }
}

class Vendor1DashboardMetricItem {
  const Vendor1DashboardMetricItem({required this.label, required this.value});

  final String label;
  final String value;
}

class Vendor1TrendPoint {
  const Vendor1TrendPoint({
    required this.dateLabel,
    required this.orders,
    required this.revenue,
  });

  final String dateLabel;
  final double orders;
  final double revenue;
}
