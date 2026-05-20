import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/deviceConstants/appColors.dart';
import '../../../../../core/utils/deviceConstants/appStrings.dart';
import '../../../../../core/utils/deviceUtility/deviceResponsive.dart';
import '../getx/controllers/seller_dashboard_controller.dart';

class SellerDashboardTab extends GetView<SellerDashboardController> {
  const SellerDashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        DeviceResponsive.w(context, 16),
        DeviceResponsive.h(context, 16),
        DeviceResponsive.w(context, 16),
        DeviceResponsive.h(context, 20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SellerWelcomeHeader(),
          SizedBox(height: DeviceResponsive.h(context, 14)),
          GridView.builder(
            itemCount: controller.metrics.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: DeviceResponsive.w(context, 10),
              mainAxisSpacing: DeviceResponsive.h(context, 10),
              childAspectRatio: 1.75,
            ),
            itemBuilder: (BuildContext context, int index) {
              return _MetricTile(item: controller.metrics[index]);
            },
          ),
          SizedBox(height: DeviceResponsive.h(context, 18)),
          _SectionTitle(title: AppStrings.sellerDashboardTodayFocus),
          SizedBox(height: DeviceResponsive.h(context, 8)),
          ...controller.tasks.map((String task) => _TaskRow(title: task)),
        ],
      ),
    );
  }
}

class _SellerWelcomeHeader extends StatelessWidget {
  const _SellerWelcomeHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(DeviceResponsive.r(context, 16)),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppStrings.sellerDashboardWelcomeBack,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.82),
              fontSize: DeviceResponsive.sp(context, 13, minScale: 0.92),
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 6)),
          Text(
            AppStrings.sellerDashboardHeadline,
            style: TextStyle(
              color: Colors.white,
              fontSize: DeviceResponsive.sp(context, 20, minScale: 0.92),
              fontWeight: FontWeight.w700,
              height: 1.15,
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 6)),
          Text(
            AppStrings.sellerDashboardDescription,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.84),
              fontSize: DeviceResponsive.sp(context, 13, minScale: 0.92),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.item});

  final SellerMetricItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(DeviceResponsive.r(context, 12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: const Color(0xFFE0E2E7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            item.value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: DeviceResponsive.sp(context, 20, minScale: 0.9),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 5)),
          Text(
            item.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: DeviceResponsive.sp(context, 12, minScale: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.onSurface,
        fontSize: DeviceResponsive.sp(context, 16, minScale: 0.92),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  const _TaskRow({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: DeviceResponsive.h(context, 8)),
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 12),
        vertical: DeviceResponsive.h(context, 12),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: const Color(0xFFE0E2E7)),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.check_circle_outline,
            color: AppColors.primary,
            size: DeviceResponsive.r(context, 20),
          ),
          SizedBox(width: DeviceResponsive.w(context, 10)),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.onSurface,
                fontSize: DeviceResponsive.sp(context, 13, minScale: 0.92),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
