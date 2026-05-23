import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/inventory/getx/controllers/vendor1_inventory_controller.dart';

class Vendor1InventoryProductListSection
    extends GetView<Vendor1InventoryController> {
  const Vendor1InventoryProductListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                AppStrings.vendor1InventoryTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: DeviceResponsive.sp(context, 20, minScale: 0.9),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: DeviceResponsive.w(context, 10)),
            SizedBox(
              height: DeviceResponsive.h(context, 36),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFFFFD84D),
                  foregroundColor: AppColors.textPrimary,
                  padding: EdgeInsets.symmetric(
                    horizontal: DeviceResponsive.w(context, 14),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      DeviceResponsive.r(context, 8),
                    ),
                  ),
                ),
                child: Text(
                  AppStrings.vendor1InventoryAddProduct,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: DeviceResponsive.sp(context, 12, minScale: 0.88),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: DeviceResponsive.h(context, 4)),
        Text(
          AppStrings.vendor1InventorySubtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: DeviceResponsive.sp(context, 12, minScale: 0.9),
          ),
        ),
        SizedBox(height: DeviceResponsive.h(context, 16)),
        _InventoryMetricGrid(items: controller.metrics),
        SizedBox(height: DeviceResponsive.h(context, 16)),
        const _InventoryFilterCard(),
        SizedBox(height: DeviceResponsive.h(context, 14)),
        ...controller.products.map(
          (Vendor1InventoryProductItem product) =>
              _InventoryProductCard(product: product),
        ),
      ],
    );
  }
}

class _InventoryMetricGrid extends StatelessWidget {
  const _InventoryMetricGrid({required this.items});

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
                  child: _InventoryMetricTile(item: item),
                ),
              )
              .toList(growable: false),
        );
      },
    );
  }
}

class _InventoryMetricTile extends StatelessWidget {
  const _InventoryMetricTile({required this.item});

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

class _InventoryFilterCard extends GetView<Vendor1InventoryController> {
  const _InventoryFilterCard();

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
        children: <Widget>[
          const _InventorySearchBar(),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          Obx(
            () => Row(
              children: <Widget>[
                Expanded(
                  child: _InventoryDropdown(
                    value: controller.selectedCategory.value,
                    items: controller.categoryOptions,
                    onChanged: controller.setCategory,
                  ),
                ),
                SizedBox(width: DeviceResponsive.w(context, 8)),
                Expanded(
                  child: _InventoryDropdown(
                    value: controller.selectedStatus.value,
                    items: controller.statusOptions,
                    onChanged: controller.setStatus,
                  ),
                ),
                SizedBox(width: DeviceResponsive.w(context, 8)),
                Expanded(
                  child: _InventoryDropdown(
                    value: controller.selectedDateFilter.value,
                    items: controller.dateFilterOptions,
                    onChanged: controller.setDateFilter,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InventorySearchBar extends StatelessWidget {
  const _InventorySearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceResponsive.fluid(context, min: 44, max: 48),
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 12),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
        border: Border.all(color: const Color(0xFFD5D8DF)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              AppStrings.vendor1InventorySearchHint,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF6E747D),
                fontSize: DeviceResponsive.sp(
                  context,
                  13,
                  minScale: 0.86,
                  maxScale: 1,
                ),
              ),
            ),
          ),
          Icon(
            Icons.search_rounded,
            color: const Color(0xFF2C2F34),
            size: DeviceResponsive.r(context, 24),
          ),
        ],
      ),
    );
  }
}

class _InventoryDropdown extends StatelessWidget {
  const _InventoryDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceResponsive.h(context, 40),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.textSecondary,
          size: DeviceResponsive.r(context, 18),
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: DeviceResponsive.w(context, 8),
            vertical: DeviceResponsive.h(context, 10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
            borderSide: const BorderSide(color: Color(0xFFD5D8DF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: DeviceResponsive.sp(context, 10.5, minScale: 0.84),
          fontWeight: FontWeight.w600,
        ),
        dropdownColor: Colors.white,
        items: items
            .map(
              (String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            )
            .toList(growable: false),
        onChanged: onChanged,
      ),
    );
  }
}

class _InventoryProductCard extends StatelessWidget {
  const _InventoryProductCard({required this.product});

