import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/content_model.dart';
import '../models/content_powerUp_model.dart';
import '../models/shop_package_model.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';


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
      var response = await ApiClient.getData(ApiConstants.shopSkinEndPoint);
      if (response.statusCode == 200) {
        content.value = ContentModel.fromJson(response.body['data']['attributes']);
      }
    } catch (e) {
      print('Content error: $e');
    } finally {
      contentLoading.value = false;
    }
  }




  RxBool contentPowerUpLoading = false.obs;
  Rx<ContentPowerUpModel> contentPowerUp = Rx<ContentPowerUpModel>(ContentPowerUpModel());

  Future<void> getContentPowerUp() async {
    contentPowerUpLoading.value = true;
    try {
      var response = await ApiClient.getData(ApiConstants.powerUpEndPoint);
      if (response.statusCode == 200) {
        contentPowerUp.value = ContentPowerUpModel.fromJson(response.body['data']['attributes']);
      }
    } catch (e) {
      print('Content error: $e');
    } finally {
      contentPowerUpLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Make Payment — called after a successful IAP purchase
  // ─────────────────────────────────────────────────────────────────────────
  RxBool makePaymentLoading = false.obs;

  /// [packageId]     → backend package _id  (Datum.id from ShopPackageModel)
  /// [transactionId] → Google Play purchaseID (PurchaseDetails.purchaseID)
  Future<bool> makePayment({
    required String packageId,
    required String transactionId,
    required BuildContext context,
  }) async {
    makePaymentLoading.value = true;
    try {
      final body = jsonEncode({
        "package": packageId,
        "transactionId": transactionId,
        "status": "success",
        "PaymentMethod": "google_play",
      });

      final response = await ApiClient.postData(
        ApiConstants.makePaymentEndPoint,
        body,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint('Payment recorded successfully: ${response.body}');
        return true;
      } else {
        debugPrint('Payment API error ${response.statusCode}: ${response.statusText}');
        return false;
      }
    } catch (e) {
      debugPrint('makePayment exception: $e');
      return false;
    } finally {
      makePaymentLoading.value = false;
    }
  }
}
