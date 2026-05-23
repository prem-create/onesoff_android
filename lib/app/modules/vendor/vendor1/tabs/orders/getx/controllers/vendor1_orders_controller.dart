import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';

class Vendor1OrdersController extends GetxController {
  final RxString selectedOrdersSection =
      AppStrings.vendor1OrdersSectionOrders.obs;
  final RxString selectedOrderStatus = AppStrings.vendor1OrdersStatusAll.obs;
  final RxString selectedTrialRequestStatus =
      AppStrings.vendor1TrialRequestsFilterAll.obs;

  final List<String> orderSections = const <String>[
    AppStrings.vendor1OrdersSectionOrders,
    AppStrings.vendor1OrdersSectionTrailAvailability,
  ];

  final List<String> orderStatusOptions = const <String>[
    AppStrings.vendor1OrdersStatusAll,
    AppStrings.vendor1OrdersStatusBooked,
    AppStrings.vendor1OrdersStatusReadyForPickup,
    AppStrings.vendor1OrdersStatusPickedUp,
    AppStrings.vendor1OrdersStatusReturnScheduled,
    AppStrings.vendor1OrdersStatusReturned,
  ];

  final List<Vendor1OrderMetricItem> metrics = const <Vendor1OrderMetricItem>[
    Vendor1OrderMetricItem(
      label: AppStrings.vendor1OrdersStatusBooked,
      value: AppStrings.vendor1MetricZeroCount,
    ),
    Vendor1OrderMetricItem(
      label: AppStrings.vendor1OrdersStatusReadyForPickup,
      value: AppStrings.vendor1MetricZeroCount,
    ),
    Vendor1OrderMetricItem(
      label: AppStrings.vendor1OrdersStatusPickedUp,
      value: AppStrings.vendor1MetricZeroCount,
    ),
    Vendor1OrderMetricItem(
      label: AppStrings.vendor1OrdersStatusReturnScheduled,
      value: AppStrings.vendor1MetricZeroCount,
    ),
    Vendor1OrderMetricItem(
      label: AppStrings.vendor1OrdersStatusReturned,
      value: AppStrings.vendor1MetricZeroCount,
    ),
  ];

  final List<Vendor1OrderMetricItem> trialRequestMetrics =
      const <Vendor1OrderMetricItem>[
        Vendor1OrderMetricItem(
          label: AppStrings.vendor1TrialRequestsMetricTotal,
          value: AppStrings.vendor1MetricZeroCount,
        ),
        Vendor1OrderMetricItem(
          label: AppStrings.vendor1TrialRequestsMetricPending,
          value: AppStrings.vendor1MetricZeroCount,
        ),
        Vendor1OrderMetricItem(
          label: AppStrings.vendor1TrialRequestsMetricAccepted,
          value: AppStrings.vendor1MetricZeroCount,
        ),
        Vendor1OrderMetricItem(
          label: AppStrings.vendor1TrialRequestsMetricStarted,
          value: AppStrings.vendor1MetricZeroCount,
        ),
        Vendor1OrderMetricItem(
          label: AppStrings.vendor1TrialRequestsMetricRejected,
          value: AppStrings.vendor1MetricZeroCount,
        ),
        Vendor1OrderMetricItem(
          label: AppStrings.vendor1TrialRequestsMetricCompleted,
          value: AppStrings.vendor1MetricZeroCount,
        ),
      ];

  final List<String> trialRequestStatusOptions = const <String>[
    AppStrings.vendor1TrialRequestsFilterAll,
    AppStrings.vendor1TrialRequestsFilterPending,
    AppStrings.vendor1TrialRequestsFilterAccepted,
    AppStrings.vendor1TrialRequestsFilterStarted,
    AppStrings.vendor1TrialRequestsFilterRejected,
    AppStrings.vendor1TrialRequestsFilterCompleted,
  ];

  void setOrdersSection(String section) {
    selectedOrdersSection.value = section;
  }

  void setOrderStatus(String? status) {
    if (status == null) {
      return;
    }

    selectedOrderStatus.value = status;
  }

  void setTrialRequestStatus(String status) {
    selectedTrialRequestStatus.value = status;
  }
}

class Vendor1OrderMetricItem {
  const Vendor1OrderMetricItem({required this.label, required this.value});

  final String label;
  final String value;
}
