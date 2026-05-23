import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';

class Vendor1EarningsController extends GetxController {
  final RxString selectedEarningsSection =
      AppStrings.vendor1EarningsSectionEarnings.obs;
  final RxString selectedEarningsRange =
      AppStrings.vendor1EarningsRangeAllTime.obs;
  final Rx<DateTime> earningsStartDate = DateTime.now()
      .subtract(const Duration(days: 6))
      .obs;
  final Rx<DateTime> earningsEndDate = DateTime.now().obs;

  final List<String> earningsSections = const <String>[
    AppStrings.vendor1EarningsSectionEarnings,
    AppStrings.vendor1EarningsSectionRaiseClaims,
  ];

  final List<String> earningsRangeOptions = const <String>[
    AppStrings.vendor1EarningsRangeAllTime,
    AppStrings.vendor1EarningsRangeThisWeek,
    AppStrings.vendor1EarningsRangeThisMonth,
    AppStrings.vendor1EarningsRangeThisYear,
    AppStrings.vendor1EarningsRangeCustomDate,
  ];

  final List<Vendor1EarningsMetricItem> earningsMetrics =
      const <Vendor1EarningsMetricItem>[
        Vendor1EarningsMetricItem(
          label: AppStrings.vendor1EarningsGrossRentalRevenue,
          value: AppStrings.vendor1EarningsZeroCurrency,
        ),
        Vendor1EarningsMetricItem(
          label: AppStrings.vendor1EarningsCommissionDeducted,
          value: AppStrings.vendor1EarningsZeroCurrency,
        ),
        Vendor1EarningsMetricItem(
          label: AppStrings.vendor1EarningsNetIncome,
          value: AppStrings.vendor1EarningsZeroCurrency,
        ),
        Vendor1EarningsMetricItem(
          label: AppStrings.vendor1EarningsPendingPayout,
          value: AppStrings.vendor1EarningsZeroCurrency,
        ),
        Vendor1EarningsMetricItem(
          label: AppStrings.vendor1EarningsDepositLiability,
          value: AppStrings.vendor1EarningsZeroCurrency,
        ),
      ];

  void setEarningsSection(String section) {
    selectedEarningsSection.value = section;
  }

  void setEarningsRange(String? range) {
    if (range == null) {
      return;
    }

    selectedEarningsRange.value = range;
  }

  void setEarningsStartDate(DateTime date) {
    earningsStartDate.value = date;
  }

  void setEarningsEndDate(DateTime date) {
    earningsEndDate.value = date;
  }

  String formatDate(DateTime date) {
    const List<String> monthNames = <String>[
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

    return '${date.day} ${monthNames[date.month - 1]} ${date.year}';
  }
}

class Vendor1EarningsMetricItem {
  const Vendor1EarningsMetricItem({required this.label, required this.value});

  final String label;
  final String value;
}
