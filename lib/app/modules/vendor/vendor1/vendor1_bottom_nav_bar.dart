import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';
import 'package:onesoff/app/modules/vendor/vendor1/getx/controllers/vendor1_bottom_nav_bar_controller.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/dashboard/view/vendor1_dashboard_tab.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/earnings/view/vendor1_earnings_tab.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/inventory/view/vendor1_inventory_tab.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/orders/view/vendor1_orders_tab.dart';
import 'package:onesoff/app/modules/vendor/vendor1/tabs/profile/view/vendor1_profile_tab.dart';

class Vendor1BottomNavBar extends GetView<Vendor1BottomNavBarController> {
  const Vendor1BottomNavBar({super.key});

  static const List<_Vendor1NavItem> _items = <_Vendor1NavItem>[
    _Vendor1NavItem(
      label: AppStrings.vendor1NavDashboard,
      icon: Icons.dashboard_outlined,
    ),
    _Vendor1NavItem(
      label: AppStrings.vendor1NavInventory,
      icon: Icons.inventory_2_outlined,
    ),
    _Vendor1NavItem(
      label: AppStrings.vendor1NavOrders,
      icon: Icons.receipt_long_outlined,
    ),
    _Vendor1NavItem(
      label: AppStrings.vendor1NavEarnings,
      icon: Icons.account_balance_wallet_outlined,
    ),
    _Vendor1NavItem(
      label: AppStrings.vendor1NavProfile,
      icon: Icons.person_outline,
    ),
  ];

  static const List<Widget> _tabs = <Widget>[
    Vendor1DashboardTab(),
    Vendor1InventoryTab(),
    Vendor1OrdersTab(),
    Vendor1EarningsTab(),
    Vendor1ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final int index = controller.selectedTabIndex.value;

      return Scaffold(
        backgroundColor: AppColors.dashboardSurface,
        appBar: _vendor1AppBar(context, _items[index].label),
        body: IndexedStack(index: index, children: _tabs),
        bottomNavigationBar: _Vendor1NavigationBar(
          items: _items,
          selectedIndex: index,
          onTap: controller.setTab,
        ),
      );
    });
  }
}

AppBar _vendor1AppBar(BuildContext context, String title) {
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
      children: <Widget>[
        Text(
          title,
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
                          AppStrings.vendor1SearchHint,
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

class _Vendor1NavigationBar extends StatelessWidget {
  const _Vendor1NavigationBar({
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<_Vendor1NavItem> items;
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
              final _Vendor1NavItem item = items[index];
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
                              10,
                              minScale: 0.86,
                              maxScale: 1.08,
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

class _Vendor1NavItem {
  const _Vendor1NavItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
