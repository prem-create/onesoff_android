import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';
import 'package:onesoff/app/modules/seller/tabs/sellerEarnings_tab/getx/controllers/seller_earnings_controller.dart';

class TransactionDetailsSection extends GetView<SellerEarningsController> {
  const TransactionDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          DeviceResponsive.w(context, 16),
          DeviceResponsive.h(context, 16),
          DeviceResponsive.w(context, 16),
          0,
        ),
        child: const _TransactionDetailsLayout(),
      ),
    );
  }
}

class _TransactionDetailsLayout extends StatelessWidget {
  const _TransactionDetailsLayout();

  @override
  Widget build(BuildContext context) {
    final SellerEarningsController controller =
        Get.find<SellerEarningsController>();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 15),
        vertical: DeviceResponsive.h(context, 19),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: const Color(0xFFE0E2E7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppStrings.sellerTransactionDetailsTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: DeviceResponsive.sp(context, 18, minScale: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 4)),
          Text(
            AppStrings.sellerTransactionDetailsSubtitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: DeviceResponsive.sp(context, 10, minScale: 0.88),
              height: 1.25,
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 8)),
          const Divider(height: 1),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          const _SettlementHistoryHeader(),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          Column(
            children: controller.transactionDetails
                .map(
                  (SellerTransactionDetailItem item) =>
                      _SettlementHistoryCard(item: item),
                )
                .toList(growable: false),
          ),
          SizedBox(height: DeviceResponsive.h(context, 4)),
          const _SelectedOrderBreakdown(),
        ],
      ),
    );
  }
}

class _SettlementHistoryHeader extends StatelessWidget {
  const _SettlementHistoryHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.attach_money_rounded,
          color: AppColors.primary,
          size: DeviceResponsive.r(context, 18),
        ),
        SizedBox(width: DeviceResponsive.w(context, 6)),
        Expanded(
          child: Text(
            AppStrings.sellerTransactionDetailsHistoryTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: DeviceResponsive.sp(context, 14, minScale: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _SettlementHistoryCard extends StatelessWidget {
  const _SettlementHistoryCard({required this.item});

  final SellerTransactionDetailItem item;

  @override
  Widget build(BuildContext context) {
    final _TransactionStatusStyle statusStyle =
        _TransactionStatusStyle.fromStatus(item.status);

    return Container(
      margin: EdgeInsets.only(bottom: DeviceResponsive.h(context, 10)),
      padding: EdgeInsets.all(DeviceResponsive.r(context, 8)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
        border: Border.all(color: const Color(0xFFD5D8DF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  item.settlementId,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                ),
              ),
              SizedBox(width: DeviceResponsive.w(context, 8)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: DeviceResponsive.w(context, 8),
                  vertical: DeviceResponsive.h(context, 5),
                ),
                decoration: BoxDecoration(
                  color: statusStyle.backgroundColor,
                  border: Border.all(color: statusStyle.borderColor),
                  borderRadius: BorderRadius.circular(
                    DeviceResponsive.r(context, 10),
                  ),
                ),
                child: Text(
                  item.status,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: statusStyle.textColor,
                    fontSize: DeviceResponsive.sp(
                      context,
                      10,
                      minScale: 0.86,
                      maxScale: 1.08,
                    ),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: DeviceResponsive.h(context, 4)),
          Text(
            item.processedDate,
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
            item.amount,
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
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: DeviceResponsive.w(context, 8),
                    vertical: DeviceResponsive.h(context, 5),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withAlpha(20),
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(
                      DeviceResponsive.r(context, 10),
                    ),
                  ),
                  child: Text(
                    item.period,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: DeviceResponsive.sp(
                        context,
                        10,
                        minScale: 0.86,
                        maxScale: 1.08,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: DeviceResponsive.w(context, 8)),
              _SettlementViewButton(onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _SelectedOrderBreakdown extends StatelessWidget {
  const _SelectedOrderBreakdown();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 12),
        vertical: DeviceResponsive.h(context, 14),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
        border: Border.all(color: const Color(0xFFD5D8DF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SelectedOrderBreakdownHeader(),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          const _NoOrderSelectedCard(),
        ],
      ),
    );
  }
}

class _SelectedOrderBreakdownHeader extends StatelessWidget {
  const _SelectedOrderBreakdownHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.attach_money_rounded,
          color: AppColors.primary,
          size: DeviceResponsive.r(context, 18),
        ),
        SizedBox(width: DeviceResponsive.w(context, 6)),
        Expanded(
          child: Text(
            AppStrings.sellerTransactionDetailsSelectedOrderTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: DeviceResponsive.sp(context, 14, minScale: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _NoOrderSelectedCard extends StatelessWidget {
  const _NoOrderSelectedCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 16),
        vertical: DeviceResponsive.h(context, 24),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
        border: Border.all(color: const Color(0xFFD5D8DF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.currency_rupee_rounded,
            color: AppColors.primary,
            size: DeviceResponsive.r(context, 30),
          ),
          SizedBox(height: DeviceResponsive.h(context, 8)),
          Text(
            AppStrings.sellerTransactionDetailsNoOrderSelectedTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: DeviceResponsive.sp(context, 14, minScale: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 4)),
          Text(
            AppStrings.sellerTransactionDetailsNoOrderSelectedSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: DeviceResponsive.sp(context, 11, minScale: 0.9),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettlementViewButton extends StatelessWidget {
  const _SettlementViewButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceResponsive.h(context, 32),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          Icons.visibility_outlined,
          size: DeviceResponsive.r(context, 14),
        ),
        label: Text(
          AppStrings.sellerTransactionDetailsViewAction,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: DeviceResponsive.w(context, 10),
          ),
          textStyle: TextStyle(
            fontSize: DeviceResponsive.sp(context, 11, minScale: 0.86),
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 8)),
          ),
        ),
      ),
    );
  }
}

class _TransactionStatusStyle {
  const _TransactionStatusStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  factory _TransactionStatusStyle.fromStatus(String status) {
    final String normalizedStatus = status.trim().toLowerCase();

    if (normalizedStatus ==
        AppStrings.sellerTransactionDetailsStatusPaid.toLowerCase()) {
      return _TransactionStatusStyle._fromColor(Colors.green);
    }

    return _TransactionStatusStyle._fromColor(Colors.orange);
  }

  factory _TransactionStatusStyle._fromColor(Color color) {
    return _TransactionStatusStyle(
      backgroundColor: color.withAlpha(20),
      borderColor: color,
      textColor: color,
    );
  }
}
