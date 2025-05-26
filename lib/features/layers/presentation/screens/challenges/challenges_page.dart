import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/core/utils/timestamp_mapper.dart';
import 'package:ch4nge/features/layers/domain/entities/achievement_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/mini_challenge_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/weekly_challenge_entity.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_achievement_progress.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_mini_challenges.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_weekly_challenge.dart';
import 'package:ch4nge/features/layers/presentation/widgets/countdown_timer.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_appbar.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({
    super.key,
    required this.getWeeklyChallengeUseCase,
    required this.getAchievementProgressUseCase,
    required this.getMiniChallengesUseCase,
  });

  final GetWeeklyChallengeUseCase getWeeklyChallengeUseCase;
  final GetAchievementProgressUseCase getAchievementProgressUseCase;
  final GetMiniChallengesUseCase getMiniChallengesUseCase;

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  final String userId = AuthManager.getId();
  WeeklyChallengeEntity? weeklyChallenge;
  List<AchievementEntity>? achievementProgress;
  List<MiniChallengeEntity>? miniChallenges;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {

      final now = DateTime.now();

      final weeklyChallengeCacheTimestamp =
          await CacheTimestampMapper.getWeeklyChallengeCacheTimestamp(userId);
      final nextAchievementCacheTimestamp =
          await CacheTimestampMapper.getNextAchievementCacheTimestamp(userId);
      final miniChallengesCacheTimestamp =
          await CacheTimestampMapper.getMiniChallengesCacheTimestamp(userId);

      final cacheStamps = {
        "weekly_challenge": weeklyChallengeCacheTimestamp,
        "next_achievement": nextAchievementCacheTimestamp,
        "mini_challenges": miniChallengesCacheTimestamp,
      };

      for (final cacheStamp in cacheStamps.entries) {
        if (cacheStamp.value != null) {
          final isDifferentDate = cacheStamp.value!.year != now.year ||
              cacheStamp.value!.month != now.month ||
              cacheStamp.value!.day != now.day;

          if (isDifferentDate) {
            CacheTimestampMapper.setNewTimestamp(
              cacheStamp.key,
              userId: userId,
              newTimestamp: now.subtract(const Duration(minutes: 6)),
            );
          }
        }
      }

      final challenge = await widget.getWeeklyChallengeUseCase(userId);
      final achievements = await widget.getAchievementProgressUseCase(userId);
      final miniChallenges = await widget.getMiniChallengesUseCase(userId);
      
      setState(() {
        weeklyChallenge = challenge;
        achievementProgress = achievements;
        this.miniChallenges = miniChallenges;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint('Error loading data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildCustomAppbarWidget(),
        bottomNavigationBar: _buildCustomNavbarWidget(),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16.h,
            right: 16.h,
          ),
          child: Column(
            children: [
              _buildTitleWidget(),
              SizedBox(height: 20.h),
              _buildWeeklyChallengeWidget(),
              SizedBox(height: 8.h),
              _buildAchievementsWidget(),
              SizedBox(height: 8.h),
              _buildMiniChallengesWidget(),
            ],
          ),
        ),
      ),
    );
  }

  _buildTitleWidget() {
    return Container(
      width: double.maxFinite,
      height: 32.h,
      alignment: Alignment.centerLeft,
      child: Text(
        "Weekly Challenges",
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildWeeklyChallengeWidget() {
    return Container(
      width: double.maxFinite,
      constraints: BoxConstraints(
          minHeight: 90.h), // Use constraints instead of fixed height
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color.fromARGB(255, 144, 152, 177),
          width: 0.5.w, // Make border width responsive
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weeklyChallenge!.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      weeklyChallenge!.subtitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 144, 152, 177),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                constraints: BoxConstraints(
                  minWidth: 90.w,
                  maxWidth: 120.w, // Allow container to grow slightly
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: const Color.fromARGB(255, 144, 152, 177),
                    width: 0.5.w,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const WeeklyCountdownTimer(
                      showLabels: false,
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "days hrs min",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color.fromARGB(255, 217, 217, 217),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          _buildCompletedWeeklyAchievementBar(context),
        ],
      ),
    );
  }

  Widget _buildCompletedWeeklyAchievementBar(BuildContext context) {
    double percentageCompleted =
        weeklyChallenge!.currentValue / weeklyChallenge!.totalValue;

    return SizedBox(
      height: 18.h,
      child: Stack(
        children: [
          // Background bar
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              color: const Color.fromARGB(128, 144, 152, 177),
            ),
          ),
          // Progress bar
          LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: constraints.maxWidth * percentageCompleted,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  color: const Color.fromARGB(255, 5, 149, 186),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${weeklyChallenge!.currentValue} / ${weeklyChallenge!.totalValue}",
                      style: TextStyle(
                        fontSize: 10.sp, // Reduced font size
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsWidget() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color.fromARGB(255, 144, 152, 177),
          width: 0.5.w,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Achievements Progress",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.go('/achievements');
                },
                icon: Icon(
                  Icons.chevron_right_rounded,
                  size: 24.sp,
                  color: const Color.fromARGB(255, 144, 152, 177),
                ),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ],
          ),

          // Divider
          Divider(
            color: const Color.fromARGB(128, 144, 152, 177),
            height: 16.h,
            thickness: 0.5.h,
          ),

          // First Achievement Item
          _buildAchievementItem(
            topLineColor: Color.fromARGB(128, 125, 211, 52),
            circleColor: Color.fromARGB(128, 125, 211, 52),
            bottomLineColor: Color.fromARGB(128, 125, 211, 52),
            titleColor: Colors.black.withAlpha(128),
            title: achievementProgress![0].title,
            subtitle: achievementProgress![0].subtitle,
          ),

          // Second Achievement Item
          _buildAchievementItem(
            topLineColor: Color.fromARGB(128, 125, 211, 52),
            circleColor: Color.fromARGB(255, 125, 211, 52),
            bottomLineColor: Color.fromARGB(128, 144, 152, 177),
            titleColor: Colors.black,
            title: achievementProgress![1].title,
            subtitle: achievementProgress![1].subtitle,
          ),

          // Third Achievement Item
          _buildAchievementItem(
            topLineColor: Color.fromARGB(128, 144, 152, 177),
            circleColor: Color.fromARGB(128, 144, 152, 177),
            bottomLineColor: Color.fromARGB(128, 144, 152, 177),
            titleColor: Colors.black,
            title: achievementProgress![1].title,
            subtitle: achievementProgress![1].subtitle,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem({
    required Color topLineColor,
    required Color circleColor,
    required Color bottomLineColor,
    required Color titleColor,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Vertical lines and circle
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 2.w,
              height: 4.h,
              color: topLineColor,
            ),
            Container(
              width: 50.r,
              height: 50.r,
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2.w,
              height: 4.h,
              color: bottomLineColor,
            ),
          ],
        ),

        SizedBox(width: 12.w),

        // Text Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Color.fromARGB(128, 144, 152, 177),
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildMiniChallengesWidget() {
    return Container(
      width: double.maxFinite,
      height: 250.h,
      padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mini Challenges",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 200.h,
            child: CarouselView(
              enableSplash: false,
              itemExtent: 200,
              children: miniChallenges?.map((challenge) {
                    return Container(
                      color: const Color.fromARGB(255, 125, 211, 52),
                      padding: EdgeInsets.all(16.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            challenge.title,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            challenge.subtitle,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList() ??
                  [],
            ),
          ),
        ],
      ),
    );
  }

  _buildCustomNavbarWidget() {
    return CustomBottomNavBar(
      selectedIndex: 3,
    );
  }

  _buildCustomAppbarWidget() {
    return CustomAppBar(
      backgroundColor: Colors.white,
    );
  }
}
