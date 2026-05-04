
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/appRoutes.dart';
import '../../../utils/deviceConstants/appColors.dart';
import '../../../utils/deviceConstants/appImages.dart';
import '../../../utils/deviceUtility/deviceResponsive.dart';
import '../home/getx/customer_home_controller.dart';

class CustomerProductDetailsScreen extends StatefulWidget {
  const CustomerProductDetailsScreen({super.key});

  @override
  State<CustomerProductDetailsScreen> createState() => _CustomerProductDetailsScreenState();
}

class _CustomerProductDetailsScreenState extends State<CustomerProductDetailsScreen> {
  int selectedDays = 3;
  String selectedSize = 'S';
  int selectedGalleryIndex = 0;
  bool detailsExpanded = true;
  bool reviewsExpanded = true;

  DashboardProductItem get product {
    final Object? args = Get.arguments;
    if (args is DashboardProductItem) {
      return args;
    }
    return const DashboardProductItem(
      image: AppImages.mensWear,
      title: 'Bridal Lehenga - Rose Gold with hosary.',
      subtitle: 'Deep maroon lehenga with zari detailing and comfortable lining.',
      discount: '(10% OFF)',
      price: 'Rs.3999/day',
      tag1: '4.9',
      tag2: 'Most Booked',
    );
  }

  List<DashboardProductItem> get recommended {
    if (Get.isRegistered<CustomerHomeController>()) {
      return Get.find<CustomerHomeController>().searchableProducts;
    }
    return <DashboardProductItem>[product, product, product];
  }

  List<String> get galleryImages => <String>[
        product.image,
        AppImages.womensWear,
        AppImages.jewelry,
        AppImages.mensWear,
      ];

