import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';
import 'package:onesoff/app/modules/seller/tabs/sellerEarnings_tab/getx/controllers/seller_earnings_controller.dart';

class EarningSection extends GetView<SellerEarningsController> {
  const EarningSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          DeviceResponsive.w(context, 16),
          DeviceResponsive.h(context, 16),
          DeviceResponsive.w(context, 16),
          0,
        ),
        child: Column(
          children: [
            Row(
              children: List<Widget>.generate(controller.metrics.length, (
                int index,
              ) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: index == controller.metrics.length - 1
                          ? 0
                          : DeviceResponsive.w(context, 8),
                    ),
                    child: _EarningMetricTile(item: controller.metrics[index]),
                  ),
                );
              }),
            ),
            SizedBox(height: DeviceResponsive.h(context, 19)),
            _EarningBreakdown(),
          ],
        ),
      ),
    );
  }
}

class _EarningMetricTile extends StatelessWidget {
  const _EarningMetricTile({required this.item});

  final SellerEarningMetricItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceResponsive.h(context, 85),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: DeviceResponsive.w(context, 8),
          vertical: DeviceResponsive.h(context, 10),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
          border: Border.all(color: const Color(0xFFE0E2E7)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    item.label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: DeviceResponsive.sp(
                        context,
                        10.5,
                        minScale: 0.86,
                      ),
                      height: 1.15,
                    ),
                  ),
                ),
                SizedBox(width: DeviceResponsive.w(context, 2)),
                SizedBox(
                  width: DeviceResponsive.r(context, 22),
                  height: DeviceResponsive.r(context, 22),
                  child: IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      Icons.calendar_month,
                      color: AppColors.textSecondary,
                      size: DeviceResponsive.r(context, 15),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: DeviceResponsive.h(context, 5)),
            Text(
              item.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: DeviceResponsive.sp(context, 17, minScale: 0.86),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EarningBreakdown extends StatelessWidget {
  const _EarningBreakdown();

  static const List<String> _filters = <String>[
    AppStrings.sellerEarningsBreakdownFilterAll,
    AppStrings.sellerEarningsBreakdownFilterPaid,
    AppStrings.sellerEarningsBreakdownFilterPending,
    AppStrings.sellerEarningsBreakdownFilterDiscard,
  ];

  @override
  Widget build(BuildContext context) {
    final SellerEarningsController controller =
        Get.find<SellerEarningsController>();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 15),
        vertical: DeviceResponsive.h(context, 19),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: const Color(0xFFE0E2E7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.sellerEarningsBreakdownTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: DeviceResponsive.sp(context, 18, minScale: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ), //title,
          SizedBox(height: DeviceResponsive.h(context, 4)),
          Text(
            AppStrings.sellerEarningsBreakdownSubtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: DeviceResponsive.sp(context, 10, minScale: 0.88),
            ),
          ), //subtitle
          SizedBox(height: DeviceResponsive.h(context, 8)),
          const Divider(height: 1),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          Obx(
            () => Row(
              children: List<Widget>.generate(_filters.length, (int index) {
                final String filter = _filters[index];
                final bool isSelected =
                    controller.selectedBreakdownFilter.value == filter;

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: index == _filters.length - 1
                          ? 0
                          : DeviceResponsive.w(context, 6),
                    ),
                    child: _BreakdownFilterButton(
                      label: filter,
                      isSelected: isSelected,
                      onTap: () => controller.setBreakdownFilter(filter),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          Obx(() {
            final List<SellerEarningBreakdownItem> items =
                controller.filteredBreakdownItems;

            if (items.isEmpty) {
              return const _NoEarningAvailableCard();
            }

            return Column(
              children: items
                  .map(
                    (SellerEarningBreakdownItem item) =>
                        _EarningBreakdownCard(item: item),
                  )
                  .toList(growable: false),
            );
          }),
        ],
      ),
    );
  }
}

class _BreakdownFilterButton extends StatelessWidget {
  const _BreakdownFilterButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceResponsive.h(context, 38),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isSelected ? AppColors.primary : Colors.grey,
          padding: EdgeInsets.symmetric(
            horizontal: DeviceResponsive.w(context, 6),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
          ),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: DeviceResponsive.sp(context, 12, minScale: 0.86),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _EarningBreakdownCard extends StatelessWidget {
  const _EarningBreakdownCard({required this.item});

  final SellerEarningBreakdownItem item;

  @override
  Widget build(BuildContext context) {
    final _EarningStatusStyle statusStyle = _EarningStatusStyle.fromStatus(
      item.status,
    );

    return Container(
      margin: EdgeInsets.only(bottom: DeviceResponsive.h(context, 10)),
      padding: EdgeInsets.all(DeviceResponsive.r(context, 8)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
        border: Border.all(color: const Color(0xFFD5D8DF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  item.productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.onSurface,
                    fontSize: DeviceResponsive.sp(
                      context,
                      13,
                      minScale: 0.92,
                      maxScale: 1.12,
                    ),
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ),
              SizedBox(width: DeviceResponsive.w(context, 8)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: DeviceResponsive.w(context, 8),
                  vertical: DeviceResponsive.h(context, 5),
                ),
                decoration: BoxDecoration(
                  color: statusStyle.backgroundColor,
                  border: Border.all(color: statusStyle.borderColor),
                  borderRadius: BorderRadius.circular(
                    DeviceResponsive.r(context, 10),
                  ),
                ),
                child: Text(
                  item.status,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: statusStyle.textColor,
                    fontSize: DeviceResponsive.sp(
                      context,
                      10,
                      minScale: 0.86,
                      maxScale: 1.08,
                    ),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: DeviceResponsive.h(context, 4)),
          Text(
            item.orderId,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: DeviceResponsive.sp(
                context,
                11.5,
                minScale: 0.92,
                maxScale: 1.12,
              ),
              height: 1.25,
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 2)),
          Text(
            item.netIncome,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: DeviceResponsive.sp(
                context,
                11.5,
                minScale: 0.92,
                maxScale: 1.12,
              ),
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 6)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: DeviceResponsive.w(context, 8),
              vertical: DeviceResponsive.h(context, 5),
            ),
            decoration: BoxDecoration(
              color: Colors.blue.withAlpha(20),
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(
                DeviceResponsive.r(context, 10),
              ),
            ),
            child: Text(
              '${AppStrings.sellerEarningsBreakdownRentalPriceLabel}: ${item.rentalPrice}  '
              '${AppStrings.sellerEarningsBreakdownCommissionLabel}: ${item.commissionAmount}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.blue,
                fontSize: DeviceResponsive.sp(
                  context,
                  10,
                  minScale: 0.86,
                  maxScale: 1.08,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EarningStatusStyle {
  const _EarningStatusStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  factory _EarningStatusStyle.fromStatus(String status) {
    final String normalizedStatus = status.trim().toLowerCase();

    if (normalizedStatus ==
        AppStrings.sellerEarningsBreakdownFilterPaid.toLowerCase()) {
      return _EarningStatusStyle._fromColor(Colors.green);
    }

    if (normalizedStatus ==
        AppStrings.sellerEarningsBreakdownFilterDiscard.toLowerCase()) {
      return _EarningStatusStyle._fromColor(Colors.red);
    }

    return _EarningStatusStyle._fromColor(Colors.orange);
  }

  factory _EarningStatusStyle._fromColor(Color color) {
    return _EarningStatusStyle(
      backgroundColor: color.withAlpha(20),
      borderColor: color,
      textColor: color,
    );
  }
}

class _NoEarningAvailableCard extends StatelessWidget {
  const _NoEarningAvailableCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 16),
        vertical: DeviceResponsive.h(context, 24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.currency_rupee_rounded,
            color: AppColors.primary,
            size: DeviceResponsive.r(context, 30),
          ),
          SizedBox(height: DeviceResponsive.h(context, 8)),
          Text(
            AppStrings.sellerEarningsEmptyTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: DeviceResponsive.sp(context, 14, minScale: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 4)),
          Text(
            AppStrings.sellerEarningsEmptyDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: DeviceResponsive.sp(context, 11, minScale: 0.9),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
