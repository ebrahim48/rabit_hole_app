import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rabbit_hole_app/controllers/profile_controller.dart';
import 'package:rabbit_hole_app/controllers/shop_controller.dart';
import 'package:rabbit_hole_app/services/iap_service.dart';
import '../../../core/constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/carrot_packs-card.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/power_ups_card.dart';
import '../../widgets/rabbit_skin_card.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late final ShopPackageController shopPackageController;
  late final IAPService iapService;
  late final ProfileController profileController;

  @override
  void initState() {
    super.initState();
    shopPackageController = Get.put(ShopPackageController());
    iapService = Get.put(IAPService(), permanent: true);
    profileController = Get.find<ProfileController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      shopPackageController.getShopPackage();
      shopPackageController.getContent();
      shopPackageController.getContentPowerUp();
      profileController.getProfile();
    });
  }

  // ─── Triggered when user taps "Buy" on a carrot pack ───────────────────
  Future<void> _onBuyCarrotPack(int packageIndex) async {
    if (!iapService.isAvailable.value) {
      _showSnackBar('In-app purchases are not available on this device.', isError: true);
      return;
    }

    if (iapService.products.isEmpty) {
      _showSnackBar('Products not loaded yet. Please wait…', isError: true);
      return;
    }

    // Get the backend package at this index
    final packages = shopPackageController.shopPackage.value.data;
    if (packages == null || packageIndex >= packages.length) return;
    final backendPackage = packages[packageIndex];

    // Register callbacks BEFORE triggering the purchase dialog
    iapService.onPurchaseSuccess = (PurchaseDetails purchaseDetails) async {
      await _handlePurchaseSuccess(
        purchaseDetails: purchaseDetails,
        packageId: backendPackage.id ?? '',
      );
    };
    iapService.onPurchaseError = (String message) {
      if (message != 'Purchase was cancelled') {
        _showSnackBar('Purchase failed: $message', isError: true);
      }
    };

    // Trigger the Play Store purchase dialog
    _showSnackBar('Opening store…');
    await iapService.buyProductByIndex(packageIndex);
  }

  // ─── Called after Play Store confirms the purchase ──────────────────────
  Future<void> _handlePurchaseSuccess({
    required PurchaseDetails purchaseDetails,
    required String packageId,
  }) async {
    if (packageId.isEmpty) {
      _showSnackBar('Purchase completed but package ID is missing.', isError: true);
      return;
    }

    final transactionId = purchaseDetails.purchaseID ?? purchaseDetails.verificationData.serverVerificationData;

    _showSnackBar('Processing payment…');

    final success = await shopPackageController.makePayment(
      packageId: packageId,
      transactionId: transactionId,
      context: context,
    );

    if (success) {
      await profileController.getProfile();
      _showSnackBar('Purchase successful! Carrots added to your account.', isError: false, isSuccess: true);
    } else {
      _showSnackBar(
        'Payment recorded by store but server sync failed. Contact support.',
        isError: true,
      );
    }
  }

  void _showSnackBar(String message, {bool isError = false, bool isSuccess = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess
            ? Colors.green
            : isError
                ? Colors.red
                : Colors.grey[800],
        duration: Duration(seconds: isSuccess || isError ? 3 : 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 68.w,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            CustomText(
              text: 'Shop',
              color: AppColors.textColor000000,
              fontsize: 18.sp,
            )
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Assets.icons.bigpacks.svg(),
                ),
                Obx(() => CustomText(
                  text: '${profileController.profile.value.totalCarrots ?? 0}',
                  color: AppColors.textColor000000,
                  fontsize: 18.sp,
                ))
              ],
            ),
          ),
        ],
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ============================== Carrot Packs Section =================================
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.h),
                    child: Assets.icons.carrotPacks.svg(),
                  ),
                  CustomText(
                    text: 'Carrot Packs',
                    color: AppColors.textColor000000,
                    fontsize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Carrot Packs with Shimmer
              SizedBox(
                height: 180.h,
                child: shopPackageController.shopPackageLoading.value
                    ? _buildHorizontalShimmer()
                    : AnimationLimiter(
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: shopPackageController.shopPackage.value.data?.length ?? 0,
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 16.w,
                            childAspectRatio: 162 / 162,
                          ),
                          itemBuilder: (context, index) {
                            final package = shopPackageController.shopPackage.value.data?[index];
                            return Obx(() => CarrotPacksCard(
                              title: package?.name ?? 'N/A',
                              subtitle: "${package?.amount ?? 'N/A'} Carrots",
                              price: shopPackageController.makePaymentLoading.value
                                  ? "Processing…"
                                  : "\$ ${package?.price.toString() ?? 'N/A'}",
                              onTap: shopPackageController.makePaymentLoading.value
                                  ? null
                                  : () => _onBuyCarrotPack(index),
                            ));
                          },
                        ),
                      ),
              ),

              SizedBox(height: 36.h),

              /// ============================================== Rabbit Skin Section =====================
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.h),
                    child: Assets.icons.rabbitSkin.svg(),
                  ),
                  CustomText(
                    text: 'Rabbit Skin',
                    color: AppColors.textColor000000,
                    fontsize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Rabbit Skin with Shimmer
              SizedBox(
                height: 180.h,
                child: shopPackageController.contentLoading.value
                    ? _buildHorizontalShimmer()
                    : AnimationLimiter(
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: shopPackageController.content.value.contents?.length ?? 0,
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 16.w,
                            childAspectRatio: 162 / 162,
                          ),
                          itemBuilder: (context, index) {
                            final content = shopPackageController.content.value.contents?[index];
                            return RabbitSkinCard(
                              title: content?.name ?? 'N/A',
                              subtitle: content?.category.toString() ?? 'N/A',
                              price: content?.numberOfCarrot.toString() ?? 'N/A',
                            );
                          },
                        ),
                      ),
              ),

              SizedBox(height: 36.h),

              /// ================================== Power-Ups Section ===============================
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.h),
                    child: Assets.icons.powerups.svg(),
                  ),
                  CustomText(
                    text: 'Power-Ups',
                    color: AppColors.textColor000000,
                    fontsize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Power-Ups with Shimmer
              shopPackageController.contentPowerUpLoading.value
                  ? _buildVerticalShimmer()
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: shopPackageController.contentPowerUp.value.contents?.length ?? 0,
                      separatorBuilder: (context, index) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final contentPowerUp = shopPackageController.contentPowerUp.value.contents?[index];
                        return PowerUpsListCard(
                          imageUrl: contentPowerUp?.imgUrl ?? '',
                          title: contentPowerUp?.name ?? 'N/A',
                          name: contentPowerUp?.category.toString() ?? 'N/A',
                          price: contentPowerUp?.numberOfCarrot.toString() ?? 'N/A',
                          onTap: () {},
                        );
                      },
                    ),
            ],
          ),
        );
      }),
    );
  }

  // Horizontal Shimmer for Carrot Packs and Rabbit Skin
  Widget _buildHorizontalShimmer() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      separatorBuilder: (context, index) => SizedBox(width: 16.w),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 162.w,
            height: 162.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        );
      },
    );
  }

  // Vertical Shimmer for Power-Ups
  Widget _buildVerticalShimmer() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 346.w,
            height: 75.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        );
      },
    );
  }
}
