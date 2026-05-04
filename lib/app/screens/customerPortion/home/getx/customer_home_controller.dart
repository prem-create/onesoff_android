import 'package:get/get.dart';

import '../../../../utils/deviceConstants/appImages.dart';

class CustomerHomeController extends GetxController {
  final RxInt selectedBottomTab = 0.obs;
  final RxInt selectedFeatureIndex = 0.obs;
  final RxInt selectedStoreCategoryIndex = 0.obs;
  final RxString selectedCity = 'Indore'.obs;

  final List<DashboardFeatureItem> features = const <DashboardFeatureItem>[
    DashboardFeatureItem(
      image: AppImages.banner1,
      title: 'Wedding collections',
      subtitle: 'Get all the featured Indian wedding collections.',
      badge: 'Most Booked',
    ),
    DashboardFeatureItem(
      image: AppImages.womensWear,
      title: 'Wedding collections',
      subtitle: 'Get all the featured Indian wedding collections.',
      badge: 'Most Booked',
    ),
    DashboardFeatureItem(
      image: AppImages.couples,
      title: 'Wedding collections',
      subtitle: 'Get all the featured Indian wedding collections.',
      badge: 'Most Booked',
    ),
    DashboardFeatureItem(
      image: AppImages.mensWear,
      title: 'Wedding collections',
      subtitle: 'Get all the featured Indian wedding collections.',
      badge: 'Most Booked',
    ),
    DashboardFeatureItem(
      image: AppImages.kids,
      title: 'Wedding collections',
      subtitle: 'Get all the featured Indian wedding collections.',
      badge: 'Most Booked',
    ),
    DashboardFeatureItem(
      image: AppImages.jewelry,
      title: 'Wedding collections',
      subtitle: 'Get all the featured Indian wedding collections.',
      badge: 'Most Booked',
    ),
  ];

  final List<DashboardCityItem> operationalCities = const <DashboardCityItem>[
    DashboardCityItem(name: 'Indore', image: AppImages.indore),
    DashboardCityItem(name: 'Delhi', image: AppImages.delhi),
    DashboardCityItem(name: 'Mumbai', image: AppImages.mumbai),
    DashboardCityItem(name: 'Jaipur', image: AppImages.jaipur),
    DashboardCityItem(name: 'Agra', image: AppImages.agra),
    DashboardCityItem(name: 'Ahmadabad', image: AppImages.ahmadabad),
  ];

  final List<DashboardQuickCategory> categories = const <DashboardQuickCategory>[
    DashboardQuickCategory(label: 'Lehengas', image: AppImages.womensWear),
    DashboardQuickCategory(label: 'Saree', image: AppImages.womensWear),
    DashboardQuickCategory(label: 'Sherwani', image: AppImages.mensWear),
    DashboardQuickCategory(label: 'Indo-western', image: AppImages.mensWear),
  ];

  final List<DashboardQuickCategory> events = const <DashboardQuickCategory>[
    DashboardQuickCategory(label: 'Haldi', image: AppImages.womensWear),
    DashboardQuickCategory(label: 'Mehndi', image: AppImages.womensWear),
    DashboardQuickCategory(label: 'Wedding', image: AppImages.couples),
    DashboardQuickCategory(label: 'Reception', image: AppImages.mensWear),
  ];

  final List<DashboardProductItem> personalizedProducts =
      _commonProducts;
  final List<DashboardProductItem> trendingProducts =
      _commonProducts;
  final List<DashboardProductItem> accessoriesProducts =
      _commonProducts;
  final List<DashboardProductItem> kidsProducts =
      _commonProducts;
  final List<DashboardQuickCategory> storeCategories = const <DashboardQuickCategory>[
    DashboardQuickCategory(label: 'Lehengas', image: AppImages.womensWear),
    DashboardQuickCategory(label: 'Sarees', image: AppImages.womensWear),
    DashboardQuickCategory(label: 'Gowns', image: AppImages.womensWear),
    DashboardQuickCategory(label: 'Anarkali', image: AppImages.womensWear),
    DashboardQuickCategory(label: 'Sherwani', image: AppImages.mensWear),
    DashboardQuickCategory(label: 'Indo-western', image: AppImages.mensWear),
  ];

  void setBottomTab(int index) {
    selectedBottomTab.value = index;
  }

  void setFeatureIndex(int index) {
    selectedFeatureIndex.value = index;
  }

  void setSelectedCity(String city) {
    selectedCity.value = city;
  }

  void setSelectedStoreCategory(int index) {
    selectedStoreCategoryIndex.value = index;
  }

  List<DashboardProductItem> get searchableProducts => _commonProducts;

  List<DashboardProductItem> get storeProducts => _commonProducts;

  static const List<DashboardProductItem> _commonProducts = <DashboardProductItem>[
    DashboardProductItem(
      image: AppImages.womensWear,
      title: 'Bridal Lehenga - Rose Gold with hosary.',
      subtitle: 'Deep maroon lehenga with zari detailing and comfortable lining.',
      discount: '(10% OFF)',
      price: 'Rs.3999/day',
      tag1: '4.9',
      tag2: 'Most Booked',
    ),
    DashboardProductItem(
      image: AppImages.jewelry,
      title: 'Bridal Lehenga - Rose Gold with hosary.',
      subtitle: 'Deep maroon lehenga with zari detailing and comfortable lining.',
      discount: '(10% OFF)',
      price: 'Rs.3999/day',
      tag1: '4.9',
      tag2: 'Popular',
    ),
    DashboardProductItem(
      image: AppImages.mensWear,
      title: 'Bridal Lehenga - Rose Gold with hosary.',
      subtitle: 'Deep maroon lehenga with zari detailing and comfortable lining.',
      discount: '(10% OFF)',
      price: 'Rs.3999/day',
      tag1: '4.9',
      tag2: 'New',
    ),
    DashboardProductItem(
      image: AppImages.womensWear,
      title: 'Bridal Lehenga - Rose Gold with hosary.',
      subtitle: 'Deep maroon lehenga with zari detailing and comfortable lining.',
      discount: '(10% OFF)',
      price: 'Rs.3999/day',
      tag1: '4.9',
      tag2: 'Most Booked',
    ),
    DashboardProductItem(
      image: AppImages.jewelry,
      title: 'Bridal Lehenga - Rose Gold with hosary.',
      subtitle: 'Deep maroon lehenga with zari detailing and comfortable lining.',
      discount: '(10% OFF)',
      price: 'Rs.3999/day',
      tag1: '4.9',
      tag2: 'Popular',
    ),
    DashboardProductItem(
      image: AppImages.mensWear,
      title: 'Bridal Lehenga - Rose Gold with hosary.',
      subtitle: 'Deep maroon lehenga with zari detailing and comfortable lining.',
      discount: '(10% OFF)',
      price: 'Rs.3999/day',
      tag1: '4.9',
      tag2: 'New',
    ),
  ];
}

class DashboardFeatureItem {
  const DashboardFeatureItem({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.badge,
  });

  final String image;
  final String title;
  final String subtitle;
  final String badge;
}

class DashboardCityItem {
  const DashboardCityItem({
    required this.name,
    required this.image,
  });

  final String name;
  final String image;
}

class DashboardQuickCategory {
  const DashboardQuickCategory({
    required this.label,
    required this.image,
  });

  final String label;
  final String image;
}

class DashboardProductItem {
  const DashboardProductItem({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.discount,
    required this.price,
    required this.tag1,
    required this.tag2,
  });

  final String image;
  final String title;
  final String subtitle;
  final String discount;
  final String price;
  final String tag1;
  final String tag2;
}
