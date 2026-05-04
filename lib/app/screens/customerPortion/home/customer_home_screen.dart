import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/appRoutes.dart';
import '../../../utils/deviceConstants/appColors.dart';
import '../../../utils/deviceConstants/appImages.dart';
import '../../../utils/deviceConstants/appStrings.dart';
import '../../../utils/deviceUtility/deviceResponsive.dart';
import 'getx/customer_home_controller.dart';
part 'customer_dashboard_screen.dart';
part 'customer_category_screen.dart';
part 'customer_bottom_nav.dart';
part 'customer_orders_screen.dart';
part 'customer_wishlist_screen.dart';
part 'customer_profile_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  late final PageController _featureController;

  CustomerHomeController get controller => Get.find<CustomerHomeController>();

  /// -- Bottom Navigation tabs
  static const List<_BottomNavItem> _bottomItems = <_BottomNavItem>[
    _BottomNavItem(
      label: AppStrings.dashboardNavDashboard,
      icon: Icons.dashboard_outlined,
    ),
    _BottomNavItem(
      label: AppStrings.dashboardNavCategories,
      assetIcon: AppImages.fashion,
    ),
    _BottomNavItem(
      label: AppStrings.dashboardNavOrders,
      assetIcon: AppImages.orders,
    ),
    _BottomNavItem(
      label: AppStrings.dashboardNavWishlist,
      assetIcon: AppImages.wishlist,
    ),
    _BottomNavItem(
      label: AppStrings.dashboardNavProfile,
      assetIcon: AppImages.profile,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _featureController = PageController(viewportFraction: 1);
    if (kDebugMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        final Size size = MediaQuery.sizeOf(context);
        debugPrint(
          'Customer dashboard screen size => width: ${size.width.toStringAsFixed(1)}, height: ${size.height.toStringAsFixed(1)}',
        );
      });
    }
  }

  @override
  void dispose() {
    _featureController.dispose();
    super.dispose();
  }

  /// -- select city bottom sheet
  Future<void> _showCityBottomSheet(BuildContext context) async {
    final String selected = controller.selectedCity.value;
    final String? result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        String selectedCity = selected;
        final double screenHeight = MediaQuery.sizeOf(context).height;
        final double preferred = DeviceResponsive.h(context, 420);
        final double maxAllowed = screenHeight * 0.72;
        final double sheetHeight = preferred < maxAllowed ? preferred : maxAllowed;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setSheetState) {
            return SafeArea(
              top: false,
              child: Container(
                height: sheetHeight,
                padding: EdgeInsets.fromLTRB(
                  DeviceResponsive.w(context, 16),
                  DeviceResponsive.h(context, 8),
                  DeviceResponsive.w(context, 16),
                  DeviceResponsive.h(context, 14),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(DeviceResponsive.r(context, 22)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: DeviceResponsive.w(context, 72),
                        height: DeviceResponsive.h(context, 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4D6DB),
                          borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 50)),
                        ),
                      ),
                    ),
                    SizedBox(height: DeviceResponsive.h(context, 10)),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            AppStrings.dashboardOperationalCitiesTitle,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: DeviceResponsive.sp(
                                context,
                                16,
                                minScale: 0.92,
                                maxScale: 1.16,
                              ),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: AppColors.textSecondary,
                            size: DeviceResponsive.r(context, 20),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    SizedBox(height: DeviceResponsive.h(context, 6)),
                    Expanded(
                      child: GridView.builder(
                        itemCount: controller.operationalCities.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: DeviceResponsive.w(context, 12),
                          mainAxisSpacing: DeviceResponsive.h(context, 12),
                          mainAxisExtent: DeviceResponsive.h(context, 124),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final DashboardCityItem city = controller.operationalCities[index];
                          final bool isSelected = city.name == selectedCity;

                          return InkWell(
                            borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
                            onTap: () {
                              setSheetState(() {
                                selectedCity = city.name;
                              });
                            },
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.primary
                                            : const Color(0xFFE1E3E8),
                                        width: isSelected ? 1.8 : 1,
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.asset(
                                      city.image,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                SizedBox(height: DeviceResponsive.h(context, 4)),
                                Text(
                                  city.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: DeviceResponsive.sp(
                                      context,
                                      14,
                                      minScale: 0.92,
                                      maxScale: 1.14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: DeviceResponsive.h(context, 8)),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(selectedCity),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                          minimumSize: Size.fromHeight(DeviceResponsive.h(context, 44)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
                          ),
                        ),
                        child: Text(
                          AppStrings.dashboardExploreCityCta,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: DeviceResponsive.sp(context, 15, minScale: 0.92, maxScale: 1.15),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (result != null && result.trim().isNotEmpty) {
      controller.setSelectedCity(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardSurface,
      body: Stack(
        children: <Widget>[
          Obx(() {
            final int tabIndex = controller.selectedBottomTab.value;
            switch (tabIndex) {
              case 0:
                return CustomerDashboardScreen(
                  featureController: _featureController,
                  onCityTap: () => _showCityBottomSheet(context),
                );
              case 1:
                return const CustomerCategoryScreen();
              case 2:
                return const CustomerOrdersScreen();
              case 3:
                return const CustomerWishlistScreen();
              case 4:
                return const CustomerProfileScreen();
              default:
                return _DashboardPlaceholder(title: _bottomItems[tabIndex].label);
            }
          }),
          if (kDebugMode)
            Obx(
              () => controller.selectedBottomTab.value == 0
                  ? const _DevScreenDiagnosticsOverlay()
                  : const SizedBox.shrink(),
            ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => CustomerBottomNav(
          selectedIndex: controller.selectedBottomTab.value,
          items: _bottomItems,
          onTap: controller.setBottomTab,
        ),
      ),
    );
  }
}

/// -- Dashboard body
class _DashboardContent extends GetView<CustomerHomeController> {
  const _DashboardContent({
    required this.featureController,
    required this.onCityTap,
  });

  final PageController featureController;
  final VoidCallback onCityTap;

  @override
  Widget build(BuildContext context) {
    final double sectionToProductsGap = DeviceResponsive.h(context, 2);
    return Column(
      children: <Widget>[
        /// -- Dashboard Header section
        _DashboardHeader(onCityTap: onCityTap),

        /// -- Dashboard Body:
        Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              DeviceResponsive.w(context, 14),
              DeviceResponsive.h(context, 10),
              DeviceResponsive.w(context, 14),
              DeviceResponsive.h(context, 12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// -- Dashboard Banner
                // -- Banner title
                _SectionTitle(title: AppStrings.dashboardFeaturesTitle),
                SizedBox(height: DeviceResponsive.h(context, 4)),
                // -- banner card
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final double bannerHeight = (constraints.maxWidth * 0.43)
                        .clamp(
                          DeviceResponsive.h(context, 150),
                          DeviceResponsive.h(context, 230),
                        )
                        .toDouble();
                    return SizedBox(
                      height: bannerHeight,
                      child: PageView.builder(
                        controller: featureController,
                        itemCount: controller.features.length,
                        onPageChanged: controller.setFeatureIndex,
                        itemBuilder: (BuildContext context, int index) {
                          final DashboardFeatureItem feature = controller.features[index];
                          return Padding(
                            padding: EdgeInsets.only(right: DeviceResponsive.w(context, 6)),
                            child: _FeatureCard(feature: feature),
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: DeviceResponsive.h(context, 8)),
                // -- banner dot indicator
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                      controller.features.length,
                      (int index) {
                        final bool isActive =
                            controller.selectedFeatureIndex.value == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          margin: EdgeInsets.symmetric(horizontal: DeviceResponsive.w(context, 2)),
                          width: isActive
                              ? DeviceResponsive.w(context, 38)
                              : DeviceResponsive.w(context, 8),
                          height: DeviceResponsive.h(context, 6),
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.primary
                                : const Color(0xFFC7C8CC),
                            borderRadius:
                                BorderRadius.circular(DeviceResponsive.r(context, 20)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: DeviceResponsive.h(context, 14)),

                /// -- Personalized Recommendation Section & product Cards.
                _SectionTitle(title: AppStrings.dashboardPersonalizedTitle),
                SizedBox(height: sectionToProductsGap),
                _ProductGrid(products: controller.personalizedProducts),
                SizedBox(height: DeviceResponsive.h(context, 10)),
                const _SeeAllProductsButton(),
                SizedBox(height: DeviceResponsive.h(context, 10)),

                /// -- Shop by category Section
                _SectionTitle(title: AppStrings.dashboardShopByCategoryTitle),
                SizedBox(height: DeviceResponsive.h(context, 8)),
                _CategoryPanel(
                  categories: controller.categories,
                  backgroundColor: const Color(0xFFF6E8DD),
                ),
                SizedBox(height: DeviceResponsive.h(context, 12)),

                /// -- shop by events section
                _SectionTitle(title: AppStrings.dashboardShopByEventsTitle),
                SizedBox(height: DeviceResponsive.h(context, 8)),
                _CategoryPanel(
                  categories: controller.events,
                  backgroundColor: const Color(0xFFF8EFC8),
                ),
                SizedBox(height: DeviceResponsive.h(context, 12)),

                /// -- Trending now Section & product Cards.
                _SectionTitle(title: AppStrings.dashboardTrendingNowTitle),
                SizedBox(height: sectionToProductsGap),
                _ProductGrid(products: controller.trendingProducts),
                SizedBox(height: DeviceResponsive.h(context, 10)),
                const _SeeAllProductsButton(),
                SizedBox(height: DeviceResponsive.h(context, 12)),

                /// -- wedding planner section.
                const _WeddingPlannerCard(),
                SizedBox(height: DeviceResponsive.h(context, 12)),

                /// -- Accessories collection Section & product Cards.
                _SectionTitle(title: AppStrings.dashboardAccessoriesTitle),
                SizedBox(height: sectionToProductsGap),
                _ProductGrid(products: controller.accessoriesProducts),
                SizedBox(height: DeviceResponsive.h(context, 10)),
                const _SeeAllProductsButton(),
                SizedBox(height: DeviceResponsive.h(context, 12)),

                /// -- Kids woodrow card section
                const _KidsWoodrowCard(),
                SizedBox(height: DeviceResponsive.h(context, 12)),

                /// -- Kids woodrow Section & product Cards.
                _SectionTitle(title: AppStrings.dashboardKidsWoodrowTitle),
                SizedBox(height: sectionToProductsGap),
                _ProductGrid(products: controller.kidsProducts),
                SizedBox(height: DeviceResponsive.h(context, 10)),
                const _SeeAllProductsButton(),
                SizedBox(height: DeviceResponsive.h(context, 12)),

                /// -- Why choose onesoff? card section
                const _WhyChooseOnesoffCard(),
                SizedBox(height: DeviceResponsive.h(context, 10)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StoreCategoryTabContent extends GetView<CustomerHomeController> {
  const _StoreCategoryTabContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const _StoreCategoryHeader(),
        Expanded(
          child: Container(
            color: AppColors.dashboardSurface,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: DeviceResponsive.fluid(context, min: 84, max: 96),
                  child: const _StoreCategoryRail(),
                ),
                Container(width: 1, color: const Color(0xFFDADDE3)),
                const Expanded(child: _StoreProductGridPane()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StoreCategoryHeader extends StatelessWidget {
  const _StoreCategoryHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryDark,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            DeviceResponsive.w(context, 14),
            DeviceResponsive.h(context, 10),
            DeviceResponsive.w(context, 14),
            DeviceResponsive.h(context, 12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    AppImages.appLogo_1,
                    width: DeviceResponsive.r(context, 23),
                    height: DeviceResponsive.r(context, 23),
                    color: Colors.white,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.auto_awesome_mosaic_rounded,
                      color: Colors.white,
                      size: DeviceResponsive.r(context, 22),
                    ),
                  ),
                  SizedBox(width: DeviceResponsive.w(context, 6)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppStrings.storeHeaderTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: DeviceResponsive.sp(context, 22, minScale: 0.74, maxScale: 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          AppStrings.storeHeaderSubtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xFFD8D4DA),
                            fontSize: DeviceResponsive.sp(context, 13, minScale: 0.78, maxScale: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: DeviceResponsive.h(context, 10)),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.customerSearch,
                          arguments: <String, dynamic>{'query': ''},
                        );
                      },
                      borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
                      child: Container(
                        height: DeviceResponsive.fluid(context, min: 44, max: 48),
                        padding: EdgeInsets.symmetric(horizontal: DeviceResponsive.w(context, 12)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
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
                                  fontSize: DeviceResponsive.sp(context, 13.5, minScale: 0.86, maxScale: 1),
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
                  Container(
                    width: DeviceResponsive.fluid(context, min: 46, max: 52),
                    height: DeviceResponsive.fluid(context, min: 44, max: 48),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
                    ),
                    child: Icon(
                      Icons.filter_alt_outlined,
                      size: DeviceResponsive.r(context, 24),
                      color: const Color(0xFF2D3138),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoreCategoryRail extends GetView<CustomerHomeController> {
  const _StoreCategoryRail();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final int selectedIndex = controller.selectedStoreCategoryIndex.value;
        final List<DashboardQuickCategory> categories = controller.storeCategories;
        return ListView.separated(
          padding: EdgeInsets.fromLTRB(
            DeviceResponsive.w(context, 6),
            DeviceResponsive.h(context, 8),
            DeviceResponsive.w(context, 6),
            DeviceResponsive.h(context, 8),
          ),
          itemCount: categories.length,
          separatorBuilder: (_, __) => SizedBox(height: DeviceResponsive.h(context, 8)),
          itemBuilder: (BuildContext context, int index) {
            final DashboardQuickCategory item = categories[index];
            final bool isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () => controller.setSelectedStoreCategory(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: EdgeInsets.symmetric(
                  horizontal: DeviceResponsive.w(context, 4),
                  vertical: DeviceResponsive.h(context, 4),
                ),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFF5E9ED) : Colors.transparent,
                  borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
                  border: Border.all(
                    color: isSelected ? const Color(0xFFB08491) : Colors.transparent,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
                      child: Image.asset(
                        item.image,
                        height: DeviceResponsive.fluid(context, min: 54, max: 66),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: DeviceResponsive.h(context, 4)),
                    Text(
                      item.label,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isSelected ? AppColors.primary : const Color(0xFF5C5E64),
                        fontSize: DeviceResponsive.sp(context, 13, minScale: 0.78, maxScale: 1),
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _StoreProductGridPane extends GetView<CustomerHomeController> {
  const _StoreProductGridPane();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        DeviceResponsive.w(context, 8),
        DeviceResponsive.h(context, 8),
        DeviceResponsive.w(context, 8),
        DeviceResponsive.h(context, 8),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final List<DashboardProductItem> products = controller.storeProducts;
          final double availableWidth = constraints.maxWidth;
          final double spacing = DeviceResponsive.fluid(context, min: 6, max: 10);
          final double minCardWidth = DeviceResponsive.fluid(context, min: 124, max: 142);
          int crossAxisCount = ((availableWidth + spacing) / (minCardWidth + spacing)).floor();
          crossAxisCount = math.max(2, math.min(3, crossAxisCount));

          final double cardWidth =
              (availableWidth - ((crossAxisCount - 1) * spacing)) / crossAxisCount;
          final double textScale = DeviceResponsive.systemTextScale(
            context,
            min: 1.0,
            max: 1.35,
          );
          final double imageHeight = cardWidth * 0.94;
          final double detailsHeight = (cardWidth * 0.88) + ((textScale - 1) * 56);
          final double cardHeight = imageHeight + detailsHeight;

          return GridView.builder(
            itemCount: products.length,
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              mainAxisExtent: cardHeight,
            ),
            itemBuilder: (BuildContext context, int index) {
              return _StoreProductCard(product: products[index]);
            },
          );
        },
      ),
    );
  }
}

class _StoreProductCard extends StatelessWidget {
  const _StoreProductCard({required this.product});

  final DashboardProductItem product;

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = DeviceResponsive.fluid(context, min: 4, max: 7);
    final double verticalPadding = DeviceResponsive.fluid(context, min: 4, max: 7);
    final double smallGap = DeviceResponsive.fluid(context, min: 1, max: 3);

    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.customerProductDetails, arguments: product),
      borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
          border: Border.all(color: const Color(0xFFD2D5DC)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: DeviceResponsive.w(context, 4),
                  top: DeviceResponsive.h(context, 4),
                  child: const _CardPartnerBadge(),
                ),
                Positioned(
                  right: DeviceResponsive.w(context, 4),
                  top: DeviceResponsive.h(context, 4),
                  child: Container(
                    width: DeviceResponsive.r(context, 16),
                    height: DeviceResponsive.r(context, 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFC4C8D0)),
                    ),
                    child: Icon(
                      Icons.favorite_border_rounded,
                      size: DeviceResponsive.r(context, 10),
                      color: const Color(0xFF7A7D83),
                    ),
                  ),
                ),
              ],
            ),
          ),
            Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                verticalPadding,
                horizontalPadding,
                verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _RatingTag(rating: product.tag1),
                      SizedBox(width: DeviceResponsive.w(context, 2)),
                      Flexible(
                        child: _PillTag(
                          text: product.tag2,
                          color: _tagColor(product.tag2),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: smallGap),
                  _AdaptiveText(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    minFontScale: 0.90,
                    style: TextStyle(
                      color: const Color(0xFF26282C),
                      fontSize: DeviceResponsive.sp(context, 11, minScale: 0.84, maxScale: 1),
                      fontWeight: FontWeight.w500,
                      height: 1.15,
                    ),
                  ),
                  SizedBox(height: smallGap),
                  Expanded(
                    child: _AdaptiveText(
                      product.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      minFontScale: 0.88,
                      style: TextStyle(
                        color: const Color(0xFF666B74),
                        fontSize: DeviceResponsive.sp(context, 8.8, minScale: 0.84, maxScale: 1),
                        height: 1.18,
                      ),
                    ),
                  ),
                  SizedBox(height: smallGap),
                  Text(
                    product.discount,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: const Color(0xFFFF6F2B),
                      fontSize: DeviceResponsive.sp(context, 7.2, minScale: 0.84, maxScale: 1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: smallGap),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          product.price,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xFF202227),
                            fontSize: DeviceResponsive.sp(context, 11.5, minScale: 0.84, maxScale: 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: const Color(0xFF8A8D94),
                        size: DeviceResponsive.r(context, 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }

  Color _tagColor(String tag) {
    switch (tag.toLowerCase()) {
      case 'most booked':
        return const Color(0xFFE6672E);
      case 'popular':
        return const Color(0xFFC8104E);
      case 'new':
        return const Color(0xFF63B36E);
      default:
        return AppColors.primary;
    }
  }
}

/// --  dashboard header widget
class _DashboardHeader extends GetView<CustomerHomeController> {
  const _DashboardHeader({required this.onCityTap});

  final VoidCallback onCityTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryDark,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            DeviceResponsive.w(context, 14),
            DeviceResponsive.h(context, 8),
            DeviceResponsive.w(context, 14),
            DeviceResponsive.h(context, 12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// -- App logo, name, welcome text and notification bell.
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// -- App logo
                  Image.asset(
                    AppImages.appLogo_1,
                    height: DeviceResponsive.r(context, 24),
                    width: DeviceResponsive.r(context, 24),
                    color: Colors.white,
                    errorBuilder: (_, __, ___) {
                      return Icon(
                        Icons.auto_awesome_mosaic_rounded,
                        color: Colors.white,
                        size: DeviceResponsive.r(context, 22),
                      );
                    },
                  ),
                  SizedBox(width: DeviceResponsive.w(context, 8)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// -- App Name
                        Text(
                          AppStrings.appName,
                          style: TextStyle(
                            color: const Color(0xFFCFCFD4),
                            fontSize: DeviceResponsive.sp(context, 10, minScale: 0.92, maxScale: 1.14,),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        /// -- App welcome text
                        Text(
                          AppStrings.dashboardWelcomeBack,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: DeviceResponsive.sp(
                              context,
                              12,
                              minScale: 0.92,
                              maxScale: 1.16,
                            ),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const _NotificationBell(),
                ],
              ),
              SizedBox(height: DeviceResponsive.h(context, 8)),

              /// -- dashboard question text
              Text(
                AppStrings.dashboardQuestionText,
                style: TextStyle(
                  color: const Color(0xFFD0CFD5),
                  fontSize: DeviceResponsive.sp(context, 12, minScale: 0.92, maxScale: 1.14),
                ),
              ),
              SizedBox(height: DeviceResponsive.h(context, 6)),

              /// -- Search bar and the Location selector
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /// -- Search Bar.
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.customerSearch,
                          arguments: <String, dynamic>{'query': ''},
                        );
                      },
                      borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
                      child: Container(
                        height: DeviceResponsive.h(context, 46),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
                        ),
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: DeviceResponsive.w(context, 12)),
                            Expanded(
                              child: Text(
                                AppStrings.dashboardSearchHint,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: const Color(0xFF757A82),
                                  fontSize: DeviceResponsive.sp(
                                    context,
                                    12,
                                    minScale: 0.92,
                                    maxScale: 1.14,
                                  ),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.search,
                              color: const Color(0xFF2C2F34),
                              size: DeviceResponsive.r(context, 24),
                            ),
                            SizedBox(width: DeviceResponsive.w(context, 10)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: DeviceResponsive.w(context, 8)),

                  /// -- Location Selector
                  Obx(
                    () {
                      final String selectedCityName = controller.selectedCity.value;
                      final DashboardCityItem city = controller.operationalCities.firstWhere(
                        (DashboardCityItem item) => item.name == selectedCityName,
                        orElse: () => controller.operationalCities.first,
                      );

                      return GestureDetector(
                        onTap: onCityTap,
                        child: SizedBox(
                          width: DeviceResponsive.w(context, 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
                                child: Image.asset(
                                  city.image,
                                  width: double.infinity,
                                  height: DeviceResponsive.h(context, 30),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: DeviceResponsive.h(context, 0)),
                              Text(
                                city.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: const Color(0xFFEAE9EE),
                                  fontSize: DeviceResponsive.sp(context, 10, minScale: 0.92, maxScale: 1.14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// -- Notification Bell widget
class _NotificationBell extends StatelessWidget {
  const _NotificationBell();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DeviceResponsive.r(context, 34),
      height: DeviceResponsive.r(context, 34),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            width: DeviceResponsive.r(context, 34),
            height: DeviceResponsive.r(context, 34),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications,
              color: Colors.yellow,
              size: DeviceResponsive.r(context, 19),
            ),
          ),
          Positioned(
            right: DeviceResponsive.w(context, -1),
            top: DeviceResponsive.h(context, -1),
            child: Container(
              width: DeviceResponsive.w(context, 14),
              height: DeviceResponsive.h(context, 14),
              padding: EdgeInsets.symmetric(horizontal: DeviceResponsive.w(context, 3)),
              decoration: const BoxDecoration(
                color: Color(0xFF3145B8),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '6',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: DeviceResponsive.sp(context, 9, minScale: 0.92, maxScale: 1.12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/// -- Banners card with dot indicators
class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.feature});

  final DashboardFeatureItem feature;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 18)),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(feature.image, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withOpacity(0.02),
                  Colors.black.withOpacity(0.12),
                  Colors.black.withOpacity(0.86),
                ],
                stops: const <double>[0.0, 0.45, 1.0],
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                DeviceResponsive.w(context, 10),
                DeviceResponsive.h(context, 10),
                DeviceResponsive.w(context, 10),
                DeviceResponsive.h(context, 10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: DeviceResponsive.w(context, 10),
                      vertical: DeviceResponsive.h(context, 4),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x4A2D3037),
                      borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 14)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.local_fire_department_rounded,
                          color: const Color(0xFFFF6F3E),
                          size: DeviceResponsive.r(context, 14),
                        ),
                        SizedBox(width: DeviceResponsive.w(context, 5)),
                        Text(
                          feature.badge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xFFF2F2F4),
                            fontSize: DeviceResponsive.sp(context, 9.5, minScale: 0.92, maxScale: 1.1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: DeviceResponsive.h(context, 8)),
                  Text(
                    feature.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: DeviceResponsive.sp(context, 13.5, minScale: 0.92, maxScale: 1.12),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: DeviceResponsive.h(context, 1)),
                  Text(
                    feature.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: const Color(0xFFE7E7EA),
                      fontSize: DeviceResponsive.sp(context, 10, minScale: 0.92, maxScale: 1.1),
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// -- Title of any section.
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.onSurface,
        fontSize: DeviceResponsive.sp(context, 14, minScale: 0.92, maxScale: 1.12),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

/// -- Product Grid (3x3) or (2*6)
class _ProductGrid extends StatelessWidget {
  const _ProductGrid({required this.products});

  final List<DashboardProductItem> products;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {

        final double availableWidth = constraints.maxWidth;
        final double spacing = DeviceResponsive.fluid(context, min: 6, max: 10);
        final double minCardWidth = DeviceResponsive.fluid(context, min: 108, max: 126);

        /// -- Cross Access count of product grid.
        int crossAxisCount = ((availableWidth + spacing) / (minCardWidth + spacing)).floor();
        crossAxisCount = math.max(2, math.min(4, crossAxisCount));

        final double cardWidth = (availableWidth - ((crossAxisCount - 1) * spacing)) / crossAxisCount;
        final double textScale = DeviceResponsive.systemTextScale(context, min: 1.0, max: 1.4,);
        final double imageHeight = cardWidth * 0.96;
        final double detailsHeight = (cardWidth * 0.94) + ((textScale - 1) * 92);
        final double cardHeight = imageHeight + detailsHeight;

        return GridView.builder(
          itemCount: products.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            mainAxisExtent: cardHeight,
          ),
          itemBuilder: (BuildContext context, int index) {
            return _ProductCard(product: products[index]);
          },
        );
      },
    );
  }
}

/// -- Products cards
class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final DashboardProductItem product;

  @override
  Widget build(BuildContext context) {

    final double horizontalPadding = DeviceResponsive.fluid(context, min: 6, max: 10);
    final double verticalPadding = DeviceResponsive.fluid(context, min: 5, max: 8);
    final double smallGap = DeviceResponsive.fluid(context, min: 2, max: 4);
    final double mediumGap = DeviceResponsive.fluid(context, min: 4, max: 6);

    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.customerProductDetails, arguments: product),
      borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 14)),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 14)),
          border: Border.all(color: const Color(0xFFD2D5DC)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          /// -- Product Image and Favorite icon
          AspectRatio(
            aspectRatio: 0.98,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: DeviceResponsive.w(context, 5),
                  top: DeviceResponsive.h(context, 5),
                  child: const _CardPartnerBadge(),
                ),
                Positioned(
                  right: DeviceResponsive.w(context, 5),
                  top: DeviceResponsive.h(context, 5),
                  child: Container(
                    width: DeviceResponsive.r(context, 18),
                    height: DeviceResponsive.r(context, 18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFC4C8D0)),
                    ),
                    child: Icon(
                      Icons.favorite_border_rounded,
                      size: DeviceResponsive.r(context, 11),
                      color: const Color(0xFF7A7D83),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// --
            Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                verticalPadding,
                horizontalPadding,
                verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// -- Ratings and Product tags
                  Row(
                    children: <Widget>[
                      _RatingTag(
                        rating: product.tag1,
                      ),
                      SizedBox(width: DeviceResponsive.w(context, 3)),
                      Flexible(
                        child: _PillTag(
                          text: product.tag2,
                          color: _tagColor(product.tag2),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: mediumGap),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _AdaptiveText(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          minFontScale: 0.90,
                          style: TextStyle(
                            color: const Color(0xFF26282C),
                            fontSize: DeviceResponsive.sp(context, 12, minScale: 0.92, maxScale: 1.08),
                            fontWeight: FontWeight.w500,
                            height: 1.15,
                          ),
                        ),
                        SizedBox(height: smallGap),
                        Flexible(
                          child: _AdaptiveText(
                            product.subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            minFontScale: 0.88,
                            style: TextStyle(
                              color: const Color(0xFF666B74),
                              fontSize: DeviceResponsive.sp(context, 10, minScale: 0.92, maxScale: 1.08),
                              height: 1.2,
                            ),
                          ),
                        ),
                        SizedBox(height: smallGap),
                        Text(
                          product.discount,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xFFFF6F2B),
                            fontSize: DeviceResponsive.sp(context, 8, minScale: 0.92, maxScale: 1.08),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                product.price,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: const Color(0xFF202227),
                                  fontSize: DeviceResponsive.sp(context, 12, minScale: 0.92, maxScale: 1.08),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: const Color(0xFF8A8D94),
                              size: DeviceResponsive.r(context, 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }

  Color _tagColor(String tag) {
    switch (tag.toLowerCase()) {
      case 'most booked':
        return const Color(0xFFE6672E);
      case 'popular':
        return const Color(0xFFC8104E);
      case 'new':
        return const Color(0xFF63B36E);
      default:
        return AppColors.primary;
    }
  }
}

class _CardPartnerBadge extends StatelessWidget {
  const _CardPartnerBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceResponsive.r(context, 20),
      height: DeviceResponsive.r(context, 20),
      padding: EdgeInsets.all(DeviceResponsive.r(context, 2.5)),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFF0A623), width: 1),
      ),
      child: Image.asset(
        AppImages.crown,
        fit: BoxFit.contain,
      ),
    );
  }
}

/// -- rating tag
class _RatingTag extends StatelessWidget {
  const _RatingTag({required this.rating});

  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 2),
        vertical: DeviceResponsive.h(context, 1),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2D30),
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.star_rounded,
            color: const Color(0xFFF8B336),
            size: DeviceResponsive.r(context, 8.5),
          ),
          SizedBox(width: DeviceResponsive.w(context, 2)),
          Text(
            rating,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: TextStyle(
              color: Colors.white,
              fontSize: DeviceResponsive.sp(context, 7.8, minScale: 0.92, maxScale: 1.08),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// -- Pill tag
class _PillTag extends StatelessWidget {
  const _PillTag({
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 2),
        vertical: DeviceResponsive.h(context, 1),
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 3)),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: TextStyle(
          color: Colors.white,
          fontSize: DeviceResponsive.sp(context, 8, minScale: 0.92, maxScale: 1.08),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}


/// -- see all buttons
class _SeeAllProductsButton extends StatelessWidget {
  const _SeeAllProductsButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 12),
        vertical: DeviceResponsive.h(context, 8),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: const Color(0xFFD2D6DE)),
        color: const Color(0xFFF4F6FA),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: DeviceResponsive.w(context, 34),
            height: DeviceResponsive.r(context, 22),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  left: 0,
                  top: 0,
                  child: const _TinyAvatar(image: AppImages.womensWear),
                ),
                Positioned(
                  left: DeviceResponsive.w(context, 12),
                  top: 0,
                  child: const _TinyAvatar(image: AppImages.jewelry),
                ),
                Positioned(
                  left: DeviceResponsive.w(context, 22),
                  top: 0,
                  child: const _TinyAvatar(image: AppImages.mensWear),
                ),
              ],
            ),
          ),
          SizedBox(width: DeviceResponsive.w(context, 14)),
          Text(
            AppStrings.dashboardSeeAllProducts,
            style: TextStyle(
              color: const Color(0xFF2458AE),
              fontSize: DeviceResponsive.sp(context, 12, minScale: 0.92, maxScale: 1.12),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// -- tiny avatars
class _TinyAvatar extends StatelessWidget {
  const _TinyAvatar({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceResponsive.r(context, 22),
      height: DeviceResponsive.r(context, 22),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.2),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _CategoryPanel extends StatelessWidget {
  const _CategoryPanel({
    required this.categories,
    required this.backgroundColor,
  });

  final List<DashboardQuickCategory> categories;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        DeviceResponsive.w(context, 10),
        DeviceResponsive.h(context, 8),
        DeviceResponsive.w(context, 10),
        DeviceResponsive.h(context, 10),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: categories
                .map(
                  (DashboardQuickCategory item) => Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: DeviceResponsive.r(context, 70),
                          height: DeviceResponsive.r(context, 70),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFBCA28A)),
                            image: DecorationImage(
                              image: AssetImage(item.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: DeviceResponsive.h(context, 4)),
                        Text(
                          item.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xFF362D2C),
                            fontSize: DeviceResponsive.sp(context, 10, minScale: 0.92, maxScale: 1.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(growable: false),
          ),
          SizedBox(height: DeviceResponsive.h(context, 8)),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
                ),
                minimumSize: Size.fromHeight(DeviceResponsive.h(context, 34)),
              ),
              child: Text(
                AppStrings.dashboardExploreStore,
                style: TextStyle(
                  fontSize: DeviceResponsive.sp(context, 12, minScale: 0.92, maxScale: 1.12),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// -- wedding planner card
class _WeddingPlannerCard extends StatelessWidget {
  const _WeddingPlannerCard();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double cardHeight = (constraints.maxWidth * 0.40)
            .clamp(DeviceResponsive.h(context, 144), DeviceResponsive.h(context, 198))
            .toDouble();
        final int descriptionLines = constraints.maxWidth < 380 ? 4 : 5;
        return SizedBox(
          width: double.infinity,
          height: cardHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    DeviceResponsive.w(context, 14),
                    DeviceResponsive.h(context, 12),
                    DeviceResponsive.w(context, 14),
                    DeviceResponsive.h(context, 12),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6C9CF),
                    borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 56,
                        child: _PromoTextContent(
                          title: AppStrings.dashboardWeddingPlannerTitle,
                          description: AppStrings.dashboardWeddingPlannerDescription,
                          ctaText: AppStrings.dashboardWeddingPlannerCta,
                          descriptionLines: descriptionLines,
                          titleStyle: TextStyle(
                            color: AppColors.primary,
                            fontSize: DeviceResponsive.sp(context, 14, minScale: 0.92, maxScale: 1.12),
                            fontWeight: FontWeight.w500,
                          ),
                          descriptionStyle: TextStyle(
                            color: const Color(0xFF564A4D),
                            fontSize: DeviceResponsive.sp(context, 9.5, minScale: 0.92, maxScale: 1.12),
                            height: 1.22,
                          ),
                          ctaStyle: TextStyle(
                            color: AppColors.primary,
                            fontSize: DeviceResponsive.sp(context, 12, minScale: 0.92, maxScale: 1.1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(flex: 44),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: -(constraints.maxWidth * 0.03),
                bottom: -(cardHeight * 0.02),
                child: IgnorePointer(
                  child: Image.asset(
                    AppImages.couples,
                    width: constraints.maxWidth * 0.50,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _KidsWoodrowCard extends StatelessWidget {
  const _KidsWoodrowCard();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double cardHeight = (constraints.maxWidth * 0.42)
            .clamp(DeviceResponsive.h(context, 148), DeviceResponsive.h(context, 206))
            .toDouble();
        final int descriptionLines = constraints.maxWidth < 380 ? 4 : 5;
        return SizedBox(
          width: double.infinity,
          height: cardHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    DeviceResponsive.w(context, 14),
                    DeviceResponsive.h(context, 12),
                    DeviceResponsive.w(context, 14),
                    DeviceResponsive.h(context, 12),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFADE2AA),
                    borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 58,
                        child: _PromoTextContent(
                          title: AppStrings.dashboardKidsCollectionTitle,
                          description: AppStrings.dashboardKidsCollectionDescription,
                          ctaText: AppStrings.dashboardKidsCollectionCta,
                          descriptionLines: descriptionLines,
                          titleStyle: TextStyle(
                            color: const Color(0xFF21492B),
                            fontSize: DeviceResponsive.sp(context, 14, minScale: 0.92, maxScale: 1.12),
                            fontWeight: FontWeight.w500,
                          ),
                          descriptionStyle: TextStyle(
                            color: const Color(0xFF34573E),
                            fontSize: DeviceResponsive.sp(context, 9.5, minScale: 0.92, maxScale: 1.12),
                            height: 1.22,
                          ),
                          ctaStyle: TextStyle(
                            color: const Color(0xFF1E5A34),
                            fontSize: DeviceResponsive.sp(context, 12, minScale: 0.92, maxScale: 1.1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(flex: 42),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: -(constraints.maxWidth * 0.03),
                bottom: -(cardHeight * 0.12),
                child: IgnorePointer(
                  child: Image.asset(
                    AppImages.kids,
                    width: constraints.maxWidth * 0.42,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WhyChooseOnesoffCard extends StatelessWidget {
  const _WhyChooseOnesoffCard();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double cardHeight = (constraints.maxWidth * 0.46)
            .clamp(DeviceResponsive.h(context, 168), DeviceResponsive.h(context, 226))
            .toDouble();
        final int descriptionLines = constraints.maxWidth < 380 ? 4 : 5;
        return SizedBox(
          width: double.infinity,
          height: cardHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    DeviceResponsive.w(context, 14),
                    DeviceResponsive.h(context, 12),
                    DeviceResponsive.w(context, 14),
                    DeviceResponsive.h(context, 12),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3D39A),
                    borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 14)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 60,
                        child: _PromoTextContent(
                          title: AppStrings.dashboardWhyChooseTitle,
                          description: AppStrings.dashboardWhyChooseDescription,
                          ctaText: AppStrings.dashboardWhyChooseCta,
                          descriptionLines: descriptionLines,
                          titleStyle: TextStyle(
                            color: const Color(0xFF111111),
                            fontSize: DeviceResponsive.sp(context, 14, minScale: 0.92, maxScale: 1.12),
                            fontWeight: FontWeight.w500,
                          ),
                          descriptionStyle: TextStyle(
                            color: const Color(0xFF362E25),
                            fontSize: DeviceResponsive.sp(context, 9.5, minScale: 0.92, maxScale: 1.12),
                            height: 1.25,
                          ),
                          ctaStyle: TextStyle(
                            color: AppColors.primary,
                            fontSize: DeviceResponsive.sp(context, 12, minScale: 0.92, maxScale: 1.12),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(flex: 40),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: -(constraints.maxWidth * 0.04),
                top: -(cardHeight * 0.15),
                child: IgnorePointer(
                  child: Image.asset(
                    AppImages.stichMachine,
                    width: constraints.maxWidth * 0.50,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PromoTextContent extends StatelessWidget {
  const _PromoTextContent({
    required this.title,
    required this.description,
    required this.ctaText,
    required this.descriptionLines,
    required this.titleStyle,
    required this.descriptionStyle,
    required this.ctaStyle,
  });

  final String title;
  final String description;
  final String ctaText;
  final int descriptionLines;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;
  final TextStyle ctaStyle;

  @override
  Widget build(BuildContext context) {
    final double gap = DeviceResponsive.fluid(context, min: 3, max: 7);
    final double buttonHeight = DeviceResponsive.fluid(context, min: 30, max: 38);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _AdaptiveText(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          minFontScale: 0.88,
          style: titleStyle,
        ),
        SizedBox(height: gap),
        Expanded(
          child: _AdaptiveText(
            description,
            maxLines: descriptionLines,
            overflow: TextOverflow.ellipsis,
            minFontScale: 0.82,
            style: descriptionStyle,
          ),
        ),
        SizedBox(height: gap),
        Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: buttonHeight),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: DeviceResponsive.w(context, 10),
            vertical: DeviceResponsive.h(context, 6),
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFDFDFD),
            borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
          ),
          child: _AdaptiveText(
            ctaText,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            minFontScale: 0.90,
            softWrap: false,
            style: ctaStyle,
          ),
        ),
      ],
    );
  }
}

class _AdaptiveText extends StatelessWidget {
  const _AdaptiveText(
    this.text, {
    required this.style,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.minFontScale = 0.86,
    this.softWrap = true,
  });

  final String text;
  final TextStyle style;
  final int maxLines;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final double minFontScale;
  final bool softWrap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (!constraints.hasBoundedWidth) {
          return Text(
            text,
            style: style,
            maxLines: maxLines,
            overflow: overflow,
            textAlign: textAlign,
            softWrap: softWrap,
          );
        }

        final TextDirection direction = Directionality.of(context);
        final TextScaler scaler = MediaQuery.textScalerOf(context);
        final double baseSize = (style.fontSize ?? 14).toDouble();

        double low = baseSize * minFontScale;
        double high = baseSize;
        double best = low;

        for (int i = 0; i < 8; i++) {
          final double mid = (low + high) / 2;
          final TextPainter painter = TextPainter(
            text: TextSpan(
              text: text,
              style: style.copyWith(fontSize: mid),
            ),
            maxLines: maxLines,
            textDirection: direction,
            textScaler: scaler,
          )..layout(maxWidth: constraints.maxWidth);

          if (!painter.didExceedMaxLines) {
            best = mid;
            low = mid;
          } else {
            high = mid;
          }
        }

        return Text(
          text,
          style: style.copyWith(fontSize: best),
          maxLines: maxLines,
          overflow: overflow,
          textAlign: textAlign,
          softWrap: softWrap,
        );
      },
    );
  }
}

class _DevScreenDiagnosticsOverlay extends StatelessWidget {
  const _DevScreenDiagnosticsOverlay();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double stripWidth = DeviceResponsive.w(context, 8);

    return Positioned.fill(
      child: IgnorePointer(
        ignoring: true,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: stripWidth,
                color: const Color.fromRGBO(0, 150, 136, 0.24),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: stripWidth,
                color: const Color.fromRGBO(103, 58, 183, 0.24),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: DeviceResponsive.h(context, 6)),
                  padding: EdgeInsets.symmetric(
                    horizontal: DeviceResponsive.w(context, 12),
                    vertical: DeviceResponsive.h(context, 6),
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(20, 20, 20, 0.72),
                    borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 20)),
                  ),
                  child: Text(
                    'DEBUG  W: ${size.width.toStringAsFixed(0)}  H: ${size.height.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: DeviceResponsive.sp(context, 11, minScale: 0.92, maxScale: 1.12),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardPlaceholder extends StatelessWidget {
  const _DashboardPlaceholder({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: DeviceResponsive.w(context, 24)),
          child: Text(
            '$title module is coming soon.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: DeviceResponsive.sp(context, 16, minScale: 0.92, maxScale: 1.14),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardBottomNav extends StatelessWidget {
  const _DashboardBottomNav({
    required this.selectedIndex,
    required this.items,
    required this.onTap,
  });

  final int selectedIndex;
  final List<_BottomNavItem> items;
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
              final _BottomNavItem item = items[index];
              final bool isSelected = index == selectedIndex;

              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: DeviceResponsive.h(context, 2)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if (item.assetIcon != null)
                          Image.asset(
                            item.assetIcon!,
                            width: DeviceResponsive.r(context, 18),
                            height: DeviceResponsive.r(context, 18),
                            color: isSelected ? AppColors.primary : const Color(0xFF50545D),
                          )
                        else
                          Icon(
                            item.icon,
                            color: isSelected ? AppColors.primary : const Color(0xFF50545D),
                            size: DeviceResponsive.r(context, 20),
                          ),
                        SizedBox(height: DeviceResponsive.h(context, 3)),
                        Text(
                          item.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isSelected ? AppColors.primary : const Color(0xFF50545D),
                            fontSize: DeviceResponsive.sp(context, 11, minScale: 0.92, maxScale: 1.12),
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
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

class _BottomNavItem {
  const _BottomNavItem({
    required this.label,
    this.icon,
    this.assetIcon,
  });

  final String label;
  final IconData? icon;
  final String? assetIcon;
}
