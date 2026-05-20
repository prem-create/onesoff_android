import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appImages.dart';

import '../../core/utils/deviceConstants/appColors.dart';
import '../../core/utils/deviceConstants/appStrings.dart';
import '../../core/utils/deviceUtility/deviceResponsive.dart';
import 'getx/controllers/seller_bottom_nav_bar_controller.dart';
import 'tabs/sellerDashboard_tab/view/seller_dashboard_tab.dart';
import 'tabs/sellerProducts_tab/view/seller_products_tab.dart';

class SellerBottomNavBar extends GetView<SellerBottomNavBarController> {
  const SellerBottomNavBar({super.key});

  static const List<_SellerNavItem> _items = <_SellerNavItem>[
    _SellerNavItem(
      label: AppStrings.sellerNavDashboard,
      icon: Icons.dashboard_outlined,
    ),
    _SellerNavItem(
      label: AppStrings.sellerNavProducts,
      icon: Icons.inventory_2_outlined,
    ),
    _SellerNavItem(
      label: AppStrings.sellerNavEarnings,
      icon: Icons.account_balance_wallet_outlined,
    ),
    _SellerNavItem(
      label: AppStrings.sellerNavProfile,
      icon: Icons.person_outline,
    ),
  ];

  static const List<Widget> _tabs = <Widget>[
    SellerDashboardTab(),
    SellerProductsTab(),
    SizedBox.shrink(),
    SizedBox.shrink(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final index = controller.selectedTabIndex.value;
      return Scaffold(
        backgroundColor: AppColors.dashboardSurface,
        appBar: _buildAppBar(context, index),
        body: IndexedStack(index: index, children: _tabs),

        bottomNavigationBar: _SellerNavigationBar(
          items: _items,
          selectedIndex: index,
          onTap: controller.setTab,
        ),
      );
    });
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, int index) {
    switch (index) {
      case 0:
        return _dashboardAppBar(context);
      case 1:
        return _productsAppBar(context);

      default:
        return AppBar(backgroundColor: AppColors.dashboardSurface);
    }
  }

  AppBar _dashboardAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      surfaceTintColor: AppColors.dashboardSurface,
      toolbarHeight: kToolbarHeight,
      leadingWidth: DeviceResponsive.w(context, 52),
      titleSpacing: DeviceResponsive.w(context, 2),
      leading: const _SellerDashboardLogo(),
      title: const _SellerDashboardTitle(),
      actions: const <Widget>[_SellerNotificationButton()],
    );
  }
}

AppBar _productsAppBar(BuildContext context) {
  final double toolbarHeight = DeviceResponsive.fluid(
    context,
    min: 88,
    max: 104,
  );
  final double buttonSize = DeviceResponsive.r(
    context,
    38,
  ).clamp(34, 42).toDouble();
  final double iconSize = DeviceResponsive.r(
    context,
    20,
  ).clamp(18, 22).toDouble();
  final double badgeSize = DeviceResponsive.r(
    context,
    15,
  ).clamp(13, 16).toDouble();

  return AppBar(
    toolbarHeight: toolbarHeight,
    backgroundColor: AppColors.primary,
    titleSpacing: DeviceResponsive.w(context, 16),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppStrings.sellerProductTabAppBarTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.textOnDark,
            fontSize: DeviceResponsive.sp(context, 16, minScale: 0.92),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: DeviceResponsive.h(context, 8)),
        Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(
                  DeviceResponsive.r(context, 8),
                ),
                child: Container(
                  height: DeviceResponsive.fluid(context, min: 44, max: 48),
                  padding: EdgeInsets.symmetric(
                    horizontal: DeviceResponsive.w(context, 12),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      DeviceResponsive.r(context, 8),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          AppStrings.dashboardSearchHint,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xFF6E747D),
                            fontSize: DeviceResponsive.sp(
                              context,
                              13.5,
                              minScale: 0.86,
                              maxScale: 1,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.search_rounded,
                        color: const Color(0xFF2C2F34),
                        size: DeviceResponsive.r(context, 26),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: DeviceResponsive.w(context, 10)),
            SizedBox(
              width: buttonSize,
              height: buttonSize,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned.fill(
                    child: Material(
                      color: Colors.white.withValues(alpha: 0.12),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {},
                        child: Icon(
                          Icons.filter_alt_outlined,
                          color: Colors.white,
                          size: iconSize,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -DeviceResponsive.r(context, 1),
                    right: -DeviceResponsive.r(context, 1),
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: badgeSize,
                        minHeight: badgeSize,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: DeviceResponsive.w(context, 3),
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.dashboardSurface,
                        borderRadius: BorderRadius.circular(badgeSize),
                        border: Border.all(
                          color: AppColors.primary,
                          width: DeviceResponsive.r(context, 1),
                        ),
                      ),
                      child: Text(
                        AppStrings.sellerDashboardNotificationCount,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: DeviceResponsive.sp(
                            context,
                            9,
                            minScale: 0.9,
                            maxScale: 1.08,
                          ),
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _SellerDashboardLogo extends StatelessWidget {
  const _SellerDashboardLogo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        DeviceResponsive.w(context, 12),
        DeviceResponsive.h(context, 8),
        DeviceResponsive.w(context, 4),
        DeviceResponsive.h(context, 8),
      ),
      child: Image.asset(AppImages.appLogo_1, fit: BoxFit.contain),
    );
  }
}

class _SellerDashboardTitle extends StatelessWidget {
  const _SellerDashboardTitle();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppStrings.sellerBrandTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: DeviceResponsive.sp(context, 13, minScale: 0.92),
            fontWeight: FontWeight.w600,
            height: 1.05,
          ),
        ),
        SizedBox(height: DeviceResponsive.h(context, 2)),
        Text(
          '${AppStrings.sellerDashboardWelcomeBack}, ${AppStrings.sellerName}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: DeviceResponsive.sp(context, 15, minScale: 0.92),
            fontWeight: FontWeight.w700,
            height: 1.05,
          ),
        ),
      ],
    );
  }
}

