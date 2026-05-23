import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appImages.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';

class Vendor1InventoryController extends GetxController {
  final RxString selectedInventorySection =
      AppStrings.vendor1InventorySectionProductList.obs;
  final RxString selectedCategory = AppStrings.vendor1InventoryCategoryAll.obs;
  final RxString selectedStatus = AppStrings.vendor1InventoryStatusAll.obs;
  final RxString selectedDateFilter = AppStrings.vendor1InventoryDateToday.obs;
  final RxString selectedOperationCategory =
      AppStrings.vendor1InventoryOperationQualityCheck.obs;

  final List<String> inventorySections = const <String>[
    AppStrings.vendor1InventorySectionProductList,
    AppStrings.vendor1InventorySectionOperations,
    AppStrings.vendor1InventorySectionRentalAvailability,
    AppStrings.vendor1InventorySectionAgreements,
  ];

  final List<String> categoryOptions = const <String>[
    AppStrings.vendor1InventoryCategoryAll,
    AppStrings.vendor1InventoryCategoryMen,
    AppStrings.vendor1InventoryCategorySherwani,
    AppStrings.vendor1InventoryCategorySuit,
    AppStrings.vendor1InventoryCategoryBlazer,
    AppStrings.vendor1InventoryCategoryTuxedo,
    AppStrings.vendor1InventoryCategoryOthers,
    AppStrings.vendor1InventoryCategoryWomen,
    AppStrings.vendor1InventoryCategorySaree,
    AppStrings.vendor1InventoryCategoryLehenga,
    AppStrings.vendor1InventoryCategoryGown,
    AppStrings.vendor1InventoryCategoryBridalWear,
    AppStrings.vendor1InventoryCategoryAccessoriesJewellery,
    AppStrings.vendor1InventoryCategoryJewellery,
    AppStrings.vendor1InventoryCategoryAccessories,
  ];

  final List<String> statusOptions = const <String>[
    AppStrings.vendor1InventoryStatusAll,
    AppStrings.vendor1InventoryStatusActive,
    AppStrings.vendor1InventoryStatusInactive,
    AppStrings.vendor1InventoryStatusOutOfStock,
  ];

  final List<String> dateFilterOptions = const <String>[
    AppStrings.vendor1InventoryDateToday,
    AppStrings.vendor1InventoryDateYesterday,
    AppStrings.vendor1InventoryDateLast7Days,
    AppStrings.vendor1InventoryDateLast30Days,
    AppStrings.vendor1InventoryDateLast90Days,
    AppStrings.vendor1InventoryDateCustomRange,
  ];

  final List<String> operationCategories = const <String>[
    AppStrings.vendor1InventoryOperationQualityCheck,
    AppStrings.vendor1InventoryOperationDamageRepair,
    AppStrings.vendor1InventoryOperationMaintainance,
    AppStrings.vendor1InventoryOperationLogistics,
  ];

  final List<Vendor1InventoryMetricItem> metrics =
      const <Vendor1InventoryMetricItem>[
        Vendor1InventoryMetricItem(
          label: AppStrings.vendor1InventoryMetricTotalProducts,
          value: AppStrings.vendor1InventoryMetricOne,
        ),
        Vendor1InventoryMetricItem(
          label: AppStrings.vendor1InventoryMetricActiveListings,
          value: AppStrings.vendor1InventoryMetricOne,
        ),
        Vendor1InventoryMetricItem(
          label: AppStrings.vendor1InventoryMetricPendingProducts,
          value: AppStrings.vendor1MetricZeroCount,
        ),
        Vendor1InventoryMetricItem(
          label: AppStrings.vendor1InventoryMetricInactive,
          value: AppStrings.vendor1MetricZeroCount,
        ),
      ];

  final List<Vendor1InventoryProductItem> products =
      const <Vendor1InventoryProductItem>[
        Vendor1InventoryProductItem(
          image: AppImages.womensWear,
          name: AppStrings.vendor1InventoryProductName,
          sku: AppStrings.vendor1InventoryProductSku,
          rentPrice: AppStrings.vendor1InventoryProductRentPrice,
          category: AppStrings.vendor1InventoryProductCategory,
          gender: AppStrings.vendor1InventoryProductGender,
          stock: AppStrings.vendor1InventoryProductStock,
          status: AppStrings.vendor1InventoryProductStatus,
        ),
      ];

