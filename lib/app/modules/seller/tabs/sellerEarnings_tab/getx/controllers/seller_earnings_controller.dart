import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';

class SellerEarningsController extends GetxController {
  final RxBool isEarningsSelected = true.obs;
  final RxString selectedBreakdownFilter =
      AppStrings.sellerEarningsBreakdownFilterAll.obs;

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

  final List<SellerEarningBreakdownItem> breakdownItems =
      const <SellerEarningBreakdownItem>[
        SellerEarningBreakdownItem(
          orderId: '#ORD-29',
          productName: 'Jeans',
          rentalPrice: 'Rs 19,992',
          commissionAmount: 'Rs 5,998',
          netIncome: 'Rs 13,994',
          status: AppStrings.sellerEarningsBreakdownFilterPending,
        ),
        SellerEarningBreakdownItem(
          orderId: '#ORD-27',
          productName: 'Jeans',
          rentalPrice: 'Rs 9,996',
          commissionAmount: 'Rs 2,999',
          netIncome: 'Rs 6,997',
          status: AppStrings.sellerEarningsBreakdownFilterPending,
        ),
        SellerEarningBreakdownItem(
          orderId: '#ORD-25',
          productName: 'Sherwani',
          rentalPrice: 'Rs 14,500',
          commissionAmount: 'Rs 4,350',
          netIncome: 'Rs 10,150',
          status: AppStrings.sellerEarningsBreakdownFilterPaid,
        ),
        SellerEarningBreakdownItem(
          orderId: '#ORD-21',
          productName: 'Lehenga',
          rentalPrice: 'Rs 12,000',
          commissionAmount: 'Rs 3,600',
          netIncome: 'Rs 8,400',
          status: AppStrings.sellerEarningsBreakdownFilterPaid,
        ),
      ];

  List<SellerEarningBreakdownItem> get filteredBreakdownItems {
    if (selectedBreakdownFilter.value ==
        AppStrings.sellerEarningsBreakdownFilterAll) {
      return breakdownItems;
    }

    return breakdownItems
        .where((SellerEarningBreakdownItem item) {
          return item.status == selectedBreakdownFilter.value;
        })
        .toList(growable: false);
  }

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

class SellerEarningBreakdownItem {
  const SellerEarningBreakdownItem({
    required this.orderId,
    required this.productName,
    required this.rentalPrice,
    required this.commissionAmount,
    required this.netIncome,
    required this.status,
  });

  final String orderId;
  final String productName;
  final String rentalPrice;
  final String commissionAmount;
  final String netIncome;
  final String status;
}
