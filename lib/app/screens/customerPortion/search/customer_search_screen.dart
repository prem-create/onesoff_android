import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/appRoutes.dart';
import '../../../utils/deviceConstants/appColors.dart';
import '../../../utils/deviceConstants/appImages.dart';
import '../../../utils/deviceConstants/appStrings.dart';
import '../../../utils/deviceUtility/deviceResponsive.dart';
import '../home/getx/customer_home_controller.dart';
import 'getx/customer_search_controller.dart';

class CustomerSearchScreen extends GetView<CustomerSearchController> {
  const CustomerSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardSurface,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                DeviceResponsive.w(context, 12),
                DeviceResponsive.h(context, 8),
                DeviceResponsive.w(context, 12),
                DeviceResponsive.h(context, 8),
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: Get.back,
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: DeviceResponsive.r(context, 20),
                      color: AppColors.onSurface,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      AppStrings.dashboardSearchScreenTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.onSurface,
                        fontSize: DeviceResponsive.sp(context, 18, minScale: 0.92, maxScale: 1.14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                DeviceResponsive.w(context, 14),
                0,
                DeviceResponsive.w(context, 14),
                DeviceResponsive.h(context, 8),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
                  border: Border.all(color: const Color(0xFFD1D5DC)),
                ),
                child: TextField(
                  controller: controller.searchController,
                  focusNode: controller.searchFocusNode,
                  onChanged: controller.updateQuery,
                  textInputAction: TextInputAction.search,
                  style: TextStyle(
                    fontSize: DeviceResponsive.sp(context, 14, minScale: 0.92, maxScale: 1.12),
                    color: AppColors.onSurface,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: AppStrings.dashboardSearchHint,
                    hintStyle: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: DeviceResponsive.sp(context, 14, minScale: 0.92, maxScale: 1.12),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: Obx(
                      () => controller.query.value.trim().isEmpty
                          ? const SizedBox.shrink()
                          : IconButton(
                              onPressed: () {
                                controller.searchController.clear();
                                controller.updateQuery('');
                              },
                              icon: const Icon(Icons.close_rounded),
                            ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: DeviceResponsive.w(context, 10),
                      vertical: DeviceResponsive.h(context, 12),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                DeviceResponsive.w(context, 16),
                0,
                DeviceResponsive.w(context, 16),
                DeviceResponsive.h(context, 6),
              ),
              child: Obx(
                () => Row(
                  children: <Widget>[
                    Text(
                      AppStrings.dashboardSearchResultsLabel,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: DeviceResponsive.sp(context, 13, minScale: 0.92, maxScale: 1.12),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${controller.filteredProducts.length}',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: DeviceResponsive.sp(context, 13, minScale: 0.92, maxScale: 1.12),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () {
                  if (controller.filteredProducts.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: DeviceResponsive.w(context, 20)),
                        child: Text(
                          AppStrings.dashboardSearchEmpty,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: DeviceResponsive.sp(context, 14, minScale: 0.92, maxScale: 1.12),
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: EdgeInsets.fromLTRB(
                      DeviceResponsive.w(context, 14),
                      0,
                      DeviceResponsive.w(context, 14),
                      DeviceResponsive.h(context, 12),
                    ),
                    itemCount: controller.filteredProducts.length,
                    separatorBuilder: (_, __) => SizedBox(height: DeviceResponsive.h(context, 10)),
                    itemBuilder: (BuildContext context, int index) {
                      return _SearchResultCard(
                        product: controller.filteredProducts[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  const _SearchResultCard({required this.product});

  final DashboardProductItem product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.customerProductDetails, arguments: product),
      borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
      child: Container(
        padding: EdgeInsets.all(DeviceResponsive.r(context, 8)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
          border: Border.all(color: const Color(0xFFD5D8DF)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: DeviceResponsive.w(context, 82),
              height: DeviceResponsive.h(context, 88),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: DeviceResponsive.w(context, 3),
                    top: DeviceResponsive.h(context, 3),
                    child: Container(
                      width: DeviceResponsive.r(context, 17),
                      height: DeviceResponsive.r(context, 17),
                      padding: EdgeInsets.all(DeviceResponsive.r(context, 2)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFF0A623), width: 1),
                      ),
                      child: Image.asset(AppImages.crown),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: DeviceResponsive.w(context, 10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.onSurface,
                      fontSize: DeviceResponsive.sp(context, 13, minScale: 0.92, maxScale: 1.12),
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: DeviceResponsive.h(context, 3)),
                  Text(
                    product.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: DeviceResponsive.sp(context, 11.5, minScale: 0.92, maxScale: 1.12),
                      height: 1.25,
                    ),
                  ),
                  SizedBox(height: DeviceResponsive.h(context, 6)),
                  Wrap(
                    spacing: DeviceResponsive.w(context, 6),
                    runSpacing: DeviceResponsive.h(context, 4),
                    children: <Widget>[
                      _SearchTag(
                        text: product.tag1,
                        bgColor: const Color(0xFF2B2D31),
                        textColor: Colors.white,
                      ),
                      _SearchTag(
                        text: product.tag2,
                        bgColor: const Color(0xFFF3E9ED),
                        textColor: AppColors.primary,
                      ),
                    ],
                  ),
                  SizedBox(height: DeviceResponsive.h(context, 5)),
                  Row(
                    children: <Widget>[
                      Text(
                        product.discount,
                        style: TextStyle(
                          color: const Color(0xFFF76A24),
                          fontSize: DeviceResponsive.sp(context, 11, minScale: 0.92, maxScale: 1.12),
                        ),
                      ),
                      SizedBox(width: DeviceResponsive.w(context, 8)),
                      Expanded(
                        child: Text(
                          product.price,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.onSurface,
                            fontSize: DeviceResponsive.sp(context, 12, minScale: 0.92, maxScale: 1.12),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: DeviceResponsive.r(context, 18),
                        color: const Color(0xFF7D828A),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchTag extends StatelessWidget {
  const _SearchTag({
    required this.text,
    required this.bgColor,
    required this.textColor,
  });

  final String text;
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 6),
        vertical: DeviceResponsive.h(context, 2),
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: DeviceResponsive.sp(context, 10, minScale: 0.92, maxScale: 1.12),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
