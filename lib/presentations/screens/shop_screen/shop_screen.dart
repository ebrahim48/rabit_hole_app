import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:rabbit_hole_app/controllers/shop_controller.dart';
import 'package:rabbit_hole_app/presentations/widgets/custom_loader.dart';
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

  ShopPackageController shopPackageController = Get.put(ShopPackageController());

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      shopPackageController.getShopPackage();
      shopPackageController.getContent();
      shopPackageController.getContentPowerUp();
    });
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
                  onPressed: () {
                  },
                  icon: Assets.icons.bigpacks.svg(),
                ),
                CustomText(
                  text: '45',
                  color: AppColors.textColor000000,
                  fontsize: 18.sp,
                )
              ],
            ),
          ),
        ],
      ),
      body: Obx((){
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
              SizedBox(
                height: 180.h,
                child: AnimationLimiter(
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: shopPackageController.shopPackage.value.data?.length,
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 16.w,
                      childAspectRatio: 162 / 162,
                    ),
                    itemBuilder: (context, index) {
                      final package = shopPackageController.shopPackage.value.data?[index];
                      return  CarrotPacksCard(
                        title: package?.name ?? 'N/A',
                        subtitle: "${package?.amount ?? 'N/A'} Carrots",
                        price: "\$ ${package?.price.toString() ?? 'N/A'}",
                      );
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
              Obx(()=>
                SizedBox(
                  height: 180.h,
                  child: AnimationLimiter(
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: shopPackageController.content.value.contents?.length,
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 16.w,
                        childAspectRatio: 162 / 162,
                      ),
                      itemBuilder: (context, index) {
                        final content = shopPackageController.content.value.contents?[index];
                        return  RabbitSkinCard(
                          title: content?.name ?? 'N/A',
                          subtitle: content?.category.toString() ?? 'N/A',
                          price: content?.numberOfCarrot.toString() ?? 'N/A',
                        );
                      },
                    ),
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
              Obx((){
                if (shopPackageController.contentPowerUp.value.contents == null) {
                  return const Center(child: CustomLoader());
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: shopPackageController.contentPowerUp.value.contents?.length ?? 0,
                  separatorBuilder:
                      (context, index) =>
                      SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final contentPowerUp = shopPackageController.contentPowerUp.value.contents?[index];
                    return PowerUpsListCard(
                      icon: Assets.icons.shield.svg(width: 32.w, height: 32.h),
                      title: contentPowerUp?.name ??'N/A',
                      name: contentPowerUp?.category.toString() ??'N/A',
                      price: contentPowerUp?.timeInSec.toString() ??'N/A',
                      onTap: () {},
                    );
                  },
                );
              }

              ),



            ],
          ),
        );
      })

    );
  }
}
