import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:rabbit_hole_app/controllers/leaderboard_controller.dart';
import 'package:rabbit_hole_app/core/config/app_routes/app_routes.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/constants/app_colors.dart';
import '../../../global/custom_assets/assets.gen.dart';
import '../../../models/leaderboard_models.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/rank_card.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  LeaderBoardController leaderBoardController = Get.put(LeaderBoardController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      leaderBoardController.getLeaderBoard();
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
        leadingWidth: 136.w,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            CustomText(
              text: 'Leaderboard',
              color: AppColors.textColor000000,
              fontsize: 18.sp,
            )
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
      body: Obx(() {
        if (leaderBoardController.getLeaderBoardLoading.value) {
          return _LeaderBoardShimmer();
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
        final loggedInUserId = board.yourBestScore?.user ?? '';

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
                    final rank = index + 1;
                    final isCurrentUser = player.user?.id == loggedInUserId;


                    Widget rankIcon;
                    String rankText = '';

                    if (rank == 1) {
                      rankIcon = Assets.icons.win.svg(width: 32.w, height: 32.h);
                    } else if (rank == 2) {
                      rankIcon = Assets.icons.secondWin.svg(width: 32.w, height: 32.h);
                    } else if (rank == 3) {
                      rankIcon = Assets.icons.thirdWin.svg(width: 32.w, height: 32.h);
                    } else {
                      rankIcon = Container(
                        width: 32.w,
                        height: 32.h,
                        alignment: Alignment.center,
                        child: CustomText(
                          text: '#$rank',
                          color: AppColors.textColor000000,
                          fontsize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }

                    return GlobalListCard(
                      icon: rankIcon,
                      imageUrl: player.user?.profileImage?.trim() ?? '',
                      title: player.user?.fullName ?? 'N/A',
                      subtitle: (player.highScoreInFt ?? 0).toString() + 'ft',
                      distance: 'Distance',
                      isCurrentUser: isCurrentUser,
                      onTap: () {},
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _LeaderBoardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 28.h),
              // Best score card shimmer
              Container(
                width: 348.w,
                height: 100.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              SizedBox(height: 20.h),
              // "Global Rankings" label shimmer
              Container(
                width: 130.w,
                height: 16.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 16.h),
              // List item shimmers
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 8,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (_, __) => Container(
                  width: 346.w,
                  height: 75.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBestScoreCard(LeaderBoardModel board) {
    final bestScore = board.yourBestScore?.highScoreInFt ?? 0;
    return Container(
      width: 348.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: const Color(0xFFDFE380).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFF7FCFF),
          width: 0.4,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: 'Your Best',
                  color: AppColors.textColor000000,
                  fontsize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
                CustomText(
                  text: bestScore.toString() + 'ft',
                  color: AppColors.textColor000000,
                  fontsize: 23.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          const Spacer(),
          Assets.images.carrot.image(
            width: 48.w,
            height: 48.h,
          ),
        ],
      ),
    );
  }
}