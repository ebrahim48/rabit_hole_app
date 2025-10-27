import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:rabbit_hole_app/controllers/leaderboard_controller.dart';
import 'package:rabbit_hole_app/core/config/app_routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../../models/leaderboard_models.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/rank_card.dart';


class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 136.w,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            CustomText(
              text: 'Leaderboard',
              color: AppColors.textColor000000,
              fontsize: 18.sp,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    context.pushNamed(AppRoutes.settingsScreen);
                  },
                  icon: Assets.icons.settings.svg(),
                ),
              ],
            ),
          ),
        ],
      ),
      body:  Obx(() {
      if (leaderBoardController.getLeaderBoardLoading.value) {
        return const Center(child: CustomLoader());
      }

      final board = leaderBoardController.leaderBoard.value;

      if (board == null || board.data == null || board.data!.isEmpty) {
        return Center(
          child: CustomText(
            text: "No leaderboard data available",
            color: AppColors.textColor000000,
          ),
        );
      }

      final globalRankings = board.data!;

      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 28.h),
              buildBestScoreCard(board),
              SizedBox(height: 20.h),
              CustomText(
                text: 'Global Rankings',
                color: AppColors.textColor000000,
                fontsize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 16.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: globalRankings.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final player = globalRankings[index];
                  return GlobalListCard(
                    icon: Assets.icons.win.svg(width: 32.w, height: 32.h),
                    imageUrl: player.user?.profileImage?.trim() ?? '',
                    title: player.user?.fullName ?? 'N/A',
                    subtitle: (player.highScoreInFt ?? 0).toString(),
                    distance: 'Distance',
                    onTap: () {


              /// ========================> Best Card =============================>
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildBestScoreCard(),
                  SizedBox(height: 20.h),
                  CustomText(
                    text: 'Global Rankings',
                    color: AppColors.textColor000000,
                    fontsize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 16.h),

                  /// ============================> Global Rankings ===================>
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    separatorBuilder:
                        (context, index) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      return GlobalListCard(
                        icon: Assets.icons.win.svg(width: 32.w, height: 32.h),
                        imageUrl:
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Pori_Moni_%28cropped%29.jpg/960px-Pori_Moni_%28cropped%29.jpg',
                        title: "Alex",
                        subtitle: "25000ft\nDistance",
                        onTap: () {},
                      );
                    },
                  ),
                ],

              ),
            ],
          ),
        ),
      );
    }),
    );
  }


  Widget buildBestScoreCard() {

    return Container(
      width: 346.w,
      height: 90.h,
      decoration: BoxDecoration(
        color: const Color(0xFFDFE380).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.r),

        border: Border.all(color: const Color(0xFFF7FCFF), width: 0.4),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          /// Best Score Texts
          Row(
            children: [
              CustomText(
                text: 'Your Best',
                color: AppColors.textColor000000,
                fontsize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
              CustomText(
                text: bestScore.toString(),
                color: AppColors.textColor000000,
                fontsize: 23.sp,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          const Spacer(),

          /// Carrot Image
          Assets.images.carrot.image(width: 48.w, height: 48.h),
        ],
      ),
    );
  }
}
