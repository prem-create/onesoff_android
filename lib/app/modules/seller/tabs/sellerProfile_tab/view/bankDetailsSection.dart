import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';

import '../getx/controllers/seller_profile_controller.dart';

class BankDetailsSection extends GetView<SellerProfileController> {
  const BankDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: DeviceResponsive.h(context, 12)),
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 15),
        vertical: DeviceResponsive.h(context, 17),
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
            AppStrings.sellerProfileBankDetailsTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: DeviceResponsive.sp(context, 18, minScale: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          _BankDetailsFieldList(
            items: <_BankDetailsFieldItem>[
              _BankDetailsFieldItem(
                icon: Icons.account_circle_outlined,
                label: AppStrings.sellerProfileAccountHolderNameLabel,
                value: _valueOrDash(controller.accountHolderName.value),
              ),
              _BankDetailsFieldItem(
                icon: Icons.account_balance_outlined,
                label: AppStrings.sellerProfileBankAccountNumberLabel,
                value: _valueOrDash(controller.bankAccountNumber.value),
              ),
              _BankDetailsFieldItem(
                icon: Icons.confirmation_number_outlined,
                label: AppStrings.sellerProfileIfscCodeLabel,
                value: _valueOrDash(controller.ifscCode.value),
              ),
              _BankDetailsFieldItem(
                icon: Icons.payments_outlined,
                label: AppStrings.sellerProfileUpiIdLabel,
                value: _valueOrDash(controller.upiId.value),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _valueOrDash(String value) {
    return value.trim().isEmpty ? '-' : value;
  }
}

class _BankDetailsFieldList extends StatelessWidget {
  const _BankDetailsFieldList({required this.items});

  final List<_BankDetailsFieldItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 10)),
        border: Border.all(color: const Color(0xFFD5D8DF)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: List<Widget>.generate(items.length, (int index) {
          final _BankDetailsFieldItem item = items[index];

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _BankDetailsFieldTile(item: item),
              if (index != items.length - 1) const Divider(height: 1),
            ],
          );
        }),
      ),
    );
  }
}

class _BankDetailsFieldTile extends StatelessWidget {
  const _BankDetailsFieldTile({required this.item});

  final _BankDetailsFieldItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 12),
        vertical: DeviceResponsive.h(context, 4),
      ),
      leading: Icon(
        item.icon,
        color: AppColors.primary,
        size: DeviceResponsive.r(context, 20),
      ),
      title: Text(
        item.label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: DeviceResponsive.sp(context, 12.5, minScale: 0.9),
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        item.value,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: DeviceResponsive.sp(context, 11, minScale: 0.9),
          height: 1.25,
        ),
      ),
    );
  }
}

class _BankDetailsFieldItem {
  const _BankDetailsFieldItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}
