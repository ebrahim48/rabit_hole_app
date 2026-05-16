import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class IAPService extends GetxController {
  static IAPService get to => Get.find<IAPService>();

  final InAppPurchase _iap = InAppPurchase.instance;

  RxBool isAvailable = false.obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  RxList<ProductDetails> products = <ProductDetails>[].obs;

  // Callbacks set by ShopScreen before triggering a purchase
  Function(PurchaseDetails)? onPurchaseSuccess;
  Function(String)? onPurchaseError;

  StreamSubscription<List<PurchaseDetails>>? _subscription;

  // ─── Play Store product IDs (must match exactly what's in Play Console) ───
  static const List<String> carrotPackProductIds = [
    'coinsmall2',
    'coinsmall1',
  ];

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  Future<void> _initialize() async {
    isLoading.value = true;

    final available = await _iap.isAvailable();
    isAvailable.value = available;

    if (!available) {
      error.value = 'In-app purchases not available on this device';
      isLoading.value = false;
      return;
    }

    // Listen to all purchase updates from the stream
    _subscription = _iap.purchaseStream.listen(
      _onPurchaseUpdate,
      onDone: () => _subscription?.cancel(),
      onError: (e) {
        error.value = e.toString();
        debugPrint('IAP stream error: $e');
      },
    );

    await loadProducts();
    await restorePurchases();
  }

  Future<void> loadProducts() async {
    isLoading.value = true;
    error.value = '';

    try {
      final ProductDetailsResponse response = await _iap
          .queryProductDetails(carrotPackProductIds.toSet());

      if (response.error != null) {
        error.value = response.error!.message;
        debugPrint('IAP product query error: ${response.error!.message}');
        return;
      }

      if (response.productDetails.isEmpty) {
        error.value = 'No products found. Check Play Console product IDs.';
        debugPrint('IAP: notFoundIDs = ${response.notFoundIDs}');
        return;
      }

      // Sort by price so index matches carrotPackProductIds order
      products.value = response.productDetails
        ..sort((a, b) => a.rawPrice.compareTo(b.rawPrice));

      debugPrint('IAP products loaded: ${products.map((p) => p.id).toList()}');
    } catch (e) {
      error.value = e.toString();
      debugPrint('IAP loadProducts exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> restorePurchases() async {
    try {
      await _iap.restorePurchases();
    } catch (e) {
      debugPrint('IAP restorePurchases error: $e');
    }
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (final purchaseDetails in purchaseDetailsList) {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          debugPrint('IAP purchase pending: ${purchaseDetails.productID}');
          break;

        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          debugPrint('IAP purchase success: ${purchaseDetails.productID}');
          onPurchaseSuccess?.call(purchaseDetails);
          break;

        case PurchaseStatus.error:
          final msg = purchaseDetails.error?.message ?? 'Purchase failed';
          debugPrint('IAP purchase error: $msg');
          onPurchaseError?.call(msg);
          break;

        case PurchaseStatus.canceled:
          debugPrint('IAP purchase cancelled: ${purchaseDetails.productID}');
          onPurchaseError?.call('Purchase was cancelled');
          break;
      }

      // Always complete the purchase to avoid it getting stuck
      if (purchaseDetails.pendingCompletePurchase) {
        _iap.completePurchase(purchaseDetails);
      }
    }
  }

  /// Buy a product by its Play Store product ID.
  /// Returns false if the product wasn't found locally.
  Future<bool> buyProductById(String productId) async {
    final ProductDetails? product = _getProductById(productId);
    if (product == null) {
      error.value = 'Product $productId not found. Try refreshing.';
      return false;
    }
    return buyProduct(product);
  }

  /// Buy a product by its index in [carrotPackProductIds].
  Future<bool> buyProductByIndex(int index) async {
    if (index < 0 || index >= carrotPackProductIds.length) {
      error.value = 'Invalid package index';
      return false;
    }
    return buyProductById(carrotPackProductIds[index]);
  }

  Future<bool> buyProduct(ProductDetails product) async {
    try {
      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: product);
      await _iap.buyConsumable(purchaseParam: purchaseParam);
      return true;
    } catch (e) {
      error.value = e.toString();
      debugPrint('IAP buyProduct error: $e');
      return false;
    }
  }

  ProductDetails? _getProductById(String id) {
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
