import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/core/utils/timestamp_mapper.dart';
import 'package:ch4nge/features/layers/domain/entities/achievement_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/weekly_challenge_entity.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_next_achievement.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_user.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_weekly_challenge.dart';
import 'package:ch4nge/features/layers/presentation/widgets/countdown_timer.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_appbar.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.getUserUseCase,
    required this.getWeeklyChallengeUseCase,
    required this.getNextAchievementUseCase,
  });

  final GetUserUseCase getUserUseCase;
  final GetWeeklyChallengeUseCase getWeeklyChallengeUseCase;
  final GetNextAchievementUseCase getNextAchievementUseCase;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String username = AuthManager.getUsername();
  final String userId = AuthManager.getId();
  int? streak;
  WeeklyChallengeEntity? weeklyChallenge;
  AchievementEntity? achievement;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final now = DateTime.now();

      final userCacheTimestamp =
          await CacheTimestampMapper.getUserCacheTimestamp(userId);
      final weeklyChallengeCacheTimestamp =
          await CacheTimestampMapper.getWeeklyChallengeCacheTimestamp(userId);
      final nextAchievementCacheTimestamp =
          await CacheTimestampMapper.getNextAchievementCacheTimestamp(userId);

      final cacheStamps = {
        "user": userCacheTimestamp,
        "weekly_challenge": weeklyChallengeCacheTimestamp,
        "next_achievement": nextAchievementCacheTimestamp,
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

      final user = await widget.getUserUseCase(userId);
      final challenge = await widget.getWeeklyChallengeUseCase(userId);
      final achievement = await widget.getNextAchievementUseCase(userId);

      setState(() {
        streak = user.right.streak;
        weeklyChallenge = challenge;
        this.achievement = achievement;
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
          child: Container(
            padding: EdgeInsets.only(
              left: 16.h,
              right: 16.h,
            ),
            color: Colors.white,
            child: Column(
              children: [
                _buildTitleWidget(),
                _buildStreakWidget(),
                SizedBox(height: 2.h),
                _buildWeeklyChallengeWidget(),
                SizedBox(height: 8.h),
                _buildActionListButtonWidget(),
                SizedBox(height: 8.h),
                _buildNextAchievementWidget(),
                SizedBox(height: 8.h),
              ],
            ),
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
        "Hello $username!",
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  _buildStreakWidget() {
    return Container(
      width: double.maxFinite,
      height: 180.h,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/images/leaf_streak.png"),
          fit: BoxFit.none,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              streak?.toString() ?? '0',
              style: TextStyle(
                fontSize: 64.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              overflow: TextOverflow.visible,
            ),
          ),
          Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 130.h,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 16.h),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: 100.w,
                    maxWidth: 150.w,
                  ),
                  height: 30.h,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color.fromARGB(128, 144, 152, 177),
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Keep your streak alive!",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChallengeWidget() {
    if (weeklyChallenge == null) return SizedBox.shrink();

    return Container(
      width: double.maxFinite,
      constraints: BoxConstraints(minHeight: 90.h),
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
                      maxLines: 2,
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                constraints: BoxConstraints(
                  minWidth: 90.w,
                  maxWidth: 140.w,
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
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "days hrs min",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: const Color.fromARGB(255, 217, 217, 217),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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
    if (weeklyChallenge == null) return SizedBox.shrink();

    double percentageCompleted = weeklyChallenge!.totalValue > 0
        ? (weeklyChallenge!.currentValue / weeklyChallenge!.totalValue)
            .clamp(0.0, 1.0)
        : 0.0;

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
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "${weeklyChallenge!.currentValue} / ${weeklyChallenge!.totalValue}",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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

  Widget _buildActionListButtonWidget() {
    return Container(
      width: double.maxFinite,
      constraints: BoxConstraints(minHeight: 80.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF7DD334),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color(0xFF9098B1),
          width: 0.5.w,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Step Into a Greener Future",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  "Log green actions to earn points and hit your weekly goals.",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.2,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF7DD334),
              border: Border.all(
                color: Colors.white,
                width: 1.5.w,
              ),
            ),
            child: IconButton(
              onPressed: () {
                context.go('/actions');
              },
              icon: Icon(
                Icons.chevron_right_rounded,
                color: Colors.white,
                size: 24.sp,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextAchievementWidget() {
    if (achievement == null) return SizedBox.shrink();

    return Container(
      width: double.maxFinite,
      constraints: BoxConstraints(minHeight: 110.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color(0xFF9098B1),
          width: 0.5.w,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Keep going! Next Goal:",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Divider(
            color: const Color(0x809098B1),
            height: 16.h,
            thickness: 0.5.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 2.w,
                    height: 8.h,
                    color: const Color(0x809098B1),
                  ),
                  Container(
                    width: 50.r,
                    height: 50.r,
                    decoration: BoxDecoration(
                      color: const Color(0x809098B1),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 2.w,
                    height: 8.h,
                    color: const Color(0x809098B1),
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      achievement!.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      achievement!.subtitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0x809098B1),
                        height: 1.3,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildCustomNavbarWidget() {
    return CustomBottomNavBar(
      selectedIndex: 2,
    );
  }

  _buildCustomAppbarWidget() {
    return CustomAppBar(
      backgroundColor: Colors.white,
    );
  }
}
