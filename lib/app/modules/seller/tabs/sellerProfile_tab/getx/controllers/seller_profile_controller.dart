import 'package:get/get.dart';
import 'package:onesoff/app/core/utils/deviceConstants/appStrings.dart';

class SellerProfileController extends GetxController {
  final RxString selectedHeaderTab = AppStrings.sellerProfileTabOverview.obs;
  final RxString ownerName = AppStrings.sellerProfileName.obs;
  final RxString email = AppStrings.sellerProfileEmail.obs;
  final RxString phone = AppStrings.sellerProfilePhoneValue.obs;
  final RxString occupation = AppStrings.sellerProfileOccupationValue.obs;
  final RxString cityState = ''.obs;
  final RxString state = AppStrings.sellerProfileStateValue.obs;
  final RxString city = AppStrings.sellerProfileCityValue.obs;
  final RxString pincode = AppStrings.sellerProfilePincodeValue.obs;
  final RxString address = AppStrings.sellerProfileAddressValue.obs;
  final RxString idProofType = AppStrings.sellerProfileIdProofTypeValue.obs;
  final RxString ownershipDeclaration =
      AppStrings.sellerProfileOwnershipDeclarationValue.obs;
  final RxString idProofDocument =
      AppStrings.sellerProfileIdProofDocumentValue.obs;
  final RxString verificationStatus =
      AppStrings.sellerProfileVerificationStatusValue.obs;
  final RxString accountHolderName = ''.obs;
  final RxString bankAccountNumber = ''.obs;
  final RxString ifscCode = ''.obs;
  final RxString upiId = ''.obs;
  final RxString shopName = AppStrings.sellerProfileName.obs;

  final List<String> headerTabs = const <String>[
    AppStrings.sellerProfileTabOverview,
    AppStrings.sellerProfileTabPersonalInfo,
    AppStrings.sellerProfileTabKycVerification,
    AppStrings.sellerProfileTabBankDetails,
    AppStrings.sellerProfileTabEditProfile,
  ];

  void setHeaderTab(String value) {
    selectedHeaderTab.value = value;
  }

  void updateOwnerName(String value) {
    ownerName.value = value;
  }

  void updateEmail(String value) {
    email.value = value;
  }

  void updatePhone(String value) {
    phone.value = value;
  }

  void updateOccupation(String value) {
    occupation.value = value;
  }

  void updateCity(String value) {
    city.value = value;
  }

  void updateState(String value) {
    state.value = value;
  }

  void updatePincode(String value) {
    pincode.value = value;
  }

  void updateShopName(String value) {
    shopName.value = value;
  }

  void updateAddress(String value) {
    address.value = value;
  }

  void updateAccountHolderName(String value) {
    accountHolderName.value = value;
  }

  void updateBankAccountNumber(String value) {
    bankAccountNumber.value = value;
  }

  void updateIfscCode(String value) {
    ifscCode.value = value;
  }

  void updateUpiId(String value) {
    upiId.value = value;
  }
}
