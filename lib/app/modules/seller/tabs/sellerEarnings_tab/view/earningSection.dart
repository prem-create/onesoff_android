import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';
import 'package:onesoff/app/modules/seller/tabs/sellerEarnings_tab/getx/controllers/seller_earnings_controller.dart';

class EarningSection extends GetView<SellerEarningsController> {
  const EarningSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    'All',
    'Paid',
    'Pending',
    'Discard',
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
            "Earning Breakdown",
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
            "Order-wise earnings table with filters, sorting, and pagination.",
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
