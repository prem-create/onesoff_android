import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/inventory/getx/controllers/vendor1_inventory_controller.dart';

class Vendor1InventoryAgreementsSection
    extends GetView<Vendor1InventoryController> {
  const Vendor1InventoryAgreementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppStrings.vendor1InventoryAgreementsTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: DeviceResponsive.sp(context, 20, minScale: 0.9),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: DeviceResponsive.h(context, 4)),
        Text(
          AppStrings.vendor1InventoryAgreementsSubtitle,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: DeviceResponsive.sp(context, 12, minScale: 0.9),
            height: 1.3,
          ),
        ),
        SizedBox(height: DeviceResponsive.h(context, 16)),
        _AgreementMetricGrid(items: controller.agreementMetrics),
        SizedBox(height: DeviceResponsive.h(context, 16)),
        _AgreementPoliciesCard(terms: controller.agreementTerms),
      ],
    );
  }
}

class _AgreementMetricGrid extends StatelessWidget {
  const _AgreementMetricGrid({required this.items});

  final List<Vendor1InventoryMetricItem> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int crossAxisCount = constraints.maxWidth >= 620 ? 4 : 2;
        final double spacing = DeviceResponsive.w(context, 8);
        final double itemWidth =
            (constraints.maxWidth - (spacing * (crossAxisCount - 1))) /
            crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: DeviceResponsive.h(context, 8),
          children: items
              .map(
                (Vendor1InventoryMetricItem item) => SizedBox(
                  width: itemWidth,
                  child: _AgreementMetricTile(item: item),
                ),
              )
              .toList(growable: false),
        );
      },
    );
  }
}

class _AgreementMetricTile extends StatelessWidget {
  const _AgreementMetricTile({required this.item});

  final Vendor1InventoryMetricItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceResponsive.h(context, 86),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: DeviceResponsive.w(context, 9),
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
            Text(
              item.label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: DeviceResponsive.sp(context, 10.5, minScale: 0.86),
                height: 1.15,
              ),
            ),
            SizedBox(height: DeviceResponsive.h(context, 7)),
            Text(
              item.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: DeviceResponsive.sp(context, 18, minScale: 0.86),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AgreementPoliciesCard extends StatelessWidget {
  const _AgreementPoliciesCard({required this.terms});

  final List<String> terms;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 14),
        vertical: DeviceResponsive.h(context, 14),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: const Color(0xFFE0E2E7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppStrings.vendor1InventoryAgreementPoliciesTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: DeviceResponsive.sp(context, 15, minScale: 0.9),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 4)),
          Text(
            AppStrings.vendor1InventoryAgreementPoliciesSubtitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: DeviceResponsive.sp(context, 12, minScale: 0.86),
              height: 1.35,
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          ...terms.map((String term) => _AgreementTermTile(title: term)),
        ],
      ),
    );
  }
}

class _AgreementTermTile extends StatelessWidget {
  const _AgreementTermTile({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: DeviceResponsive.h(context, 8)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
        border: Border.all(color: const Color(0xFFD5D8DF)),
      ),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: DeviceResponsive.w(context, 10),
          vertical: DeviceResponsive.h(context, 2),
        ),
        leading: Container(
          width: DeviceResponsive.r(context, 24),
          height: DeviceResponsive.r(context, 24),
          decoration: BoxDecoration(
            color: Colors.green.withAlpha(20),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_rounded,
            color: Colors.green,
            size: DeviceResponsive.r(context, 17),
          ),
        ),
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: DeviceResponsive.sp(context, 12, minScale: 0.86),
            fontWeight: FontWeight.w600,
            height: 1.25,
          ),
        ),
      ),
    );
  }
}
