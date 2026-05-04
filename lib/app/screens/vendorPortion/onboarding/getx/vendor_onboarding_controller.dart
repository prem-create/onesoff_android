import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../../../../controllers/app_session_controller.dart';
import '../../../../routes/appRoutes.dart';

class VendorOnboardingController extends GetxController {
  final AppSessionController session = Get.find<AppSessionController>();

  final RxInt currentStep = 0.obs;

  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController shortBrandDescriptionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController shopAddressController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController googleBusinessProfileController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  final TextEditingController panCardController = TextEditingController();
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController bankAccountHolderController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();

  final TextEditingController inventoryVolumeController = TextEditingController();
  final Rx<RangeValues> priceRange = const RangeValues(0, 500).obs;

  final RxnString selectedAccountType = RxnString();
  final RxnString selectedBusinessType = RxnString();
  final RxnString selectedStoreType = RxnString();
  final RxnString selectedState = RxnString();
  final RxnString selectedCity = RxnString();
  final RxnString selectedDefaultRentalDuration = RxnString();
  final RxnString selectedCleaningBuffer = RxnString();

  final RxList<String> selectedWorkingDays = <String>[].obs;

  final RxList<String> selectedPrimaryCategories = <String>[].obs;
  final RxList<String> selectedTargetAudience = <String>[].obs;
  final RxList<String> selectedAvailableSizes = <String>[].obs;

  final RxBool isTrialAvailable = false.obs;
  final RxBool isHomeDeliveryAvailable = false.obs;
  final RxBool isAlterationSupportAvailable = false.obs;
  final RxBool acceptTerms = false.obs;
  final RxBool acceptPolicy = false.obs;
  final RxBool acceptEscrowTerms = false.obs;

  final RxMap<String, String> selectedFiles = <String, String>{}.obs;

  List<String> get accountTypeOptions => const <String>[
        'Boutique',
        'Designer',
        'Individual Owner',
      ];

  List<String> get businessTypeOptions => const <String>[
        'Sole Proprietor',
        'Partnership',
        'Pvt Ltd',
        'Individual',
      ];

  List<String> get storeTypeOptions => const <String>[
        'Physical Store',
        'Home-based',
        'Both',
      ];

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
    return (stateCityMap[selectedState.value] ?? const <String>[])
        .toList(growable: false);
  }

  List<String> get workingDayOptions => const <String>[
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
      ];

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

  void updateState(String? state) {
    selectedState.value = state;
    if (state == null || !(stateCityMap[state]?.contains(selectedCity.value) ?? false)) {
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
    if (currentStep.value < 4) {
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

  @override
  void onClose() {
    shopNameController.dispose();
    ownerNameController.dispose();
    shortBrandDescriptionController.dispose();
    emailController.dispose();
    shopAddressController.dispose();
    pinCodeController.dispose();
    googleBusinessProfileController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    panCardController.dispose();
    aadhaarController.dispose();
    gstController.dispose();
    bankAccountHolderController.dispose();
    bankNameController.dispose();
    accountNumberController.dispose();
    ifscController.dispose();
    inventoryVolumeController.dispose();
    super.onClose();
  }
}
