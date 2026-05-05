import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:onesoff/app/utils/deviceConstants/appStrings.dart';

import '../../../../controllers/app_session_controller.dart';
import '../../../../routes/appRoutes.dart';

class VendorOnboardingController extends GetxController {
  final AppSessionController session = Get.find<AppSessionController>();

  final RxInt currentStep = 0.obs;
  //step 1
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController shortBrandDescriptionController =
      TextEditingController();

  /// step 2
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController googleBusinessProfileController =
      TextEditingController();
  final TextEditingController gstController = TextEditingController();

  final TextEditingController occupationController = TextEditingController();

  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController shopAddressController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  ///step 3
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController bankAccountHolderController =
      TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController bankBranchController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController upiController = TextEditingController();

  ///step 4
  final TextEditingController inventoryVolumeController =
      TextEditingController();
  final Rx<RangeValues> priceRange = const RangeValues(0, 500).obs;

  //step 1
  final RxString selectedAccountType = shopOwner.obs;

  //step 2
  final RxnString selectedExperience = RxnString();
  final RxnString selectedStoreType = RxnString();
  final RxList<String> selectedWorkingDays = <String>[].obs;

  final RxnString selectedPickupMethod = RxnString();

  final RxnString selectedState = RxnString();
  final RxnString selectedCity = RxnString();

  //step 3
  final RxnString selectedBusinessType = RxnString();

  //step 4
  final RxList<String> selectedPrimaryCategories = <String>[].obs;
  final RxList<String> selectedTargetAudience = <String>[].obs;
  final RxList<String> selectedAvailableSizes = <String>[].obs;

  //last step
  final RxnString selectedDefaultRentalDuration = RxnString();
  final RxnString selectedCleaningBuffer = RxnString();

  //step 2
  final RxBool isTrialAvailable = false.obs;
  final RxBool isHomeDeliveryAvailable = false.obs;
  final RxBool isAlterationSupportAvailable = false.obs;
  final RxBool isMultipleOutfitsAvailable = false.obs;

  //step 3
  final RxBool isOwnershipDeclared = false.obs;

  //step 4 and step 5
  final RxBool acceptTermsAndConditions = false.obs;
  final RxBool acceptCommissionAgreement = false.obs;
  final RxBool acceptCancellationPolicy = false.obs;
  final RxBool acceptDepositRules = false.obs;

  final RxBool acceptOrderHandlingRules = false.obs;
  final RxBool acceptQualityStandards = false.obs;
  final RxBool acceptReturnHandlingRules = false.obs;

  final RxBool acceptPassiveOwnershipModel = false.obs;
  final RxBool acceptPlatformPricingControl = false.obs;
  final RxBool acceptRevenueShare = false.obs;
  final RxBool acceptMaintenanceDeductionRules = false.obs;

  final RxMap<String, String> selectedFiles = <String, String>{}.obs;

  //step 1
  List<String> get accountTypeOptions => const <String>[
    shopOwner,
    individualOwner,
  ];

  static const String shopOwner = 'Shop Owner';
  static const String individualOwner = 'Individual Owner';
  bool get isShopOwner => selectedAccountType.value == 'Shop Owner';
  bool get isIndividualOwner => selectedAccountType.value == 'Individual Owner';

  int get totalSteps => isShopOwner ? 5 : 4;

  //step 2
  Map<String, List<String>> get stateCityMap => const <String, List<String>>{
    'Maharashtra': <String>['Mumbai', 'Pune', 'Nagpur', 'Nashik'],
    'Delhi': <String>['New Delhi', 'Dwarka', 'Rohini'],
    'Karnataka': <String>['Bengaluru', 'Mysuru', 'Mangaluru'],
    'Gujarat': <String>['Ahmedabad', 'Surat', 'Vadodara'],
    'Rajasthan': <String>['Jaipur', 'Udaipur', 'Jodhpur'],
    'Uttar Pradesh': <String>['Lucknow', 'Noida', 'Kanpur'],
    'West Bengal': <String>['Kolkata', 'Durgapur', 'Siliguri'],
    'Punjab': <String>['Ludhiana', 'Amritsar', 'Jalandhar'],
  };

  List<String> get allStates => stateCityMap.keys.toList(growable: false);

