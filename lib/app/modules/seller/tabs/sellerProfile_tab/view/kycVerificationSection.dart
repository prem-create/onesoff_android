import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';

import '../getx/controllers/seller_profile_controller.dart';

class KycVerificationSection extends GetView<SellerProfileController> {
  const KycVerificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: DeviceResponsive.h(context, 12)),
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 15),
        vertical: DeviceResponsive.h(context, 17),
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
            AppStrings.sellerProfileKycTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: DeviceResponsive.sp(context, 18, minScale: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          _KycFieldList(
            items: <_KycFieldItem>[
              _KycFieldItem(
                icon: Icons.badge_outlined,
                label: AppStrings.sellerProfileIdProofTypeLabel,
                value: controller.idProofType.value,
              ),
              _KycFieldItem(
                icon: Icons.verified_user_outlined,
                label: AppStrings.sellerProfileOwnershipDeclarationLabel,
                value: controller.ownershipDeclaration.value,
              ),
            ],
          ),
          SizedBox(height: DeviceResponsive.h(context, 14)),
          const _KycSectionTitle(
            title: AppStrings.sellerProfileVerificationDocumentsTitle,
          ),
          SizedBox(height: DeviceResponsive.h(context, 10)),
          _InactiveUploadPickerField(
            label: AppStrings.sellerProfileIdProofLabel,
            selectedFileName: controller.idProofDocument.value,
          ),
          SizedBox(height: DeviceResponsive.h(context, 14)),
          const _KycSectionTitle(
            title: AppStrings.sellerProfileVerificationStatusTitle,
          ),
          SizedBox(height: DeviceResponsive.h(context, 10)),
          _VerificationStatusBanner(
            status: controller.verificationStatus.value,
          ),
        ],
      ),
    );
  }
}

class _KycSectionTitle extends StatelessWidget {
  const _KycSectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: DeviceResponsive.sp(context, 14, minScale: 0.9),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _KycFieldList extends StatelessWidget {
  const _KycFieldList({required this.items});

  final List<_KycFieldItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: const Color(0xFFD5D8DF)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: List<Widget>.generate(items.length, (int index) {
          final _KycFieldItem item = items[index];

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _KycFieldTile(item: item),
              if (index != items.length - 1) const Divider(height: 1),
            ],
          );
        }),
      ),
    );
  }
}

class _KycFieldTile extends StatelessWidget {
  const _KycFieldTile({required this.item});

  final _KycFieldItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 12),
        vertical: DeviceResponsive.h(context, 4),
      ),
      leading: Icon(
        item.icon,
        color: AppColors.primary,
        size: DeviceResponsive.r(context, 20),
      ),
      title: Text(
        item.label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: DeviceResponsive.sp(context, 12.5, minScale: 0.9),
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        item.value,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: DeviceResponsive.sp(context, 11, minScale: 0.9),
          height: 1.25,
        ),
      ),
    );
  }
}

class _InactiveUploadPickerField extends StatelessWidget {
  const _InactiveUploadPickerField({
    required this.label,
    required this.selectedFileName,
  });

  final String label;
  final String selectedFileName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: DeviceResponsive.h(context, 4)),
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: DeviceResponsive.sp(
                context,
                14,
                minScale: 0.92,
                maxScale: 1.14,
              ),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        _DashedBorderBox(
          borderRadius: DeviceResponsive.r(context, 12),
          strokeColor: const Color(0xFF9DA2AA),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: DeviceResponsive.w(context, 12),
              vertical: DeviceResponsive.h(context, 20),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                DeviceResponsive.r(context, 12),
              ),
            ),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.upload_rounded,
                  color: AppColors.primary,
                  size: DeviceResponsive.r(context, 24),
                ),
                SizedBox(height: DeviceResponsive.h(context, 6)),
                Text(
                  'Selected File',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: DeviceResponsive.sp(
                      context,
                      14,
                      minScale: 0.92,
                      maxScale: 1.12,
                    ),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: DeviceResponsive.h(context, 2)),
                Text(
                  selectedFileName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: DeviceResponsive.sp(
                      context,
                      12,
                      minScale: 0.92,
                      maxScale: 1.1,
                    ),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _VerificationStatusBanner extends StatelessWidget {
  const _VerificationStatusBanner({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 8),
        vertical: DeviceResponsive.h(context, 8),
      ),
      decoration: BoxDecoration(
        color: Colors.orange.withAlpha(20),
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.info_outline_rounded,
            color: Colors.orange,
            size: DeviceResponsive.r(context, 18),
          ),
          SizedBox(width: DeviceResponsive.w(context, 8)),
          Expanded(
            child: Text(
              '${AppStrings.sellerProfileVerificationStatusLabel}: $status',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.orange,
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
    );
  }
}

class _DashedBorderBox extends StatelessWidget {
  const _DashedBorderBox({
    required this.child,
    required this.borderRadius,
    required this.strokeColor,
  });

  final Widget child;
  final double borderRadius;
  final Color strokeColor;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        borderRadius: borderRadius,
        strokeColor: strokeColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: child,
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({
    required this.borderRadius,
    required this.strokeColor,
  });

  final double borderRadius;
  final Color strokeColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final RRect rRect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(borderRadius),
    );
    final Path path = Path()..addRRect(rRect);
    const double dashWidth = 6;
    const double dashSpace = 4;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double next = (distance + dashWidth) < metric.length
            ? distance + dashWidth
            : metric.length;
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.borderRadius != borderRadius;
  }
}

class _KycFieldItem {
  const _KycFieldItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}
