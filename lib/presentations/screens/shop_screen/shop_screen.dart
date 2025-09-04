import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../core/constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/carrot_packs-card.dart';
import '../../widgets/custom_text.dart';


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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
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

            /// ========================> Carrot Packs Grid =============================>
            Expanded(
              child: AnimationLimiter(
                child: GridView.builder(
                  itemCount: 4,
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 10.h,
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
            /// ========================> Rabbit Skin Grid =============================>
            Expanded(
              child: AnimationLimiter(
                child: GridView.builder(
                  itemCount: 6,
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 10.h,
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
            Expanded(
              child: AnimationLimiter(
                child: GridView.builder(
                  itemCount: 6,
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 10.h,
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




          ],
        ),

      ),
    );
  }



}