  final Vendor1InventoryProductItem product;

  @override
  Widget build(BuildContext context) {
    final _InventoryStatusStyle statusStyle = _InventoryStatusStyle.fromStatus(
      product.status,
    );

    return Container(
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
              child: Image.asset(product.image, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: DeviceResponsive.w(context, 10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: _InventoryProductTitle(product: product)),
                    SizedBox(width: DeviceResponsive.w(context, 8)),
                    _InventoryStatusBadge(
                      status: product.status,
                      style: statusStyle,
                    ),
                  ],
                ),
                SizedBox(height: DeviceResponsive.h(context, 3)),
                Text(
                  product.sku,
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
                  product.rentPrice,
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
                _InventoryProductInfoBox(product: product),
                SizedBox(height: DeviceResponsive.h(context, 6)),
                const _InventoryProductActions(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InventoryProductTitle extends StatelessWidget {
  const _InventoryProductTitle({required this.product});

  final Vendor1InventoryProductItem product;

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: product.name,
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
        children: <InlineSpan>[
          TextSpan(
            text: ' ${AppStrings.vendor1InventoryStockPrefix}${product.stock}',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: DeviceResponsive.sp(
                context,
                11,
                minScale: 0.9,
                maxScale: 1.08,
              ),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InventoryStatusBadge extends StatelessWidget {
  const _InventoryStatusBadge({required this.status, required this.style});

  final String status;
  final _InventoryStatusStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 8),
        vertical: DeviceResponsive.h(context, 5),
      ),
      decoration: BoxDecoration(
        color: style.backgroundColor,
        border: Border.all(color: style.borderColor),
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
      ),
      child: Text(
        status,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: style.textColor,
          fontSize: DeviceResponsive.sp(context, 10, minScale: 0.86),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InventoryProductInfoBox extends StatelessWidget {
  const _InventoryProductInfoBox({required this.product});

  final Vendor1InventoryProductItem product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: _InventoryInfoText(value: product.category)),
        SizedBox(width: DeviceResponsive.w(context, 6)),
        Expanded(child: _InventoryInfoText(value: product.gender)),
      ],
    );
  }
}

class _InventoryInfoText extends StatelessWidget {
  const _InventoryInfoText({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 8),
        vertical: DeviceResponsive.h(context, 6),
      ),
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha(20),
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
      ),
      child: Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.blue,
          fontSize: DeviceResponsive.sp(
            context,
            9.5,
            minScale: 0.84,
            maxScale: 1.08,
          ),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InventoryProductActions extends StatelessWidget {
  const _InventoryProductActions();

  @override
  Widget build(BuildContext context) {
    final double gap = DeviceResponsive.w(context, 5);

    return Row(
      children: <Widget>[
        const Expanded(
          child: _InventoryActionButton(
            label: AppStrings.vendor1InventoryViewAction,
          ),
        ),
        SizedBox(width: gap),
        const Expanded(
          child: _InventoryActionButton(
            label: AppStrings.vendor1InventoryEditAction,
          ),
        ),
        SizedBox(width: gap),
        const Expanded(
          child: _InventoryActionButton(
            label: AppStrings.vendor1InventoryDeleteAction,
          ),
        ),
      ],
    );
  }
}

class _InventoryActionButton extends StatelessWidget {
  const _InventoryActionButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final double radius = DeviceResponsive.r(context, 8);

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: DeviceResponsive.h(context, 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF7D838D)),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: const Color(0xFF2C2F34),
            fontSize: DeviceResponsive.sp(context, 10, minScale: 0.84),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _InventoryStatusStyle {
  const _InventoryStatusStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  factory _InventoryStatusStyle.fromStatus(String status) {
    final String normalizedStatus = status.trim().toLowerCase();

    if (normalizedStatus == 'active') {
      return _InventoryStatusStyle._fromColor(Colors.green);
    }

    return _InventoryStatusStyle._fromColor(Colors.orange);
  }

  factory _InventoryStatusStyle._fromColor(Color color) {
    return _InventoryStatusStyle(
      backgroundColor: color.withAlpha(20),
      borderColor: color,
      textColor: color,
    );
  }
}
