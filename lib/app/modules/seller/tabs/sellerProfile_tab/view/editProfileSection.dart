import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';

import '../getx/controllers/seller_profile_controller.dart';

class EditProfileSection extends GetView<SellerProfileController> {
  const EditProfileSection({super.key});

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
            AppStrings.sellerProfileEditTitle,
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
            AppStrings.sellerProfileEditSubtitle,
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
          const _ProfileSectionTitle(
            title: AppStrings.sellerProfilePersonalInfoTitle,
          ),
          SizedBox(height: DeviceResponsive.h(context, 10)),
          _ProfileInputList(
            items: <_ProfileInputItem>[
              _ProfileInputItem(
                icon: Icons.person_outline_rounded,
                label: AppStrings.sellerProfileOwnerNameLabel,
                value: controller.ownerName.value,
                onChanged: controller.updateOwnerName,
              ),
              _ProfileInputItem(
                icon: Icons.email_outlined,
                label: AppStrings.sellerProfileEmailLabel,
                value: controller.email.value,
                keyboardType: TextInputType.emailAddress,
                onChanged: controller.updateEmail,
              ),
              _ProfileInputItem(
                icon: Icons.phone_outlined,
                label: AppStrings.sellerProfilePhoneLabel,
                value: controller.phone.value,
                keyboardType: TextInputType.phone,
                onChanged: controller.updatePhone,
              ),
              _ProfileInputItem(
                icon: Icons.work_outline_rounded,
                label: AppStrings.sellerProfileOccupationLabel,
                value: controller.occupation.value,
                onChanged: controller.updateOccupation,
              ),
              _ProfileInputItem(
                icon: Icons.location_city_outlined,
                label: AppStrings.sellerProfileCityLabel,
                value: controller.city.value,
                onChanged: controller.updateCity,
              ),
              _ProfileInputItem(
                icon: Icons.map_outlined,
                label: AppStrings.sellerProfileStateLabel,
                value: controller.state.value,
                onChanged: controller.updateState,
              ),
              _ProfileInputItem(
                icon: Icons.pin_drop_outlined,
                label: AppStrings.sellerProfilePincodeLabel,
                value: controller.pincode.value,
                keyboardType: TextInputType.number,
                onChanged: controller.updatePincode,
              ),
              _ProfileInputItem(
                icon: Icons.storefront_outlined,
                label: AppStrings.sellerProfileShopNameLabel,
                value: controller.shopName.value,
                onChanged: controller.updateShopName,
              ),
              _ProfileInputItem(
                icon: Icons.home_outlined,
                label: AppStrings.sellerProfileAddressLabel,
                value: controller.address.value,
                maxLines: 3,
                onChanged: controller.updateAddress,
              ),
            ],
          ),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          const Divider(height: 1),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          const _ProfileSectionTitle(
            title: AppStrings.sellerProfileBankDetailsTitle,
          ),
          SizedBox(height: DeviceResponsive.h(context, 10)),
          _ProfileInputList(
            items: <_ProfileInputItem>[
              _ProfileInputItem(
                icon: Icons.account_circle_outlined,
                label: AppStrings.sellerProfileAccountHolderNameLabel,
                value: controller.accountHolderName.value,
                onChanged: controller.updateAccountHolderName,
              ),
              _ProfileInputItem(
                icon: Icons.account_balance_outlined,
                label: AppStrings.sellerProfileBankAccountNumberLabel,
                value: controller.bankAccountNumber.value,
                keyboardType: TextInputType.number,
                onChanged: controller.updateBankAccountNumber,
              ),
              _ProfileInputItem(
                icon: Icons.confirmation_number_outlined,
                label: AppStrings.sellerProfileIfscCodeLabel,
                value: controller.ifscCode.value,
                onChanged: controller.updateIfscCode,
              ),
              _ProfileInputItem(
                icon: Icons.payments_outlined,
                label: AppStrings.sellerProfileUpiIdLabel,
                value: controller.upiId.value,
                onChanged: controller.updateUpiId,
              ),
            ],
          ),
          SizedBox(height: DeviceResponsive.h(context, 14)),
          const _EditProfileActions(),
        ],
      ),
    );
  }
}

class _ProfileSectionTitle extends StatelessWidget {
  const _ProfileSectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: DeviceResponsive.sp(context, 14, minScale: 0.9),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _ProfileInputList extends StatelessWidget {
  const _ProfileInputList({required this.items});

  final List<_ProfileInputItem> items;

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
          final _ProfileInputItem item = items[index];

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _ProfileInputTile(item: item),
              if (index != items.length - 1) const Divider(height: 1),
            ],
          );
        }),
      ),
    );
  }
}

class _ProfileInputTile extends StatelessWidget {
  const _ProfileInputTile({required this.item});

  final _ProfileInputItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 12),
        vertical: DeviceResponsive.h(context, 8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: DeviceResponsive.h(context, 19)),
            child: Icon(
              item.icon,
              color: AppColors.primary,
              size: DeviceResponsive.r(context, 20),
            ),
          ),
          SizedBox(width: DeviceResponsive.w(context, 12)),
          Expanded(
            child: TextFormField(
              initialValue: item.value,
              onChanged: item.onChanged,
              keyboardType: item.keyboardType,
              maxLines: item.maxLines,
              minLines: item.maxLines > 1 ? 2 : 1,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: DeviceResponsive.sp(context, 12, minScale: 0.9),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                labelText: item.label,
                hintText: AppStrings.sellerProfileEmptyValue,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: DeviceResponsive.w(context, 10),
                  vertical: DeviceResponsive.h(context, 11),
                ),
                labelStyle: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: DeviceResponsive.sp(context, 11, minScale: 0.9),
                  fontWeight: FontWeight.w600,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    DeviceResponsive.r(context, 8),
                  ),
                  borderSide: const BorderSide(color: Color(0xFFD5D8DF)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    DeviceResponsive.r(context, 8),
                  ),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditProfileActions extends StatelessWidget {
  const _EditProfileActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: DeviceResponsive.h(context, 42),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    DeviceResponsive.r(context, 8),
                  ),
                ),
              ),
              child: Text(
                AppStrings.sellerProfileSaveChanges,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: DeviceResponsive.sp(context, 12.5, minScale: 0.88),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: DeviceResponsive.w(context, 10)),
        Expanded(
          child: SizedBox(
            height: DeviceResponsive.h(context, 42),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    DeviceResponsive.r(context, 8),
                  ),
                ),
              ),
              child: Text(
                AppStrings.sellerProfileDiscardChanges,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: DeviceResponsive.sp(context, 12.5, minScale: 0.88),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileInputItem {
  const _ProfileInputItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  final IconData icon;
  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final int maxLines;
}
