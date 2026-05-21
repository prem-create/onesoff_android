import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';

class SellerEarningsController extends GetxController {
  final RxBool isEarningsSelected = true.obs;
  final RxString selectedBreakdownFilter = 'All'.obs;

  final List<SellerEarningMetricItem> metrics = const <SellerEarningMetricItem>[
    SellerEarningMetricItem(
      label: AppStrings.sellerEarningsMonthlyEarnings,
      value: AppStrings.sellerEarningsMonthlyEarningsValue,
    ),
    SellerEarningMetricItem(
      label: AppStrings.sellerEarningsNetIncome,
      value: AppStrings.sellerEarningsNetIncomeValue,
    ),
    SellerEarningMetricItem(
      label: AppStrings.sellerEarningsReceivedSaving,
      value: AppStrings.sellerEarningsReceivedSavingValue,
    ),
  ];

  void setEarningsSelected(bool value) {
    isEarningsSelected.value = value;
  }

  void setBreakdownFilter(String value) {
    selectedBreakdownFilter.value = value;
  }
}

class SellerEarningMetricItem {
  const SellerEarningMetricItem({required this.label, required this.value});

  final String label;
  final String value;
}
