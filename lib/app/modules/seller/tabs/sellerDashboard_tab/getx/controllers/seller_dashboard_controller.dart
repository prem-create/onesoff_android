import 'package:get/get.dart';

import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';

class SellerDashboardController extends GetxController {
  final List<SellerMetricItem> metrics = const <SellerMetricItem>[
    SellerMetricItem(
      label: AppStrings.sellerMetricTotalOutfitListed,
      value: AppStrings.sellerMetricTotalOutfitListedValue,
    ),
    SellerMetricItem(
      label: AppStrings.sellerMetricActiveRentals,
      value: AppStrings.sellerMetricActiveRentalsValue,
    ),
    SellerMetricItem(
      label: AppStrings.sellerMetricTotalIncome,
      value: AppStrings.sellerMetricTotalIncomeValue,
    ),
  ];

  final List<SellerIncomeTrendItem> incomeTrendItems =
      const <SellerIncomeTrendItem>[
        SellerIncomeTrendItem(month: 'Jan', income: 420),
        SellerIncomeTrendItem(month: 'Feb', income: 480),
        SellerIncomeTrendItem(month: 'Mar', income: 570),
        SellerIncomeTrendItem(month: 'Apr', income: 590),
        SellerIncomeTrendItem(month: 'May', income: 525),
        SellerIncomeTrendItem(month: 'Jun', income: 280),
      ];
}

class SellerMetricItem {
  const SellerMetricItem({required this.label, required this.value});

  final String label;
  final String value;
}

class SellerIncomeTrendItem {
  const SellerIncomeTrendItem({required this.month, required this.income});

  final String month;
  final double income;
}
