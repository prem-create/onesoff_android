import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appImages.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';

class SellerProductsController extends GetxController {
  final List<SellerMetricItem> metrics = const <SellerMetricItem>[
    SellerMetricItem(
      label: AppStrings.sellerProductTotalOutfits,
      value: AppStrings.sellerProductTotalOutfitsValue,
    ),
    SellerMetricItem(
      label: AppStrings.sellerProductLiveOutfits,
      value: AppStrings.sellerProductLiveOutfitsValue,
    ),
    SellerMetricItem(
      label: AppStrings.sellerProductPendingApproval,
      value: AppStrings.sellerProductPendingApprovalValue,
    ),
  ];

  final List<SellerProductItem> products = const <SellerProductItem>[
    SellerProductItem(
      image: AppImages.mensWear,
      title: "Bridal lehenga - Rose Gold with hosary.",
      productCode: "Product code : RAA-808",
      price: null,
      message: "Your product is yet to be reviewed.",
      status: "Pending Approval",
    ),

    SellerProductItem(
      image: AppImages.mensWear,
      title: "Bridal Lehenga - Rose Gold with hosary.",
      productCode: "Product code : RAA-808",
      price: null,
      message:
          "Your product is approved. Please take it to the nearest store for physical verification.",
      status: "Approved",
    ),

    SellerProductItem(
      image: AppImages.mensWear,
      title: "Bridal Lehenga - Rose Gold with hosary.",
      productCode: "Product code : RAA-808",
      price: null,
      message:
          "Physical verification done. Review the final price and confirm.",
      status: "Approved",
    ),

    SellerProductItem(
      image: AppImages.mensWear,
      title: "Bridal Lehenga - Rose Gold with hosary.",
      productCode: "Product code : RAA-808",
      price: "Price : Rs.3999/day",
      message: "Your product is live and available for rental.",
      status: "Live",
    ),

    SellerProductItem(
      image: AppImages.mensWear,
      title: "Bridal Lehenga - Rose Gold with hosary.",
      productCode: "Product code : RAA-808",
      price: "Price : Rs.3999/day",
      message: "Withdrawal request sent. Waiting for admin approval.",
      status: "Requested",
    ),

    SellerProductItem(
      image: AppImages.mensWear,
      title: "Bridal Lehenga - Rose Gold with hosary.",
      productCode: "Product code : RAA-808",
      price: "Price : Rs.3999/day",
      message: "Your product is yet to be reviewed.",
      status: "Withdrawal",
    ),

    SellerProductItem(
      image: AppImages.mensWear,
      title: "Bridal Lehenga - Rose Gold with hosary.",
      productCode: "Product code : RAA-808",
      price: "Price : Rs.3999/day",
      message: "Your product request has been rejected.",
      status: "Rejected",
    ),
  ];
}

class SellerMetricItem {
  const SellerMetricItem({required this.label, required this.value});

  final String label;
  final String value;
}

class SellerProductItem {
  const SellerProductItem({
    required this.image,
    required this.title,
    required this.productCode,
    required this.price,
    required this.message,
    required this.status,
  });

  final String image;
  final String title;
  final String productCode;
  final String? price;
  final String message;
  final String status;
}
