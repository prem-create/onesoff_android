part of 'customer_home_screen.dart';

class CustomerBottomNav extends StatelessWidget {
  const CustomerBottomNav({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onTap,
  });

  final int selectedIndex;
  final List<_BottomNavItem> items;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return _DashboardBottomNav(
      selectedIndex: selectedIndex,
      items: items,
      onTap: onTap,
    );
  }
}
