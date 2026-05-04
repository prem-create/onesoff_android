part of 'customer_home_screen.dart';

class CustomerDashboardScreen extends StatelessWidget {
  const CustomerDashboardScreen({
    super.key,
    required this.featureController,
    required this.onCityTap,
  });

  final PageController featureController;
  final VoidCallback onCityTap;

  @override
  Widget build(BuildContext context) {
    return _DashboardContent(
      featureController: featureController,
      onCityTap: onCityTap,
    );
  }
}
