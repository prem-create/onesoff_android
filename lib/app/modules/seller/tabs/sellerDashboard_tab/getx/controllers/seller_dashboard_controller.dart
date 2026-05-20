import 'package:get/get.dart';

import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';

class SellerDashboardController extends GetxController {
  final List<SellerMetricItem> metrics = const <SellerMetricItem>[
    SellerMetricItem(
      label: AppStrings.sellerMetricActiveListings,
      value: AppStrings.sellerMetricActiveListingsValue,
    ),
    SellerMetricItem(
      label: AppStrings.sellerMetricTodayOrders,
      value: AppStrings.sellerMetricTodayOrdersValue,
    ),
    SellerMetricItem(
      label: AppStrings.sellerMetricPendingReturns,
      value: AppStrings.sellerMetricPendingReturnsValue,
    ),
    SellerMetricItem(
      label: AppStrings.sellerMetricRevenue,
      value: AppStrings.sellerMetricRevenueValue,
    ),
  ];

  final List<String> tasks = const <String>[
    AppStrings.sellerTaskReviewRequests,
    AppStrings.sellerTaskUpdateStock,
    AppStrings.sellerTaskPreparePickupPackages,
  ];
}

class SellerMetricItem {
  const SellerMetricItem({required this.label, required this.value});

  final String label;
  final String value;
}