class _SellerNotificationButton extends StatelessWidget {
  const _SellerNotificationButton();

  @override
  Widget build(BuildContext context) {
    final double buttonSize = DeviceResponsive.r(context, 38);
    final double iconSize = DeviceResponsive.r(context, 20);
    final double badgeSize = DeviceResponsive.r(context, 15);

    return Padding(
      padding: EdgeInsets.only(
        right: DeviceResponsive.w(context, 14),
        left: DeviceResponsive.w(context, 8),
      ),
      child: Center(
        child: SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned.fill(
                child: Material(
                  color: Colors.white.withValues(alpha: 0.12),
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {},
                    child: Icon(
                      Icons.notifications_rounded,
                      color: const Color(0xFFFFD84D),
                      size: iconSize,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -DeviceResponsive.r(context, 1),
                right: -DeviceResponsive.r(context, 1),
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: badgeSize,
                    minHeight: badgeSize,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: DeviceResponsive.w(context, 3),
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.dashboardSurface,
                    borderRadius: BorderRadius.circular(badgeSize),
                    border: Border.all(
                      color: AppColors.primary,
                      width: DeviceResponsive.r(context, 1),
                    ),
                  ),
                  child: Text(
                    AppStrings.sellerDashboardNotificationCount,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: DeviceResponsive.sp(
                        context,
                        9,
                        minScale: 0.9,
                        maxScale: 1.08,
                      ),
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SellerNavigationBar extends StatelessWidget {
  const _SellerNavigationBar({
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<_SellerNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFDEE0E5))),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            DeviceResponsive.w(context, 8),
            DeviceResponsive.h(context, 6),
            DeviceResponsive.w(context, 8),
            DeviceResponsive.h(context, 6),
          ),
          child: Row(
            children: List<Widget>.generate(items.length, (int index) {
              final _SellerNavItem item = items[index];
              final bool isSelected = index == selectedIndex;

              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  borderRadius: BorderRadius.circular(
                    DeviceResponsive.r(context, 10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: DeviceResponsive.h(context, 3),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          item.icon,
                          color: isSelected
                              ? AppColors.primary
                              : const Color(0xFF50545D),
                          size: DeviceResponsive.r(context, 21),
                        ),
                        SizedBox(height: DeviceResponsive.h(context, 3)),
                        Text(
                          item.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.primary
                                : const Color(0xFF50545D),
                            fontSize: DeviceResponsive.sp(
                              context,
                              11,
                              minScale: 0.92,
                              maxScale: 1.12,
                            ),
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _SellerNavItem {
  const _SellerNavItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
