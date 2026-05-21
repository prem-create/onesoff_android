import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appColors.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';
import 'package:onesoff/app/core/utils/deviceUtility/deviceResponsive.dart';

import '../getx/controllers/seller_profile_controller.dart';

class PersonalInformationSection extends GetView<SellerProfileController> {
  const PersonalInformationSection({super.key});

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
            AppStrings.sellerProfilePersonalInfoTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: DeviceResponsive.sp(context, 18, minScale: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: DeviceResponsive.h(context, 12)),
          _PersonalInfoFieldList(
            items: <_PersonalInfoFieldItem>[
              _PersonalInfoFieldItem(
                icon: Icons.person_outline_rounded,
                label: AppStrings.sellerProfileOwnerNameLabel,
                value: controller.ownerName.value,
              ),
              _PersonalInfoFieldItem(
                icon: Icons.email_outlined,
                label: AppStrings.sellerProfileEmailLabel,
                value: controller.email.value,
              ),
              _PersonalInfoFieldItem(
                icon: Icons.phone_outlined,
                label: AppStrings.sellerProfilePhoneLabel,
                value: controller.phone.value,
              ),
              _PersonalInfoFieldItem(
                icon: Icons.work_outline_rounded,
                label: AppStrings.sellerProfileOccupationLabel,
                value: controller.occupation.value,
              ),
              _PersonalInfoFieldItem(
                icon: Icons.map_outlined,
                label: AppStrings.sellerProfileStateLabel,
                value: controller.state.value,
              ),
              _PersonalInfoFieldItem(
                icon: Icons.location_city_outlined,
                label: AppStrings.sellerProfileCityLabel,
                value: controller.city.value,
              ),
              _PersonalInfoFieldItem(
                icon: Icons.pin_drop_outlined,
                label: AppStrings.sellerProfilePincodeLabel,
                value: controller.pincode.value,
              ),
              _PersonalInfoFieldItem(
                icon: Icons.home_outlined,
                label: AppStrings.sellerProfileAddressLabel,
                value: controller.address.value,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PersonalInfoFieldList extends StatelessWidget {
  const _PersonalInfoFieldList({required this.items});

  final List<_PersonalInfoFieldItem> items;

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
          final _PersonalInfoFieldItem item = items[index];

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _PersonalInfoFieldTile(item: item),
              if (index != items.length - 1) const Divider(height: 1),
            ],
          );
        }),
      ),
    );
  }
}

class _PersonalInfoFieldTile extends StatelessWidget {
  const _PersonalInfoFieldTile({required this.item});

  final _PersonalInfoFieldItem item;

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
        maxLines: 3,
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

class _PersonalInfoFieldItem {
  const _PersonalInfoFieldItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}