  @override
  Widget build(BuildContext context) {
    final List<String> images = galleryImages;
    final int safeIndex = selectedGalleryIndex.clamp(0, images.length - 1).toInt();
    final String heroImage = images[safeIndex];
    final double heroHeight = (MediaQuery.sizeOf(context).width * 0.98)
        .clamp(DeviceResponsive.h(context, 280), DeviceResponsive.h(context, 372))
        .toDouble();

    return Scaffold(
      backgroundColor: AppColors.dashboardSurface,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _hero(context, heroHeight, heroImage, images, safeIndex),
            Padding(
              padding: EdgeInsets.fromLTRB(
                DeviceResponsive.w(context, 12),
                DeviceResponsive.h(context, 10),
                DeviceResponsive.w(context, 12),
                DeviceResponsive.h(context, 14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _RatingTag(rating: product.tag1),
                      SizedBox(width: DeviceResponsive.w(context, 6)),
                      _PillTag(text: product.tag2, color: _tagColor(product.tag2)),
                      const Spacer(),
                      Text(
                        'Product code : RAA-808',
                        style: TextStyle(
                          color: const Color(0xFF858A93),
                          fontSize: DeviceResponsive.sp(context, 10, minScale: 0.84, maxScale: 1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: DeviceResponsive.h(context, 6)),
                  Text(
                    product.title,
                    style: TextStyle(
                      color: const Color(0xFF23262A),
                      fontSize: DeviceResponsive.sp(context, 19, minScale: 0.84, maxScale: 1),
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: DeviceResponsive.h(context, 4)),
                  Text(
                    'New Latest Embroidery Lehenga Choli With Embroidery Dupatta '
                    '(Separate Blouse Piece, Without Stitch).',
                    style: TextStyle(
                      color: const Color(0xFF666B74),
                      fontSize: DeviceResponsive.sp(context, 14, minScale: 0.84, maxScale: 1),
                      height: 1.22,
                    ),
                  ),
                  SizedBox(height: DeviceResponsive.h(context, 2)),
                  Text(
                    'Shop by: Radhika fashion international',
                    style: TextStyle(
                      color: const Color(0xFF848992),
                      fontSize: DeviceResponsive.sp(context, 11.5, minScale: 0.84, maxScale: 1),
                    ),
                  ),
                  SizedBox(height: DeviceResponsive.h(context, 10)),
                  _priceSection(context),
                  SizedBox(height: DeviceResponsive.h(context, 10)),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: const BorderSide(color: AppColors.primary),
                            minimumSize: Size.fromHeight(DeviceResponsive.h(context, 42)),
                          ),
                          child: const Text('Add to Cart'),
                        ),
                      ),
                      SizedBox(width: DeviceResponsive.w(context, 10)),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            minimumSize: Size.fromHeight(DeviceResponsive.h(context, 42)),
                          ),
                          child: const Text('Rent it now'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: DeviceResponsive.h(context, 8)),
                  Wrap(
                    spacing: DeviceResponsive.w(context, 6),
                    runSpacing: DeviceResponsive.h(context, 6),
                    children: const <Widget>[
                      _FeatureBadge(icon: AppImages.measuring_tape, text: 'Custom Fittings'),
                      _FeatureBadge(icon: AppImages.refundable_cash, text: 'Refundable Deposit'),
                      _FeatureBadge(icon: AppImages.delivery, text: 'Delivery Available'),
                    ],
                  ),
                  SizedBox(height: DeviceResponsive.h(context, 10)),
                  _rentalBlock(context),
                  SizedBox(height: DeviceResponsive.h(context, 10)),
                  _sizeTable(context),
                  SizedBox(height: DeviceResponsive.h(context, 10)),
                  _trialCard(context),
                  SizedBox(height: DeviceResponsive.h(context, 10)),
                  _expandable(
                    context,
                    title: 'Product Details',
                    expanded: detailsExpanded,
                    onTap: () => setState(() => detailsExpanded = !detailsExpanded),
                    child: _productDetailsBody(context),
                  ),
                  SizedBox(height: DeviceResponsive.h(context, 10)),
                  _VendorInfoCard(productImage: heroImage),
                  SizedBox(height: DeviceResponsive.h(context, 10)),
                  _expandable(
                    context,
                    title: 'Product Reviews',
                    expanded: reviewsExpanded,
                    onTap: () => setState(() => reviewsExpanded = !reviewsExpanded),
                    child: Column(
                      children: const <Widget>[
                        _ReviewCard(
                          name: 'Priya S.',
                          date: 'Mar 2026',
                          review: 'Absolutely stunning! Got so many compliments at my wedding.',
                        ),
                        SizedBox(height: 10),
                        _ReviewCard(
                          name: 'Priya S.',
                          date: 'Mar 2026',
                          review: 'Absolutely stunning! Got so many compliments at my wedding.',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: DeviceResponsive.h(context, 12)),
                  Text(
                    'Recommended products',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: DeviceResponsive.sp(context, 18, minScale: 0.84, maxScale: 1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: DeviceResponsive.h(context, 2)),
                  Text(
                    'Explore similar items that match your style',
                    style: TextStyle(
                      color: const Color(0xFF7F848D),
                      fontSize: DeviceResponsive.sp(context, 12, minScale: 0.84, maxScale: 1),
                    ),
                  ),
                  SizedBox(height: DeviceResponsive.h(context, 8)),
                  SizedBox(
                    height: DeviceResponsive.h(context, 280),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: recommended.length >= 3 ? 3 : recommended.length,
                      separatorBuilder: (_, __) => SizedBox(width: DeviceResponsive.w(context, 8)),
                      itemBuilder: (_, int index) => _RecommendedProductCard(product: recommended[index]),
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

  Widget _hero(
    BuildContext context,
    double heroHeight,
    String heroImage,
    List<String> images,
    int safeIndex,
  ) {
    return SizedBox(
      height: heroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(heroImage, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withOpacity(0.06),
                  Colors.black.withOpacity(0.02),
                  Colors.black.withOpacity(0.30),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: DeviceResponsive.w(context, 12),
                  vertical: DeviceResponsive.h(context, 10),
                ),
                child: Row(
                  children: <Widget>[
                    _topBtn(context, Icons.arrow_back_ios_new_rounded, Get.back),
                    const Spacer(),
                    _topBtn(context, Icons.favorite_border_rounded, () {}),
                    SizedBox(width: DeviceResponsive.w(context, 8)),
                    _topBtn(context, Icons.share_outlined, () {}),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: DeviceResponsive.h(context, 8)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: DeviceResponsive.w(context, 6)),
                child: Row(
                  children: List<Widget>.generate(images.length, (int index) {
                    final bool selected = index == safeIndex;
                    return InkWell(
                      onTap: () => setState(() => selectedGalleryIndex = index),
                      borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 9)),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: DeviceResponsive.w(context, 58),
                        height: DeviceResponsive.w(context, 58),
                        margin: EdgeInsets.symmetric(horizontal: DeviceResponsive.w(context, 4)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 9)),
                          border: Border.all(
                            color: selected ? AppColors.primary : const Color(0xFFD7DAE0),
                            width: selected ? 1.6 : 1,
                          ),
                          image: DecorationImage(
                            image: AssetImage(images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        LayoutBuilder(
          builder: (_, BoxConstraints c) {
            if (c.maxWidth < DeviceResponsive.w(context, 330)) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _priceLabel(context, 'Rental Price : Rs. 2,000/-', AppColors.primary, 20, FontWeight.w700),
                  SizedBox(height: DeviceResponsive.h(context, 4)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: _priceLabel(
                      context,
                      'Retail MRP : Rs. 25,000/-',
                      const Color(0xFF828791),
                      13,
                      FontWeight.w500,
                    ),
                  ),
                ],
              );
            }
            return Row(
              children: <Widget>[
                Expanded(
                  child: _priceLabel(
                    context,
                    'Rental Price : Rs. 2,000/-',
                    AppColors.primary,
                    20,
                    FontWeight.w700,
                  ),
                ),
                _priceLabel(context, 'Retail MRP : Rs. 25,000/-', const Color(0xFF828791), 13, FontWeight.w500),
              ],
            );
          },
        ),
        SizedBox(height: DeviceResponsive.h(context, 2)),
        Text(
          'Returnable Deposit (Inclusive of all taxes)',
          style: TextStyle(
            color: const Color(0xFF8A8F97),
            fontSize: DeviceResponsive.sp(context, 10.8, minScale: 0.84, maxScale: 1),
          ),
        ),
      ],
    );
  }

  Widget _rentalBlock(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(DeviceResponsive.w(context, 10)),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8FA),
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: const Color(0xFFE1E3E8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _blockTitle(context, 'Renting Period'),
          SizedBox(height: DeviceResponsive.h(context, 8)),
          Wrap(
            spacing: DeviceResponsive.w(context, 16),
            runSpacing: DeviceResponsive.h(context, 8),
            children: <Widget>[
              _dotOption(context, '3 Days', selectedDays == 3, () => setState(() => selectedDays = 3)),
              _dotOption(context, '5 Days', selectedDays == 5, () => setState(() => selectedDays = 5)),
              _dotOption(context, '7 Days', selectedDays == 7, () => setState(() => selectedDays = 7)),
              _dotOption(context, '10 Days', selectedDays == 10, () => setState(() => selectedDays = 10)),
            ],
          ),
          SizedBox(height: DeviceResponsive.h(context, 10)),
          Row(
            children: <Widget>[
              _blockTitle(context, 'Size Range'),
              const Spacer(),
              TextButton.icon(
                onPressed: () => _showSizeChartModal(context),
                icon: Image.asset(AppImages.ruler, width: DeviceResponsive.r(context, 16)),
                label: const Text('Size Chart'),
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
              ),
            ],
          ),
          Wrap(
            spacing: DeviceResponsive.w(context, 28),
            runSpacing: DeviceResponsive.h(context, 8),
            children: <Widget>[
              _dotOption(context, 'S', selectedSize == 'S', () => setState(() => selectedSize = 'S')),
              _dotOption(context, 'M', selectedSize == 'M', () => setState(() => selectedSize = 'M')),
              _dotOption(context, 'L', selectedSize == 'L', () => setState(() => selectedSize = 'L')),
              _dotOption(context, 'XL', selectedSize == 'XL', () => setState(() => selectedSize = 'XL')),
            ],
          ),
          SizedBox(height: DeviceResponsive.h(context, 10)),
          _blockTitle(context, 'Renting Timeline'),
          SizedBox(height: DeviceResponsive.h(context, 6)),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: DeviceResponsive.w(context, 10),
            runSpacing: DeviceResponsive.h(context, 6),
            children: <Widget>[
              Icon(Icons.calendar_month_outlined, size: DeviceResponsive.r(context, 20)),
              _timeline(context, '28-01-2026'),
              _timeline(context, 'to'),
              _timeline(context, '30-01-2026'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sizeTable(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
        border: Border.all(color: const Color(0xFFD5D8DE)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: DeviceResponsive.h(context, 6)),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(DeviceResponsive.r(context, 8))),
            ),
            child: Row(
              children: const <Widget>[
                _TableCell(title: 'Chest'),
                _TableCell(title: 'Waist'),
                _TableCell(title: 'Height'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: DeviceResponsive.h(context, 8)),
            child: Row(
              children: const <Widget>[
                _TableCell(title: '32-34', isValue: true),
                _TableCell(title: '26-28', isValue: true),
                _TableCell(title: '44', isValue: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _trialCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(DeviceResponsive.w(context, 10)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: const Color(0xFFD8DBE1)),
      ),
      child: LayoutBuilder(
        builder: (_, BoxConstraints c) {
          final Widget textContent = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _blockTitle(context, 'Trial Request'),
              SizedBox(height: DeviceResponsive.h(context, 4)),
              Text(
                'Request to try this item. If vendor accepts, you can trial on the request day or '
                'next day. Or directly book for rent.',
                style: TextStyle(
                  color: const Color(0xFF666B74),
                  fontSize: DeviceResponsive.sp(context, 13, minScale: 0.84, maxScale: 1),
                ),
              ),
            ],
          );
          if (c.maxWidth < DeviceResponsive.w(context, 340)) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                textContent,
                SizedBox(height: DeviceResponsive.h(context, 8)),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                    ),
                    child: const Text('Book trail now'),
                  ),
                ),
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: textContent),
              SizedBox(width: DeviceResponsive.w(context, 10)),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                ),
                child: const Text('Book trail now'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _productDetailsBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _subHeading(context, 'Specifications'),
        SizedBox(height: DeviceResponsive.h(context, 8)),
        const _DetailRow(label: 'Material composition', value: 'Silk'),
        const _DetailRow(label: 'Sleeve type', value: '3/4 Sleeve'),
        const _DetailRow(label: 'Length', value: 'Calf Length'),
        const _DetailRow(label: 'Neck style', value: 'Round Neck'),
        const _DetailRow(label: 'Pattern', value: 'Solid'),
        const _DetailRow(label: 'Style', value: 'Anarkali', showDivider: false),
        SizedBox(height: DeviceResponsive.h(context, 12)),
        _subHeading(context, 'About this item'),
        SizedBox(height: DeviceResponsive.h(context, 8)),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text:
                    'Elegant Design: Premium women\'s kurta set with pant and dupatta, perfect for festivals, weddings, parties, and daily wear.',
                style: TextStyle(
                  color: const Color(0xFF31353C),
                  fontSize: DeviceResponsive.sp(context, 13.2, minScale: 0.84, maxScale: 1),
                  height: 1.34,
                ),
              ),
              TextSpan(
                text: '  Read more',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: DeviceResponsive.sp(context, 13.2, minScale: 0.84, maxScale: 1),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: DeviceResponsive.h(context, 14)),
        _subHeading(context, 'Additional Information'),
        SizedBox(height: DeviceResponsive.h(context, 8)),
        const _DetailRow(label: 'Manufacturer', value: 'Klosia Empire, Klosia Empire'),
        const _DetailRow(label: 'Packer', value: 'Klosia Empire'),
        const _DetailRow(label: 'Item Weight', value: '300 g'),
        const _DetailRow(label: 'Item Dimensions LxWxH', value: '30 x 10 x 3 Centimeters'),
        const _DetailRow(label: 'Generic Name', value: 'Kurta Set', showDivider: false),
      ],
    );
  }

  Widget _subHeading(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        color: const Color(0xFF1A1E25),
        fontSize: DeviceResponsive.sp(context, 17, minScale: 0.84, maxScale: 1),
        fontWeight: FontWeight.w600,
      ),
    );
  }
  Widget _expandable(
    BuildContext context, {
    required String title,
    required bool expanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: const Color(0xFFD9DCE2)),
      ),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.vertical(top: Radius.circular(DeviceResponsive.r(context, 10))),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: DeviceResponsive.w(context, 12),
                vertical: DeviceResponsive.h(context, 10),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: const Color(0xFF25282D),
                        fontSize: DeviceResponsive.sp(context, 16, minScale: 0.84, maxScale: 1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    color: const Color(0xFF42464E),
                    size: DeviceResponsive.r(context, 24),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 180),
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: EdgeInsets.fromLTRB(
                DeviceResponsive.w(context, 12),
                DeviceResponsive.h(context, 2),
                DeviceResponsive.w(context, 12),
                DeviceResponsive.h(context, 10),
              ),
              child: child,
            ),
            crossFadeState: expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }

  Future<void> _showSizeChartModal(BuildContext context) async {
    final double maxHeight = MediaQuery.sizeOf(context).height * 0.82;
    await showDialog<void>(
      context: context,
      builder: (_) => Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: DeviceResponsive.w(context, 12),
          vertical: DeviceResponsive.h(context, 18),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
        ),
        child: SizedBox(
          height: maxHeight,
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
                    Expanded(
                      child: Text(
                        'Size Chart',
                        style: TextStyle(
                          color: const Color(0xFF101215),
                          fontSize: DeviceResponsive.sp(context, 34, minScale: 0.56, maxScale: 0.70),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Color(0xFFA3A7B0)),
                    ),
                  ],
                ),
                Divider(color: const Color(0xFFE0E3E8), height: DeviceResponsive.h(context, 16)),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Women Size Chart',
                          style: TextStyle(
                            color: const Color(0xFF181B20),
                            fontSize: DeviceResponsive.sp(context, 17, minScale: 0.84, maxScale: 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: DeviceResponsive.h(context, 12)),
                        Table(
                          border: TableBorder.all(color: const Color(0xFFD9DCE3)),
                          columnWidths: const <int, TableColumnWidth>{
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(1.8),
                            2: FlexColumnWidth(1.2),
                            3: FlexColumnWidth(1.2),
                          },
                          children: <TableRow>[
                            _sizeHeader(context, <String>['Size', 'Chest / Bust', 'Waist', 'Height']),
                            _sizeRow(context, <String>['S', '32-34', '26-28', '44']),
                            _sizeRow(context, <String>['M', '34-36', '28-30', '45']),
                            _sizeRow(context, <String>['L', '36-38', '30-32', '46']),
                            _sizeRow(context, <String>['XL', '38-40', '32-34', '47']),
                          ],
                        ),
                        SizedBox(height: DeviceResponsive.h(context, 14)),
                        Text(
                          'Disclaimer:',
                          style: TextStyle(
                            color: const Color(0xFF5C6068),
                            fontSize: DeviceResponsive.sp(context, 13.5, minScale: 0.84, maxScale: 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: DeviceResponsive.h(context, 6)),
                        _disclaimer(
                          context,
                          'The color of the outfit may vary slightly due to lighting and editing in images.',
                        ),
                        SizedBox(height: DeviceResponsive.h(context, 4)),
                        _disclaimer(context, 'Button shifting can be done for waist adjustments if needed.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow _sizeHeader(BuildContext context, List<String> cells) {
    return TableRow(
      decoration: const BoxDecoration(color: Color(0xFFF3E0E3)),
      children: cells
          .map(
            (String c) => Padding(
              padding: EdgeInsets.symmetric(
                vertical: DeviceResponsive.h(context, 8),
                horizontal: DeviceResponsive.w(context, 8),
              ),
              child: Text(
                c,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF111318),
                  fontWeight: FontWeight.w600,
                  fontSize: DeviceResponsive.sp(context, 13, minScale: 0.84, maxScale: 1),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  TableRow _sizeRow(BuildContext context, List<String> cells) {
    return TableRow(
      children: cells
          .map(
            (String c) => Padding(
              padding: EdgeInsets.symmetric(
                vertical: DeviceResponsive.h(context, 9),
                horizontal: DeviceResponsive.w(context, 8),
              ),
              child: Text(
                c,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF2A2D32),
                  fontSize: DeviceResponsive.sp(context, 12.5, minScale: 0.84, maxScale: 1),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _disclaimer(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: DeviceResponsive.h(context, 5),
            right: DeviceResponsive.w(context, 8),
            left: DeviceResponsive.w(context, 6),
          ),
          child: Container(
            width: DeviceResponsive.r(context, 4),
            height: DeviceResponsive.r(context, 4),
            decoration: const BoxDecoration(color: Color(0xFF7A7E86), shape: BoxShape.circle),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: const Color(0xFF6C7078),
              fontSize: DeviceResponsive.sp(context, 12.5, minScale: 0.84, maxScale: 1),
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _topBtn(BuildContext context, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
      child: Container(
        width: DeviceResponsive.r(context, 34),
        height: DeviceResponsive.r(context, 34),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.86),
          borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
        ),
        child: Icon(icon, color: AppColors.primary, size: DeviceResponsive.r(context, 18)),
      ),
    );
  }
  Widget _priceLabel(BuildContext context, String label, Color color, double size, FontWeight weight) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontWeight: weight,
              fontSize: DeviceResponsive.sp(context, size, minScale: 0.84, maxScale: 1),
            ),
          ),
        ),
        SizedBox(width: DeviceResponsive.w(context, 2)),
        Icon(Icons.info_outline, color: color.withOpacity(0.84), size: DeviceResponsive.r(context, 13)),
      ],
    );
  }

  Widget _blockTitle(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.primary,
        fontSize: DeviceResponsive.sp(context, 16, minScale: 0.84, maxScale: 1),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _timeline(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        color: const Color(0xFF5C6169),
        fontSize: DeviceResponsive.sp(context, 14, minScale: 0.84, maxScale: 1),
      ),
    );
  }

  Widget _dotOption(BuildContext context, String label, bool selected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: DeviceResponsive.r(context, 14),
            height: DeviceResponsive.r(context, 14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 1.2),
            ),
            child: selected
                ? Center(
                    child: Container(
                      width: DeviceResponsive.r(context, 7),
                      height: DeviceResponsive.r(context, 7),
                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                    ),
                  )
                : null,
          ),
          SizedBox(width: DeviceResponsive.w(context, 6)),
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF4E5259),
              fontSize: DeviceResponsive.sp(context, 13.5, minScale: 0.84, maxScale: 1),
            ),
          ),
        ],
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

class _FeatureBadge extends StatelessWidget {
  const _FeatureBadge({required this.icon, required this.text});
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 8),
        vertical: DeviceResponsive.h(context, 5),
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(icon, width: DeviceResponsive.r(context, 13)),
          SizedBox(width: DeviceResponsive.w(context, 4)),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: DeviceResponsive.sp(context, 11.5, minScale: 0.84, maxScale: 1),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  const _TableCell({required this.title, this.isValue = false});
  final String title;
  final bool isValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: isValue ? const Color(0xFF767B84) : Colors.white,
            fontSize: DeviceResponsive.sp(context, 13, minScale: 0.84, maxScale: 1),
            fontWeight: isValue ? FontWeight.w500 : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value, this.showDivider = true});
  final String label;
  final String value;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: DeviceResponsive.h(context, 8)),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: const Color(0xFF313640),
                    fontSize: DeviceResponsive.sp(context, 13, minScale: 0.84, maxScale: 1),
                  ),
                ),
              ),
              SizedBox(width: DeviceResponsive.w(context, 8)),
              Flexible(
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: const Color(0xFF10141B),
                    fontSize: DeviceResponsive.sp(context, 13.2, minScale: 0.84, maxScale: 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (showDivider)
            Padding(
              padding: EdgeInsets.only(top: DeviceResponsive.h(context, 8)),
              child: const Divider(height: 1, color: Color(0xFFE3E6EC)),
            ),
        ],
      ),
    );
  }
}
class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.name, required this.date, required this.review});
  final String name;
  final String date;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(DeviceResponsive.w(context, 12)),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F2EE),
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    color: const Color(0xFF2F1B16),
                    fontSize: DeviceResponsive.sp(context, 17, minScale: 0.84, maxScale: 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  color: const Color(0xFF9B8D84),
                  fontSize: DeviceResponsive.sp(context, 14, minScale: 0.84, maxScale: 1),
                ),
              ),
            ],
          ),
          SizedBox(height: DeviceResponsive.h(context, 6)),
          Row(
            children: List<Widget>.generate(
              5,
              (int _) => Padding(
                padding: EdgeInsets.only(right: DeviceResponsive.w(context, 2)),
                child: Icon(Icons.star_rounded, color: const Color(0xFFE8A423), size: DeviceResponsive.r(context, 24)),
              ),
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 6)),
          Text(
            review,
            style: TextStyle(
              color: const Color(0xFF5E504A),
              fontSize: DeviceResponsive.sp(context, 17, minScale: 0.78, maxScale: 1),
              height: 1.34,
            ),
          ),
        ],
      ),
    );
  }
}

