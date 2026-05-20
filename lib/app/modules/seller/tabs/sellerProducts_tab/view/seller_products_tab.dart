import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';

import '../getx/controllers/seller_products_controller.dart';

class SellerProductsTab extends GetView<SellerProductsController> {
  const SellerProductsTab({super.key});

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
                  child: _MetricTile(item: controller.metrics[index]),
                ),
              );
            }),
          ),
          SizedBox(height: DeviceResponsive.h(context, 18)),
          ...controller.products.map(
            (SellerProductItem product) => ProductCard(product: product),
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

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final SellerProductItem product;

  @override
  Widget build(BuildContext context) {
    final _ProductStatusStyle statusStyle = _ProductStatusStyle.fromStatus(
      product.status,
    );

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
      child: Container(
        margin: EdgeInsets.only(bottom: DeviceResponsive.h(context, 10)),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  DeviceResponsive.r(context, 10),
                ),
                //image
                child: Image.asset(product.image, fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: DeviceResponsive.w(context, 10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          maxLines: 2,
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
                          border: BoxBorder.all(
                            style: BorderStyle.solid,
                            color: statusStyle.borderColor,
                          ),
                          borderRadius: BorderRadius.circular(
                            DeviceResponsive.r(context, 10),
                          ),
                        ),
                        child: Text(
                          product.status,
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
                  SizedBox(height: DeviceResponsive.h(context, 3)),
                  Text(
                    product.productCode,
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
                  if (product.price != null) ...<Widget>[
                    SizedBox(height: DeviceResponsive.h(context, 2)),
                    Text(
                      product.price!,
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
                  ],
                  SizedBox(height: DeviceResponsive.h(context, 6)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: DeviceResponsive.w(context, 8),
                      vertical: DeviceResponsive.h(context, 5),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withAlpha(20),
                      border: BoxBorder.all(
                        style: BorderStyle.solid,
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(
                        DeviceResponsive.r(context, 10),
                      ),
                    ),
                    child: Text(
                      product.message,
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
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductStatusStyle {
  const _ProductStatusStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  factory _ProductStatusStyle.fromStatus(String status) {
    final String normalizedStatus = status.trim().toLowerCase();

    if (normalizedStatus == 'live') {
      return _ProductStatusStyle._fromColor(Colors.green);
    }

    if (normalizedStatus == 'rejected') {
      return _ProductStatusStyle._fromColor(Colors.red);
    }

    if (normalizedStatus == 'requested' ||
        normalizedStatus == 'request' ||
        normalizedStatus == 'withdrawal' ||
        normalizedStatus == 'withdrawl' ||
        normalizedStatus == 'pending approval') {
      return _ProductStatusStyle._fromColor(Colors.pink);
    }

    return _ProductStatusStyle._fromColor(Colors.orange);
  }

  factory _ProductStatusStyle._fromColor(Color color) {
    return _ProductStatusStyle(
      backgroundColor: color.withAlpha(20),
      borderColor: color,
      textColor: color,
    );
  }
}
