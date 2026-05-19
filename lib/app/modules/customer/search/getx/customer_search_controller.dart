import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/getx/customer_home_controller.dart';

class CustomerSearchController extends GetxController {
  late final CustomerHomeController homeController;

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  final RxString query = ''.obs;
  final RxList<DashboardProductItem> filteredProducts = <DashboardProductItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    homeController = Get.isRegistered<CustomerHomeController>()
        ? Get.find<CustomerHomeController>()
        : Get.put(CustomerHomeController());

    final dynamic args = Get.arguments;
    String initialQuery = '';
    if (args is Map<String, dynamic>) {
      initialQuery = (args['query'] as String? ?? '').trim();
    }

    searchController.text = initialQuery;
    updateQuery(initialQuery);
  }

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (searchFocusNode.canRequestFocus) {
        searchFocusNode.requestFocus();
      }
    });
  }

  void updateQuery(String value) {
    final String normalized = value.trim().toLowerCase();
    query.value = value;

    final List<DashboardProductItem> source = homeController.searchableProducts;
    if (normalized.isEmpty) {
      filteredProducts.assignAll(source);
      return;
    }

    filteredProducts.assignAll(
      source.where((DashboardProductItem product) {
        final String bag =
            '${product.title} ${product.subtitle} ${product.tag1} ${product.tag2}';
        return bag.toLowerCase().contains(normalized);
      }),
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }
}
