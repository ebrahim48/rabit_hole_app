import 'package:get/get.dart';

import '../models/content_model.dart';
import '../models/shop_package_model.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';


// shop_controller.dart
class ShopPackageController extends GetxController {
  RxBool shopPackageLoading = false.obs;
  Rx<ShopPackageModel> shopPackage = Rx<ShopPackageModel>(ShopPackageModel());

  Future<void> getShopPackage() async {
    shopPackageLoading.value = true;
    try {
      var response = await ApiClient.getData(ApiConstants.shopPackageEndPoint);
      if (response.statusCode == 200) {
        shopPackage.value = ShopPackageModel.fromJson(response.body['data']['attributes']);
      }
    } catch (e) {
      print('Shop package error: $e');
    } finally {
      shopPackageLoading.value = false;
    }
  }

  RxBool contentLoading = false.obs;
  Rx<ContentModel> content = Rx<ContentModel>(ContentModel());

  Future<void> getContent() async {
    contentLoading.value = true;
    try {
      var response = await ApiClient.getData(ApiConstants.shopSkinPowerUpEndPoint);
      if (response.statusCode == 200) {
        content.value = ContentModel.fromJson(response.body['data']['attributes']);
      }
    } catch (e) {
      print('Content error: $e');
    } finally {
      contentLoading.value = false;
    }
  }
}