  List<String> get availableCities {
    if (selectedState.value == null || selectedState.value!.trim().isEmpty) {
      return const <String>[];
    }
    return (stateCityMap[selectedState.value] ?? const <String>[]).toList(
      growable: false,
    );
  }

  List<String> get storeTypeOptions => const <String>[
    'Physical Store',
    'Home-based',
    'Both',
  ];

  List<String> get workingDayOptions => const <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  List<String> get workingExperienceOptions => <String>[
    "Less than 1 year",
    "1 to 5 years",
    "5 to 10 years",
    "10 and above years",
  ];

  List<String> get pickupMethodOptions => <String>["sell", "drop"];

  //step 3
  List<String> get businessTypeOptions => const <String>[
    'Sole Proprietor',
    'Partnership',
    'Pvt Ltd',
    'Individual',
    'Rent Agreement',
  ];

  bool get isBusinessTypeRentAgreement =>
      selectedBusinessType.value == "Rent Agreement";

  String get rentAgreementType => businessTypeOptions[4];

  //step 4
  List<String> get primaryCategoryOptions => const <String>[
    'Lehenga',
    'Saree',
    'Gown',
    'Sherwani',
    'Indo-western',
    'Kurta Set',
    'Anarkali',
    'Tuxedo',
  ];

  List<String> get targetAudienceOptions => const <String>[
    'Women',
    'Men',
    'Kids',
  ];

  List<String> get availableSizeOptions => const <String>[
    'XS',
    'S',
    'M',
    'L',
    'XL',
    '2XL',
    '3XL',
    '4XL',
    '5XL',
    '6XL',
  ];

  //last step (4 and 5)
  List<String> get cleaningBufferOptions => const <String>[
    '1 day',
    '2 days',
    '3 days',
  ];

  List<String> get defaultRentalDurationOptions => const <String>[
    '3 days',
    '5 days',
    '7 days',
    '10 days',
  ];

  void updateState(String? state) {
    selectedState.value = state;
    if (state == null ||
        !(stateCityMap[state]?.contains(selectedCity.value) ?? false)) {
      selectedCity.value = null;
    }
  }

  void updateCity(String? city) {
    selectedCity.value = city;
  }

  void updateWorkingDays(List<String> days) {
    selectedWorkingDays.assignAll(days);
  }

  void updatePrimaryCategories(List<String> categories) {
    selectedPrimaryCategories.assignAll(categories);
  }

  void updateTargetAudience(List<String> audience) {
    selectedTargetAudience.assignAll(audience);
  }

  void updateAvailableSizes(List<String> sizes) {
    selectedAvailableSizes.assignAll(sizes);
  }

  Future<void> pickFile(String fieldKey) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: const <String>['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (result == null || result.files.isEmpty) return;
    final String fileName = result.files.single.name.trim();
    if (fileName.isEmpty) return;
    selectedFiles[fieldKey] = fileName;
  }

  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value = currentStep.value + 1;
      return;
    }
    completeVendorSetup();
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value = currentStep.value - 1;
      return;
    }
    Get.back();
  }

  void completeVendorSetup() {
    session.setRole('vendor');
    Get.offAllNamed(AppRoutes.vendorDashboard);
  }

  List<(String, String)> get stepInfo {
    final info = [
      (AppStrings.stepOneHeading, AppStrings.stepOneSubHeading),
      (AppStrings.stepTwoHeading, AppStrings.stepTwoSubHeading),
      (AppStrings.stepThreeHeading, AppStrings.stepThreeSubHeading),
    ];

    if (isShopOwner) {
      info.add((AppStrings.stepFourHeading, AppStrings.stepFourSubHeading));
    }

    info.add((AppStrings.stepFiveHeading, AppStrings.stepFiveSubHeading));

    return info;
  }

  @override
  void onClose() {
    // Step 1
    phoneNumberController.dispose();
    ownerNameController.dispose();
    emailController.dispose();
    shortBrandDescriptionController.dispose();

    // Step 2
    shopNameController.dispose();
    googleBusinessProfileController.dispose();
    gstController.dispose();
    occupationController.dispose();
    pinCodeController.dispose();
    shopAddressController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();

    // Step 3
    aadhaarController.dispose();
    accountNumberController.dispose();
    bankAccountHolderController.dispose();
    bankNameController.dispose();
    bankBranchController.dispose();
    ifscController.dispose();
    upiController.dispose();

    // Step 4
    inventoryVolumeController.dispose();

    super.onClose();
  }
}
