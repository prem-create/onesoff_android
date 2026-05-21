import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';
import 'package:onesoff/app/modules/seller/tabs/sellerEarnings_tab/view/earningSection.dart';
import 'package:onesoff/app/modules/seller/tabs/sellerEarnings_tab/view/transactionDetailsSection.dart';

import '../getx/controllers/seller_earnings_controller.dart';

class SellerEarningsTab extends GetView<SellerEarningsController> {
  const SellerEarningsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Container(
            padding: EdgeInsets.all(DeviceResponsive.r(context, 4)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                DeviceResponsive.r(context, 8),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.setEarningsSelected(true),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: controller.isEarningsSelected.value
                          ? AppColors.primary
                          : Colors.grey,
                      minimumSize: Size.fromHeight(
                        DeviceResponsive.h(context, 42),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          DeviceResponsive.r(context, 8),
                        ),
                      ),
                    ),
                    child: Text(
                      'Earnings',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: DeviceResponsive.sp(
                          context,
                          13,
                          minScale: 0.9,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.setEarningsSelected(false),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: controller.isEarningsSelected.value
                          ? Colors.grey
                          : AppColors.primary,
                      minimumSize: Size.fromHeight(
                        DeviceResponsive.h(context, 42),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          DeviceResponsive.r(context, 8),
                        ),
                      ),
                    ),
                    child: Text(
                      'Transaction Details',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: DeviceResponsive.sp(
                          context,
                          13,
                          minScale: 0.9,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        controller.isEarningsSelected.value
            ? Expanded(child: const EarningSection())
            : TransactionDetailsSection(),
      ],
    );
  }
}
