import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/deviceConstants/appColors.dart';
import '../../../utils/deviceConstants/appStrings.dart';
import '../../../utils/deviceUtility/deviceResponsive.dart';
import '../../../widgets/searchable_multi_select_bottom_sheet.dart';
import '../../../widgets/searchable_single_select_bottom_sheet.dart';
import 'getx/vendor_onboarding_controller.dart';

class VendorOnboardingScreen extends GetView<VendorOnboardingController> {
  const VendorOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F5),
      body: SafeArea(
        child: Obx(() {
          final int step = controller.currentStep.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //header
              Padding(
                padding: EdgeInsets.fromLTRB(
                  DeviceResponsive.w(context, 16),
                  DeviceResponsive.h(context, 12),
                  DeviceResponsive.w(context, 16),
                  DeviceResponsive.h(context, 8),
                ),
                child: Text(
                  AppStrings.vendorRegistrationTitle,
                  style: TextStyle(
                    color: AppColors.onSurface,
                    fontSize: DeviceResponsive.sp(
                      context,
                      14,
                      minScale: 0.92,
                      maxScale: 1.2,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: DeviceResponsive.w(context, 16),
                ),
                child: Text(
                  //TODO: fix Logic UI mismatch in total steps for common screen
                  'Step ${step + 1} of ${controller.totalSteps}',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: DeviceResponsive.sp(
                      context,
                      12,
                      minScale: 0.92,
                      maxScale: 1.14,
                    ),
                  ),
                ),
              ),
              SizedBox(height: DeviceResponsive.h(context, 8)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: DeviceResponsive.w(context, 16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: LinearProgressIndicator(
                    minHeight: DeviceResponsive.h(context, 8),
                    value: (step + 1) / controller.totalSteps,
                    backgroundColor: const Color(0xFFD4D6DB),
                    borderRadius: BorderRadiusGeometry.circular(50),
                    color: AppColors.primary,
                  ),
                ),
              ),

              SizedBox(height: DeviceResponsive.h(context, 12)),

              //body
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.fromLTRB(
                    DeviceResponsive.w(context, 14),
                    0,
                    DeviceResponsive.w(context, 14),
                    DeviceResponsive.h(context, 14),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9FA),
                      borderRadius: BorderRadius.circular(
                        DeviceResponsive.r(context, 14),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        DeviceResponsive.w(context, 12),
                        DeviceResponsive.h(context, 14),
                        DeviceResponsive.w(context, 12),
                        DeviceResponsive.h(context, 14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _StepHeader(stepIndex: step, controller: controller),
                          SizedBox(height: DeviceResponsive.h(context, 14)),
                          _StepBody(stepIndex: step, controller: controller),
                          SizedBox(height: DeviceResponsive.h(context, 14)),
                          Row(
                            children: <Widget>[
                              if (step > 0) ...<Widget>[
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: controller.previousStep,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.primary,
                                      side: const BorderSide(
                                        color: AppColors.primary,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: DeviceResponsive.h(
                                          context,
                                          14,
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          DeviceResponsive.r(context, 10),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'Back',
                                      style: TextStyle(
                                        fontSize: DeviceResponsive.sp(
                                          context,
                                          14,
                                          minScale: 0.92,
                                          maxScale: 1.14,
                                        ),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: DeviceResponsive.w(context, 10),
                                ),
                              ],
                              Expanded(
                                flex: step > 0 ? 2 : 1,
                                child: ElevatedButton(
                                  onPressed: controller.nextStep,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      vertical: DeviceResponsive.h(context, 14),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        DeviceResponsive.r(context, 10),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    step == controller.totalSteps - 1
                                        ? AppStrings.setupConfiguration
                                        : AppStrings.saveAndNext,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: DeviceResponsive.sp(
                                        context,
                                        14,
                                        minScale: 0.92,
                                        maxScale: 1.14,
                                      ),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _StepHeader extends StatelessWidget {
  const _StepHeader({required this.stepIndex, required this.controller});

  final int stepIndex;
  final VendorOnboardingController controller;

  @override
  Widget build(BuildContext context) {
    final List<(String, String)> info = controller.stepInfo;

    return Row(
      children: <Widget>[
        Container(
          width: DeviceResponsive.r(context, 48),
          height: DeviceResponsive.r(context, 48),
          decoration: BoxDecoration(
            color: const Color(0xFFF5ECEF),
            borderRadius: BorderRadius.circular(
              DeviceResponsive.r(context, 12),
            ),
          ),
          child: Icon(
            Icons.assignment_outlined,
            color: AppColors.primary,
            size: DeviceResponsive.r(context, 24),
          ),
        ),
        SizedBox(width: DeviceResponsive.w(context, 10)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                info[stepIndex].$1,
                style: TextStyle(
                  fontSize: DeviceResponsive.sp(
                    context,
                    14,
                    minScale: 0.92,
                    maxScale: 1.15,
                  ),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: DeviceResponsive.h(context, 2)),
              Text(
                info[stepIndex].$2,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: DeviceResponsive.sp(
                    context,
                    14,
                    minScale: 0.92,
                    maxScale: 1.12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StepBody extends StatelessWidget {
  const _StepBody({required this.stepIndex, required this.controller});

  final int stepIndex;
  final VendorOnboardingController controller;

  List<Widget> get stepWidget {
    final steps = [
      _StepOneCommon(controller: controller),
      controller.isShopOwner
          ? _StepTwoShop(controller: controller)
          : _StepTwoIndividual(controller: controller),
      controller.isShopOwner
          ? _StepThreeShop(controller: controller)
          : _StepThreeIndividual(controller: controller),
    ];

    if (controller.isShopOwner) {
      steps.add(_StepFourShop(controller: controller));
    }

    controller.isShopOwner
        ? steps.add(_LastStepShop(controller: controller))
        : steps.add(_LastStepIndividual(controller: controller));

    return steps;
  }

  @override
  Widget build(BuildContext context) {
    return stepWidget[stepIndex];
  }
}

class _StepOneCommon extends StatelessWidget {
  const _StepOneCommon({required this.controller});

  final VendorOnboardingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _FormDropdown(
          label: "Account Type",
          hint: "Choose your account type",
          value: controller.selectedAccountType.value,
          items: controller.accountTypeOptions,
          onChanged: (value) {
            controller.selectedAccountType.value = value;
          },
        ),
        _FormTextField(
          label: 'Owner Name',
          hint: 'Enter owner name',
          controller: controller.ownerNameController,
        ),
        _FormTextField(
          label: 'Phone Number',
          hint: 'Enter phone number',
          controller: controller.shopNameController,
        ),
        _FormTextField(
          label: 'Email [optional]',
          hint: 'Enter your email',
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        _FormTextField(
          label: 'Short Brand Description',
          hint: 'Describe your brand',
          controller: controller.shortBrandDescriptionController,
          maxLines: 2,
        ),
      ],
    );
  }
}

class _StepTwoShop extends StatelessWidget {
  const _StepTwoShop({required this.controller});

  final VendorOnboardingController controller;

  Future<void> _pickTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selected == null) return;
    controller.text = selected.format(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _FormTextField(
          label: 'Shop Name',
          hint: 'Enter store name',
          controller: controller.shopNameController,
        ),
        Obx(
          () => _UploadPickerField(
            label: "Upload Shop Logo",
            selectedFileName: controller.selectedFiles["shop_logo"],
            onTap: () => controller.pickFile("shop_logo"),
          ),
        ),
        _FormTextField(
          label: 'Shop Address',
          hint: 'Enter store address',
          controller: controller.shopAddressController,
          maxLines: 2,
        ),
        Obx(
          () => _SingleSelectField(
            label: 'State',
            hint: 'Select state',
            value: controller.selectedState.value,
            onTap: () async {
              final String? selected =
                  await SearchableSingleSelectBottomSheet.show(
                    context: context,
                    title: 'Select state',
                    options: controller.allStates,
                    initialValue: controller.selectedState.value,
                    searchHint: 'Search state',
                  );
              controller.updateState(selected);
            },
          ),
        ),
        Obx(
          () => _SingleSelectField(
            label: 'City',
            hint: controller.selectedState.value == null
                ? 'Select state first'
                : 'Select city',
            value: controller.selectedCity.value,
            enabled: controller.selectedState.value != null,
            onTap: () async {
              if (controller.selectedState.value == null) return;
              final String? selected =
                  await SearchableSingleSelectBottomSheet.show(
                    context: context,
                    title: 'Select city',
                    options: controller.availableCities,
                    initialValue: controller.selectedCity.value,
                    searchHint: 'Search city',
                  );
              controller.updateCity(selected);
            },
          ),
        ),
        _FormTextField(
          label: 'PIN Code',
          hint: 'Enter pin code',
          controller: controller.pinCodeController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6),
          ],
        ),
        _FormTextField(
          label: 'Google Business Profile proof. [optional]',
          hint: 'Share google business profile link',
          controller: controller.googleBusinessProfileController,
        ),
        Obx(
          () => _FormDropdown(
            label: 'Year Of experience in business',
            hint: 'Select years of experience',
            value: controller.selectedExperience.value,
            items: controller.workingExperienceOptions,
            onChanged: (String? value) =>
                controller.selectedExperience.value = value,
          ),
        ),
        Obx(
          () => _FormDropdown(
            label: 'Store Type',
            hint: 'Select store type',
            value: controller.selectedStoreType.value,
            items: controller.storeTypeOptions,
            onChanged: (String? value) =>
                controller.selectedStoreType.value = value,
          ),
        ),
        _FormTextField(
          label: 'GST Number [optional]',
          hint: 'Share google business profile link',
          controller: controller.googleBusinessProfileController,
        ),
        Obx(
          () => _MultiSelectField(
            label: 'Working Days',
            hint: 'Select all working days',
            values: controller.selectedWorkingDays.toList(growable: false),
            onTap: () async {
              final List<String>? selected =
                  await SearchableMultiSelectBottomSheet.show(
                    context: context,
                    title: 'Select working days',
                    options: controller.workingDayOptions,
                    initialValues: controller.selectedWorkingDays.toList(
                      growable: false,
                    ),
                    searchHint: 'Search working days',
                  );
              if (selected == null) return;
              controller.updateWorkingDays(selected);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: DeviceResponsive.h(context, 4)),
          child: Text(
            'Working Timing',
            style: TextStyle(
              fontSize: DeviceResponsive.sp(
                context,
                14,
                minScale: 0.92,
                maxScale: 1.14,
              ),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _TimeSelectorField(
                hint: 'Start Time',
                controller: controller.startTimeController,
                onTap: () => _pickTime(context, controller.startTimeController),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                DeviceResponsive.w(context, 8),
                DeviceResponsive.h(context, 14),
                DeviceResponsive.w(context, 8),
                0,
              ),
              child: Text(
                '-To-',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: DeviceResponsive.sp(
                    context,
                    14,
                    minScale: 0.92,
                    maxScale: 1.12,
                  ),
                ),
              ),
            ),
            Expanded(
              child: _TimeSelectorField(
                hint: 'End Time',
                controller: controller.endTimeController,
                onTap: () => _pickTime(context, controller.endTimeController),
              ),
            ),
          ],
        ),
        SizedBox(height: DeviceResponsive.h(context, 6)),
        Obx(
          () => _ToggleInfoCard(
            title: 'Trial Availability',
            subtitle:
                'Allow customers to visit your store and try outfits before renting by booking available time slots.',
            value: controller.isTrialAvailable.value,
            onChanged: (bool value) =>
                controller.isTrialAvailable.value = value,
          ),
        ),
        Obx(
          () => _ToggleInfoCard(
            title: 'Home Delivery Availability',
            subtitle:
                'Enable customers to rent outfits directly with doorstep delivery and return without visiting your store.',
            value: controller.isHomeDeliveryAvailable.value,
            onChanged: (bool value) =>
                controller.isHomeDeliveryAvailable.value = value,
          ),
        ),
        Obx(
          () => _ToggleInfoCard(
            title: 'Alteration Support Availability',
            subtitle:
                'Offer minor fitting adjustments to ensure the outfit fits the customer perfectly before delivery or pickup.',
            value: controller.isAlterationSupportAvailable.value,
            onChanged: (bool value) =>
                controller.isAlterationSupportAvailable.value = value,
          ),
        ),
      ],
    );
  }
}

class _StepTwoIndividual extends StatelessWidget {
  final VendorOnboardingController controller;
  const _StepTwoIndividual({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _FormTextField(
          label: 'Occupation',
          hint: 'Tell something about your occupation',
          maxLines: 2,
          controller: controller.occupationController,
        ),
        Obx(
          () => _ToggleInfoCard(
            title: "Do you own multiple outfits",
            subtitle: "...",
            value: controller.isMultipleOutfitsAvailable.value,
            onChanged: (value) =>
                controller.isMultipleOutfitsAvailable.value = value,
          ),
        ),
        Obx(
          () => _FormDropdown(
            label: 'Preffered pickup method',
            hint: 'self drop',
            value: controller.selectedPickupMethod.value,
            items: controller.storeTypeOptions,
            onChanged: (String? value) =>
                controller.selectedPickupMethod.value = value,
          ),
        ),
        _FormTextField(
          label: 'Address (for logistics)',
          hint: 'Enter an Address for logistics',
          maxLines: 2,
          controller: controller.shopAddressController,
        ),
        Obx(
          () => _SingleSelectField(
            label: 'State',
            hint: 'Select state',
            value: controller.selectedState.value,
            onTap: () async {
              final String? selected =
                  await SearchableSingleSelectBottomSheet.show(
                    context: context,
                    title: 'Select state',
                    options: controller.allStates,
                    initialValue: controller.selectedState.value,
                    searchHint: 'Search state',
                  );
              controller.updateState(selected);
            },
          ),
        ),
        Obx(
          () => _SingleSelectField(
            label: 'City',
            hint: controller.selectedState.value == null
                ? 'Select state first'
                : 'Select city',
            value: controller.selectedCity.value,
            enabled: controller.selectedState.value != null,
            onTap: () async {
              if (controller.selectedState.value == null) return;
              final String? selected =
                  await SearchableSingleSelectBottomSheet.show(
                    context: context,
                    title: 'Select city',
                    options: controller.availableCities,
                    initialValue: controller.selectedCity.value,
                    searchHint: 'Search city',
                  );
              controller.updateCity(selected);
            },
          ),
        ),
        _FormTextField(
          label: 'PIN Code',
          hint: 'Enter pin code',
          controller: controller.pinCodeController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6),
          ],
        ),
      ],
    );
  }
}

class _StepThreeShop extends StatelessWidget {
  const _StepThreeShop({required this.controller});

  final VendorOnboardingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _FormTextField(
          label: 'Aadhaar Card Number',
          hint: 'Enter Aadhaar Card Number',
          controller: controller.aadhaarController,
        ),

        Obx(
          () => _UploadPickerField(
            label: 'Upload Aadhaar Card',
            selectedFileName: controller.selectedFiles['aadhaar_card'],
            onTap: () => controller.pickFile('aadhaar_card'),
          ),
        ),
        Obx(
          () => _UploadPickerField(
            label: 'Selfie / Photo Verification Card',
            selectedFileName: controller.selectedFiles['aadhaar_card'],
            onTap: () => controller.pickFile('aadhaar_card'),
          ),
        ),
        _FormTextField(
          label: 'Account Number',
          hint: 'Enter account number',
          controller: controller.accountNumberController,
          keyboardType: TextInputType.number,
        ),
        _FormTextField(
          label: 'Bank account holder name',
          hint: 'Enter Account Holder Name',
          controller: controller.bankAccountHolderController,
        ),
        _FormTextField(
          label: 'Bank Name',
          hint: 'Enter Bank Name',
          controller: controller.bankNameController,
        ),
        _FormTextField(
          label: 'Branch Name',
          hint: 'Enter Branch Name',
          controller: controller.bankBranchController,
        ),

        _FormTextField(
          label: 'IFSC Code',
          hint: 'Enter IFSC code',
          controller: controller.ifscController,
        ),
        _FormTextField(
          label: 'UPI Id',
          hint: 'Enter UPI id',
          controller: controller.upiController,
        ),
        Obx(
          () => _FormDropdown(
            label: "Business Proof type",
            hint: "Select business proof type",
            value: controller.selectedBusinessType.value,
            items: controller.businessTypeOptions,
            onChanged: (value) => controller.selectedBusinessType.value = value,
          ),
        ),

        if (controller.isBusinessTypeRentAgreement)
          Obx(() {
            controller.selectedBusinessType.value;
            if (controller.isBusinessTypeRentAgreement) {
              return _UploadPickerField(
                label: "Upload Rent agreement",
                selectedFileName: controller.selectedFiles["rent_agreement"],
                onTap: () => controller.pickFile("rent_agreement"),
              );
            }
            return const SizedBox.shrink();
          }),
          
      ],
    );
  }
}

class _StepThreeIndividual extends StatelessWidget {
  final VendorOnboardingController controller;
  const _StepThreeIndividual({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _StepFourShop extends StatelessWidget {
  const _StepFourShop({required this.controller});

  final VendorOnboardingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Obx(
          () => _UploadPickerField(
            label: 'Upload Store Interior Photo',
            selectedFileName: controller.selectedFiles['store_interior'],
            onTap: () => controller.pickFile('store_interior'),
          ),
        ),
        Obx(
          () => _UploadPickerField(
            label: 'Upload Store Exterior Photo',
            selectedFileName: controller.selectedFiles['store_exterior'],
            onTap: () => controller.pickFile('store_exterior'),
          ),
        ),
        Obx(
          () => _MultiSelectField(
            label: 'Primary Categories',
            hint: 'Select all primary categories',
            values: controller.selectedPrimaryCategories.toList(
              growable: false,
            ),
            onTap: () async {
              final List<String>? selected =
                  await SearchableMultiSelectBottomSheet.show(
                    context: context,
                    title: 'Select primary categories',
                    options: controller.primaryCategoryOptions,
                    initialValues: controller.selectedPrimaryCategories.toList(
                      growable: false,
                    ),
                    searchHint: 'Search categories',
                  );
              if (selected == null) return;
              controller.updatePrimaryCategories(selected);
            },
          ),
        ),
        Obx(
          () => _MultiSelectField(
            label: 'Target Audience',
            hint: 'Select all target audience',
            values: controller.selectedTargetAudience.toList(growable: false),
            onTap: () async {
              final List<String>? selected =
                  await SearchableMultiSelectBottomSheet.show(
                    context: context,
                    title: 'Select target audience',
                    options: controller.targetAudienceOptions,
                    initialValues: controller.selectedTargetAudience.toList(
                      growable: false,
                    ),
                    searchHint: 'Search audience',
                  );
              if (selected == null) return;
              controller.updateTargetAudience(selected);
            },
          ),
        ),
        Obx(
          () => _MultiSelectField(
            label: 'Available Sizes',
            hint: 'Select all available sizes',
            values: controller.selectedAvailableSizes.toList(growable: false),
            onTap: () async {
              final List<String>? selected =
                  await SearchableMultiSelectBottomSheet.show(
                    context: context,
                    title: 'Select available sizes',
                    options: controller.availableSizeOptions,
                    initialValues: controller.selectedAvailableSizes.toList(
                      growable: false,
                    ),
                    searchHint: 'Search size',
                  );
              if (selected == null) return;
              controller.updateAvailableSizes(selected);
            },
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Price Range',
            style: TextStyle(
              fontSize: DeviceResponsive.sp(
                context,
                14,
                minScale: 0.92,
                maxScale: 1.14,
              ),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: DeviceResponsive.h(context, 6)),
        Obx(
          () => RangeSlider(
            values: controller.priceRange.value,
            min: 0,
            max: 20000,
            activeColor: AppColors.primary,
            inactiveColor: const Color(0xFFD8D2D5),
            labels: RangeLabels(
              'Rs.${controller.priceRange.value.start.toInt()}',
              'Rs.${controller.priceRange.value.end.toInt()}',
            ),
            onChanged: (RangeValues values) =>
                controller.priceRange.value = values,
          ),
        ),
        Obx(
          () => Row(
            children: <Widget>[
              Expanded(
                child: _ValueChip(
                  text: 'Rs.${controller.priceRange.value.start.toInt()}',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: DeviceResponsive.w(context, 8),
                ),
                child: Text(
                  '-',
                  style: TextStyle(
                    fontSize: DeviceResponsive.sp(
                      context,
                      22,
                      minScale: 0.92,
                      maxScale: 1.14,
                    ),
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Expanded(
                child: _ValueChip(
                  text: 'Rs.${controller.priceRange.value.end.toInt()}',
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: DeviceResponsive.h(context, 6)),
        _FormTextField(
          label: 'Inventory Volume',
          hint: 'Enter Approx number of outfits',
          controller: controller.inventoryVolumeController,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}

class _LastStepShop extends StatelessWidget {
  const _LastStepShop({required this.controller});

  final VendorOnboardingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Obx(
          () => _FormDropdown(
            label: 'Default Rental Duration',
            hint: 'Select default rental duration',
            value: controller.selectedDefaultRentalDuration.value,
            items: controller.defaultRentalDurationOptions,
            onChanged: (String? value) =>
                controller.selectedDefaultRentalDuration.value = value,
          ),
        ),
        Obx(
          () => _FormDropdown(
            label: 'Cleaning Buffer',
            hint: 'Select cleaning buffer days (eg: 1 day)',
            value: controller.selectedCleaningBuffer.value,
            items: controller.cleaningBufferOptions,
            onChanged: (String? value) =>
                controller.selectedCleaningBuffer.value = value,
          ),
        ),
        Obx(
          () => _ToggleInfoCard(
            title: 'Home Delivery Availability',
            subtitle:
                'Enable customers to rent outfits directly with doorstep delivery and return without visiting your store.',
            value: controller.isHomeDeliveryAvailable.value,
            onChanged: (bool value) =>
                controller.isHomeDeliveryAvailable.value = value,
          ),
        ),
        Obx(
          () => _ToggleInfoCard(
            title: 'Alteration support available?',
            subtitle:
                'Offer minor fitting adjustments to ensure the outfit fits the customer perfectly before delivery or pickup.',
            value: controller.isAlterationSupportAvailable.value,
            onChanged: (bool value) =>
                controller.isAlterationSupportAvailable.value = value,
          ),
        ),
        SizedBox(height: DeviceResponsive.h(context, 8)),
        Align(
          alignment: Alignment.center,
          child: Text(
            'Agreements & Submission',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: DeviceResponsive.sp(
                context,
                20,
                minScale: 0.92,
                maxScale: 1.14,
              ),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: DeviceResponsive.h(context, 8)),
        Obx(
          () => _ToggleInfoCard(
            title: 'Accept Terms & Conditions',
            subtitle:
                'Confirm that you agree to follow all platform rules, guidelines, and operational standards set by OnesOff.',
            value: controller.acceptTermsAndConditions.value,
            onChanged: (bool value) =>
                controller.acceptTermsAndConditions.value = value,
          ),
        ),
        // Obx(
        //   () => _ToggleInfoCard(
        //     title: 'Accept Rental & Return Policy',
        //     subtitle:
        //         'Acknowledge and accept the platform\'s rental duration, cancellation, return timelines, and refund policies.',
        //     value: controller.acceptPolicy.value,
        //     onChanged: (bool value) => controller.acceptPolicy.value = value,
        //   ),
        // ),
        // Obx(
        //   () => _ToggleInfoCard(
        //     title: 'Accept Escrow Payment Terms',
        //     subtitle:
        //         'Agree that payments and security deposits will be securely held and released after successful order completion.',
        //     value: controller.acceptEscrowTerms.value,
        //     onChanged: (bool value) =>
        //         controller.acceptEscrowTerms.value = value,
        //   ),
        // ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: DeviceResponsive.h(context, 4)),
          padding: EdgeInsets.all(DeviceResponsive.r(context, 10)),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.6)),
            borderRadius: BorderRadius.circular(
              DeviceResponsive.r(context, 10),
            ),
          ),
          child: Text(
            'Security deposits are automatically calculated based on rental price and held in escrow. Any damage or late fees are deducted, and the remaining amount is refunded after order completion.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: DeviceResponsive.sp(
                context,
                15,
                minScale: 0.92,
                maxScale: 1.12,
              ),
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}

class _LastStepIndividual extends StatelessWidget {
  final VendorOnboardingController controller;
  const _LastStepIndividual({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _FormTextField extends StatelessWidget {
  const _FormTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
    this.prefixIcon,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: DeviceResponsive.h(context, 10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (label.trim().isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: DeviceResponsive.h(context, 4)),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: DeviceResponsive.sp(
                    context,
                    14,
                    minScale: 0.92,
                    maxScale: 1.14,
                  ),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            style: TextStyle(
              fontSize: DeviceResponsive.sp(
                context,
                12,
                minScale: 0.92,
                maxScale: 1.14,
              ),
            ),
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: prefixIcon == null
                  ? null
                  : Icon(prefixIcon, color: AppColors.textSecondary),
              hintStyle: TextStyle(
                color: AppColors.textSecondary,
                fontSize: DeviceResponsive.sp(
                  context,
                  12,
                  minScale: 0.92,
                  maxScale: 1.12,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: DeviceResponsive.w(context, 12),
                vertical: DeviceResponsive.h(context, 14),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  DeviceResponsive.r(context, 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormDropdown extends StatelessWidget {
  const _FormDropdown({
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: DeviceResponsive.h(context, 10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: DeviceResponsive.h(context, 4)),
            child: Text(
              label,
              style: TextStyle(
                fontSize: DeviceResponsive.sp(
                  context,
                  14,
                  minScale: 0.92,
                  maxScale: 1.14,
                ),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          DropdownButtonFormField<String>(
            value: value == null || value!.isEmpty ? null : value,
            isExpanded: true,
            style: TextStyle(
              fontSize: DeviceResponsive.sp(
                context,
                12,
                minScale: 0.92,
                maxScale: 1.12,
              ),
              color: AppColors.textSecondary,
            ),
            items: items
                .map(
                  (String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: DeviceResponsive.sp(
                          context,
                          12,
                          minScale: 0.92,
                          maxScale: 1.12,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(growable: false),
            onChanged: onChanged,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: AppColors.textSecondary,
                fontSize: DeviceResponsive.sp(
                  context,
                  12,
                  minScale: 0.92,
                  maxScale: 1.12,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: DeviceResponsive.w(context, 12),
                vertical: DeviceResponsive.h(context, 14),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  DeviceResponsive.r(context, 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SingleSelectField extends StatelessWidget {
  const _SingleSelectField({
    required this.label,
    required this.hint,
    required this.value,
    required this.onTap,
    this.enabled = true,
  });

  final String label;
  final String hint;
  final String? value;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final String displayValue = value == null || value!.trim().isEmpty
        ? hint
        : value!.trim();
    return Padding(
      padding: EdgeInsets.only(bottom: DeviceResponsive.h(context, 10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: DeviceResponsive.h(context, 4)),
            child: Text(
              label,
              style: TextStyle(
                fontSize: DeviceResponsive.sp(
                  context,
                  14,
                  minScale: 0.92,
                  maxScale: 1.14,
                ),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          InkWell(
            onTap: enabled ? onTap : null,
            borderRadius: BorderRadius.circular(
              DeviceResponsive.r(context, 12),
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: DeviceResponsive.w(context, 12),
                vertical: DeviceResponsive.h(context, 14),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  DeviceResponsive.r(context, 12),
                ),
                border: Border.all(color: const Color(0xFF7C8591)),
                color: enabled ? null : const Color(0xFFF0F1F3),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      displayValue,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: value == null || value!.trim().isEmpty
                            ? AppColors.textSecondary
                            : AppColors.onSurface,
                        fontSize: DeviceResponsive.sp(
                          context,
                          12,
                          minScale: 0.92,
                          maxScale: 1.12,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: enabled
                        ? AppColors.textSecondary
                        : const Color(0xFFABB0B8),
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

class _MultiSelectField extends StatelessWidget {
  const _MultiSelectField({
    required this.label,
    required this.hint,
    required this.values,
    required this.onTap,
  });

  final String label;
  final String hint;
  final List<String> values;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final String title = values.isEmpty ? hint : values.join(', ');
    return Padding(
      padding: EdgeInsets.only(bottom: DeviceResponsive.h(context, 10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: DeviceResponsive.h(context, 4)),
            child: Text(
              label,
              style: TextStyle(
                fontSize: DeviceResponsive.sp(
                  context,
                  14,
                  minScale: 0.92,
                  maxScale: 1.14,
                ),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(
              DeviceResponsive.r(context, 12),
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: DeviceResponsive.w(context, 12),
                vertical: DeviceResponsive.h(context, 14),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  DeviceResponsive.r(context, 12),
                ),
                border: Border.all(color: const Color(0xFF7C8591)),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: values.isEmpty
                            ? AppColors.textSecondary
                            : AppColors.onSurface,
                        fontSize: DeviceResponsive.sp(
                          context,
                          12,
                          minScale: 0.92,
                          maxScale: 1.12,
                        ),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textSecondary,
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

class _TimeSelectorField extends StatelessWidget {
  const _TimeSelectorField({
    required this.hint,
    required this.controller,
    required this.onTap,
  });

  final String hint;
  final TextEditingController controller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: DeviceResponsive.h(context, 10)),
      child: GestureDetector(
        onTap: onTap,
        child: AbsorbPointer(
          child: TextField(
            controller: controller,
            readOnly: true,
            style: TextStyle(
              fontSize: DeviceResponsive.sp(
                context,
                12,
                minScale: 0.92,
                maxScale: 1.14,
              ),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: AppColors.textSecondary,
                fontSize: DeviceResponsive.sp(
                  context,
                  12,
                  minScale: 0.92,
                  maxScale: 1.12,
                ),
              ),
              prefixIcon: Icon(
                Icons.schedule_outlined,
                color: AppColors.textSecondary,
                size: DeviceResponsive.r(context, 18),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: DeviceResponsive.w(context, 12),
                vertical: DeviceResponsive.h(context, 14),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  DeviceResponsive.r(context, 12),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UploadPickerField extends StatelessWidget {
  const _UploadPickerField({
    required this.label,
    required this.selectedFileName,
    required this.onTap,
  });

  final String label;
  final String? selectedFileName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool hasSelection =
        selectedFileName != null && selectedFileName!.trim().isNotEmpty;
    return Padding(
      padding: EdgeInsets.only(bottom: DeviceResponsive.h(context, 10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: DeviceResponsive.h(context, 4)),
            child: Text(
              label,
              style: TextStyle(
                fontSize: DeviceResponsive.sp(
                  context,
                  14,
                  minScale: 0.92,
                  maxScale: 1.14,
                ),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: _DashedBorderBox(
              borderRadius: DeviceResponsive.r(context, 12),
              strokeColor: const Color(0xFF9DA2AA),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: DeviceResponsive.h(context, 20),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    DeviceResponsive.r(context, 12),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.upload_rounded,
                      color: hasSelection
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      size: DeviceResponsive.r(context, 24),
                    ),
                    SizedBox(height: DeviceResponsive.h(context, 6)),
                    Text(
                      hasSelection ? 'Selected File' : 'Tap to upload',
                      style: TextStyle(
                        fontSize: DeviceResponsive.sp(
                          context,
                          14,
                          minScale: 0.92,
                          maxScale: 1.12,
                        ),
                        fontWeight: FontWeight.w600,
                        color: hasSelection
                            ? AppColors.primary
                            : AppColors.onSurface,
                      ),
                    ),
                    SizedBox(height: DeviceResponsive.h(context, 2)),
                    Text(
                      hasSelection
                          ? selectedFileName!.trim()
                          : 'Front & back in single PDF or separate images',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: DeviceResponsive.sp(
                          context,
                          12,
                          minScale: 0.92,
                          maxScale: 1.1,
                        ),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedBorderBox extends StatelessWidget {
  const _DashedBorderBox({
    required this.child,
    required this.borderRadius,
    required this.strokeColor,
  });

  final Widget child;
  final double borderRadius;
  final Color strokeColor;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        borderRadius: borderRadius,
        strokeColor: strokeColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: child,
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({
    required this.borderRadius,
    required this.strokeColor,
  });

  final double borderRadius;
  final Color strokeColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final RRect rRect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(borderRadius),
    );
    final Path path = Path()..addRRect(rRect);
    const double dashWidth = 6;
    const double dashSpace = 4;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double next = (distance + dashWidth) < metric.length
            ? (distance + dashWidth)
            : metric.length;
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.borderRadius != borderRadius;
  }
}

class _ToggleInfoCard extends StatelessWidget {
  const _ToggleInfoCard({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: DeviceResponsive.h(context, 8)),
      padding: EdgeInsets.all(DeviceResponsive.r(context, 10)),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF8F96A1)),
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: DeviceResponsive.sp(
                      context,
                      14,
                      minScale: 0.92,
                      maxScale: 1.14,
                    ),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: DeviceResponsive.h(context, 3)),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: DeviceResponsive.sp(
                      context,
                      12,
                      minScale: 0.92,
                      maxScale: 1.12,
                    ),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: DeviceResponsive.w(context, 8)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _ValueChip extends StatelessWidget {
  const _ValueChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceResponsive.h(context, 48),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: DeviceResponsive.w(context, 14),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF9A9FA8)),
        borderRadius: BorderRadius.circular(DeviceResponsive.r(context, 20)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: DeviceResponsive.sp(
            context,
            16,
            minScale: 0.92,
            maxScale: 1.12,
          ),
        ),
      ),
    );
  }
}