  final List<Vendor1InventoryMetricItem> operationMetrics =
      const <Vendor1InventoryMetricItem>[
        Vendor1InventoryMetricItem(
          label: AppStrings.vendor1InventoryOperationPendingQualityCheck,
          value: AppStrings.vendor1MetricZeroCount,
        ),
        Vendor1InventoryMetricItem(
          label: AppStrings.vendor1InventoryOperationDamageRepairQueue,
          value: AppStrings.vendor1MetricZeroCount,
        ),
        Vendor1InventoryMetricItem(
          label: AppStrings.vendor1InventoryOperationMaintenanceQueue,
          value: AppStrings.vendor1MetricZeroCount,
        ),
      ];

  final Map<String, Vendor1InventoryEmptyState>
  operationEmptyStates = const <String, Vendor1InventoryEmptyState>{
    AppStrings.vendor1InventoryOperationQualityCheck:
        Vendor1InventoryEmptyState(
          title: AppStrings.vendor1InventoryOperationNoQcTitle,
          subtitle: AppStrings.vendor1InventoryOperationNoQcSubtitle,
        ),
    AppStrings.vendor1InventoryOperationDamageRepair:
        Vendor1InventoryEmptyState(
          title: AppStrings.vendor1InventoryOperationNoDamageTitle,
          subtitle: AppStrings.vendor1InventoryOperationNoDamageSubtitle,
        ),
    AppStrings.vendor1InventoryOperationMaintainance:
        Vendor1InventoryEmptyState(
          title: AppStrings.vendor1InventoryOperationNoMaintenanceTitle,
          subtitle: AppStrings.vendor1InventoryOperationNoMaintenanceSubtitle,
        ),
    AppStrings.vendor1InventoryOperationLogistics: Vendor1InventoryEmptyState(
      title: AppStrings.vendor1InventoryOperationLogisticsSoonTitle,
      subtitle: AppStrings.vendor1InventoryOperationLogisticsSoonSubtitle,
    ),
  };

  final List<Vendor1InventoryMetricItem> agreementMetrics =
      const <Vendor1InventoryMetricItem>[
        Vendor1InventoryMetricItem(
          label: AppStrings.vendor1InventoryAgreementRevenueShare,
          value: AppStrings.vendor1InventoryAgreementRevenueShareValue,
        ),
        Vendor1InventoryMetricItem(
          label: AppStrings.vendor1InventoryAgreementContractVersion,
          value: AppStrings.vendor1InventoryAgreementContractVersionValue,
        ),
        Vendor1InventoryMetricItem(
          label: AppStrings.vendor1InventoryAgreementSignedOn,
          value: AppStrings.vendor1InventoryAgreementDateValue,
        ),
        Vendor1InventoryMetricItem(
          label: AppStrings.vendor1InventoryAgreementEffectiveFrom,
          value: AppStrings.vendor1InventoryAgreementDateValue,
        ),
      ];

  final List<String> agreementTerms = const <String>[
    AppStrings.vendor1InventoryAgreementTermPlatformTerms,
    AppStrings.vendor1InventoryAgreementTermCommissionAgreement,
    AppStrings.vendor1InventoryAgreementTermCancellationPolicy,
    AppStrings.vendor1InventoryAgreementTermDepositRules,
    AppStrings.vendor1InventoryAgreementTermOrderHandling,
    AppStrings.vendor1InventoryAgreementTermQualityStandards,
    AppStrings.vendor1InventoryAgreementTermReturnHandling,
  ];

  void setInventorySection(String section) {
    selectedInventorySection.value = section;
  }

  void setOperationCategory(String category) {
    selectedOperationCategory.value = category;
  }

  Vendor1InventoryEmptyState get selectedOperationEmptyState {
    return operationEmptyStates[selectedOperationCategory.value] ??
        operationEmptyStates[AppStrings.vendor1InventoryOperationQualityCheck]!;
  }

  void setCategory(String? value) {
    if (value == null) {
      return;
    }

    selectedCategory.value = value;
  }

  void setStatus(String? value) {
    if (value == null) {
      return;
    }

    selectedStatus.value = value;
  }

  void setDateFilter(String? value) {
    if (value == null) {
      return;
    }

    selectedDateFilter.value = value;
  }
}

class Vendor1InventoryMetricItem {
  const Vendor1InventoryMetricItem({required this.label, required this.value});

  final String label;
  final String value;
}

class Vendor1InventoryProductItem {
  const Vendor1InventoryProductItem({
    required this.image,
    required this.name,
    required this.sku,
    required this.rentPrice,
    required this.category,
    required this.gender,
    required this.stock,
    required this.status,
  });

  final String image;
  final String name;
  final String sku;
  final String rentPrice;
  final String category;
  final String gender;
  final String stock;
  final String status;
}

class Vendor1InventoryEmptyState {
  const Vendor1InventoryEmptyState({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;
}
