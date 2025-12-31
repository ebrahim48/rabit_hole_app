import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../models/contact_model.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';

class SettingsController extends GetxController{


  RxBool getContactUsLoading = false.obs;
  Rx<ContactModel?> contact = Rx<ContactModel?>(null);

  contactUs() async {
    getContactUsLoading(true);
    var response = await ApiClient.getData(ApiConstants.contactUsEndPoint);
    if (response.statusCode == 200) {
      final data = response.body['data'];
      contact.value = ContactModel.fromJson(data);
    }
    getContactUsLoading(false);
  }

  /// ================================> Privacy Policy ==============================>
  RxBool getPrivacyPolicyLoading = false.obs;
  RxString value = "".obs;

  Future<void> privacyPolicy() async {
    getPrivacyPolicyLoading(true);
    try {
      var response = await ApiClient.getData(ApiConstants.privacyEndPoint);
      if (response.statusCode == 200) {
        final attributes = response.body['data']?['attributes'];

        if (attributes != null) {
          if (attributes is String) {
            value.value = attributes;
          } else if (attributes is Map) {
            value.value = attributes['content']?.toString() ??
                attributes['policy']?.toString() ??
                'Privacy policy content not available';
          } else {
            value.value = attributes.toString();
          }
        } else {
          print('Privacy Policy: API returned null attributes');
          value.value = 'Privacy policy not available at the moment';
        }
      } else if (response.statusCode == 404) {
        value.value = 'Privacy policy not found';
      }
    } catch (e) {
      print('Privacy Policy Error: $e');
      value.value = 'Error loading privacy policy';
    } finally {
      getPrivacyPolicyLoading(false);
    }
  }

// /// ================================> Privacy Policy  ==============================>
//
//   RxBool getPrivacyPolicyLoading = false.obs;
//   RxString value = "".obs;
//   privacyPolicy() async {
//     getPrivacyPolicyLoading(true);
//     var response = await ApiClient.getData(ApiConstants.privacyEndPoint);
//     if (response.statusCode == 200) {
//       value.value = response.body['data']['attributes'];
//       getPrivacyPolicyLoading(false);
//     } else if (response.statusCode == 404) {
//       getPrivacyPolicyLoading(false);
//     }
//   }


  /// ================================> About Us ==============================>
  RxBool getAboutUsLoading = false.obs;
  RxString about = "".obs;

  Future<void> aboutUs() async {
    getAboutUsLoading(true);
    try {
      var response = await ApiClient.getData(ApiConstants.aboutUsEndPoint);
      if (response.statusCode == 200) {
        final data = response.body['data'];
        final attributes = data?['attributes'];
        if (attributes != null) {
          if (attributes is String) {
            about.value = attributes;
          } else if (attributes is Map) {
            about.value = attributes['content']?.toString() ??
                attributes['about']?.toString() ??
                attributes['description']?.toString() ??
                'About us content not available';
          } else {
            about.value = attributes.toString();
          }
        } else {
          print('About Us: API returned null attributes');
          about.value = 'About us information not available at the moment';
        }
      } else if (response.statusCode == 404) {
        about.value = 'About us information not found';
      }
    } catch (e) {
      print('About Us Error: $e');
      about.value = 'Error loading about us information';
    } finally {
      getAboutUsLoading(false);
    }
  }


  // /// ================================> About Us  ==============================>
  //
  // RxBool getAboutUsLoading = false.obs;
  // RxString about = "".obs;
  // aboutUs() async {
  //   getAboutUsLoading(true);
  //   var response = await ApiClient.getData(ApiConstants.aboutUsEndPoint);
  //   if (response.statusCode == 200) {
  //     about.value = response.body['data'];
  //     getAboutUsLoading(false);
  //   } else if (response.statusCode == 404) {
  //     getAboutUsLoading(false);
  //   }
  // }

  // /// ================================> Terms Condition ==============================>
  //
  // RxBool getTermsConditionLoading = false.obs;
  // RxString terms = "".obs;
  // termsCondition() async {
  //   getTermsConditionLoading(true);
  //   var response = await ApiClient.getData(ApiConstants.termsEndPoint);
  //   if (response.statusCode == 200) {
  //     terms.value = response.body['data']['attributes'];
  //     getTermsConditionLoading(false);
  //   } else if (response.statusCode == 404) {
  //     getTermsConditionLoading(false);
  //   }
  // }


  /// ================================> Terms Condition ==============================>
  RxBool getTermsConditionLoading = false.obs;
  RxString terms = "".obs;

  Future<void> termsCondition() async {
    getTermsConditionLoading(true);
    try {
      var response = await ApiClient.getData(ApiConstants.termsEndPoint);
      if (response.statusCode == 200) {
        final attributes = response.body['data']?['attributes'];

        // ✅ Handle null and convert to String properly
        if (attributes != null) {
          if (attributes is String) {
            terms.value = attributes;
          } else if (attributes is Map) {
            // If it's a map, extract specific field
            terms.value = attributes['content']?.toString() ??
                attributes['terms']?.toString() ??
                attributes['conditions']?.toString() ??
                'Terms and conditions not available';
          } else {
            terms.value = attributes.toString();
          }
        } else {
          print('Terms Condition: API returned null attributes');
          terms.value = 'Terms and conditions not available at the moment';
        }
      } else if (response.statusCode == 404) {
        terms.value = 'Terms and conditions not found';
      }
    } catch (e) {
      print('Terms Condition Error: $e');
      terms.value = 'Error loading terms and conditions';
    } finally {
      getTermsConditionLoading(false);
    }
  }

}