class _VendorInfoCard extends StatelessWidget {
  const _VendorInfoCard({required this.productImage});
  final String productImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(DeviceResponsive.w(context, 10)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: const Color(0xFFD9DCE2)),
      ),
      child: Column(
        children: <Widget>[
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool compact = constraints.maxWidth < DeviceResponsive.w(context, 350);
              final Widget vendorInfo = Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      CircleAvatar(radius: DeviceResponsive.r(context, 20), backgroundImage: AssetImage(productImage)),
                      Positioned(
                        top: DeviceResponsive.h(context, -2),
                        right: DeviceResponsive.w(context, -2),
                        child: const _PartnerBadge(),
                      ),
                    ],
                  ),
                  SizedBox(width: DeviceResponsive.w(context, 8)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Radhika Fashion International',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xFF24272C),
                            fontSize: DeviceResponsive.sp(context, 16, minScale: 0.78, maxScale: 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Vijay Nagar, Indore M.P',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xFF757A82),
                            fontSize: DeviceResponsive.sp(context, 12, minScale: 0.84, maxScale: 1),
                          ),
                        ),
                        SizedBox(height: DeviceResponsive.h(context, 4)),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: DeviceResponsive.w(context, 8),
                            vertical: DeviceResponsive.h(context, 2),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6A226),
                            borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 999)),
                          ),
                          child: Text(
                            'Crown Legend',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: DeviceResponsive.sp(context, 10.5, minScale: 0.84, maxScale: 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );

              final Widget button = OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  padding: EdgeInsets.symmetric(horizontal: DeviceResponsive.w(context, 14)),
                ),
                child: const Text('View Shop'),
              );

              if (compact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    vendorInfo,
                    SizedBox(height: DeviceResponsive.h(context, 8)),
                    Align(alignment: Alignment.centerRight, child: button),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: vendorInfo),
                  SizedBox(width: DeviceResponsive.w(context, 8)),
                  button,
                ],
              );
            },
          ),
          SizedBox(height: DeviceResponsive.h(context, 8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const <Widget>[
              _VendorStat(value: '3.8', label: '9780 Ratings'),
              _VendorStat(value: '3.8K', label: 'Followers'),
              _VendorStat(value: '128', label: 'Products'),
            ],
          ),
        ],
      ),
    );
  }
}

