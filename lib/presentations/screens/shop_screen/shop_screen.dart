import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/carrot_packs-card.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/power_ups_card.dart';
import '../../widgets/rabbit_skin_card.dart';


class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});



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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Carrot Packs Section
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
                  itemCount: 10,
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 16.w,
                    childAspectRatio: 162 / 162,
                  ),
                  itemBuilder: (context, index) {
                    return const CarrotPacksCard(
                      title: "Carrot Packs",
                      subtitle: "25 Carrots",
                      price: "\$0.99",
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 36.h),

            /// Rabbit Skin Section
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
            SizedBox(
              height: 180.h,
              child: AnimationLimiter(
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 16.w,
                    childAspectRatio: 162 / 162,
                  ),
                  itemBuilder: (context, index) {
                    return const RabbitSkinCard(
                      title: "Black Rabbit",
                      subtitle: "Mysterious look",
                      price: "250",
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 36.h),

            /// Power-Ups Section
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
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              separatorBuilder:
                  (context, index) =>
                  SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                return PowerUpsListCard(
                  icon: Assets.icons.shield.svg(width: 32.w, height: 32.h),
                  title: "Shield",
                  name: '5 second protection',
                  subtitle:"25000ft\nDistance",
                  price: '25',
                  onTap: () {},
                );
              },
            ),



          ],
        ),
      ),

    );
  }



}