class _VendorStat extends StatelessWidget {
  const _VendorStat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF3A3E45),
            fontSize: DeviceResponsive.sp(context, 13.5, minScale: 0.84, maxScale: 1),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: DeviceResponsive.h(context, 2)),
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF7A8088),
            fontSize: DeviceResponsive.sp(context, 11.5, minScale: 0.84, maxScale: 1),
          ),
        ),
      ],
    );
  }
}
class _RecommendedProductCard extends StatelessWidget {
  const _RecommendedProductCard({required this.product});
  final DashboardProductItem product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.customerProductDetails, arguments: product),
      borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
      child: Container(
        width: DeviceResponsive.w(context, 130),
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
                  Image.asset(product.image, fit: BoxFit.cover),
                  Positioned(left: DeviceResponsive.w(context, 4), top: DeviceResponsive.h(context, 4), child: const _PartnerBadge()),
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
                      child: Icon(Icons.favorite_border_rounded, size: DeviceResponsive.r(context, 10), color: const Color(0xFF7A7D83)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  DeviceResponsive.w(context, 5),
                  DeviceResponsive.h(context, 5),
                  DeviceResponsive.w(context, 5),
                  DeviceResponsive.h(context, 5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _RatingTag(rating: product.tag1),
                        SizedBox(width: DeviceResponsive.w(context, 2)),
                        Flexible(child: _PillTag(text: product.tag2, color: _tagColor(product.tag2))),
                      ],
                    ),
                    SizedBox(height: DeviceResponsive.h(context, 2)),
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color(0xFF26282C),
                        fontSize: DeviceResponsive.sp(context, 11, minScale: 0.84, maxScale: 1),
                        fontWeight: FontWeight.w500,
                        height: 1.15,
                      ),
                    ),
                    SizedBox(height: DeviceResponsive.h(context, 2)),
                    Expanded(
                      child: Text(
                        product.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xFF666B74),
                          fontSize: DeviceResponsive.sp(context, 8.8, minScale: 0.84, maxScale: 1),
                          height: 1.18,
                        ),
                      ),
                    ),
                    SizedBox(height: DeviceResponsive.h(context, 2)),
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
                    SizedBox(height: DeviceResponsive.h(context, 2)),
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
                        Icon(Icons.chevron_right_rounded, color: const Color(0xFF8A8D94), size: DeviceResponsive.r(context, 15)),
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

class _PartnerBadge extends StatelessWidget {
  const _PartnerBadge();

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
      child: Image.asset(AppImages.crown, fit: BoxFit.contain),
    );
  }
}

class _RatingTag extends StatelessWidget {
  const _RatingTag({required this.rating});
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DeviceResponsive.w(context, 2), vertical: DeviceResponsive.h(context, 1)),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2D30),
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.star_rounded, color: const Color(0xFFF8B336), size: DeviceResponsive.r(context, 8.5)),
          SizedBox(width: DeviceResponsive.w(context, 2)),
          Text(
            rating,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: TextStyle(
              color: Colors.white,
              fontSize: DeviceResponsive.sp(context, 7.8, minScale: 0.84, maxScale: 1),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _PillTag extends StatelessWidget {
  const _PillTag({required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DeviceResponsive.w(context, 5), vertical: DeviceResponsive.h(context, 2)),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 4))),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: TextStyle(
          color: Colors.white,
          fontSize: DeviceResponsive.sp(context, 8.4, minScale: 0.84, maxScale: 1),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
