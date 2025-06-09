import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/features/layers/domain/entities/achievement_entity.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_all_achievements.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_appbar.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({
    super.key,
    required this.getAllAchievementsUseCase,
  });

  final GetAllAchievementsUseCase getAllAchievementsUseCase;

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  final String userId = AuthManager.getId();
  List<AchievementEntity>? achievements;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final achievements = await widget.getAllAchievementsUseCase(userId);
      setState(() {
        this.achievements = achievements;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint('Error loading data: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to load data. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildCustomAppbarWidget(context),
      bottomNavigationBar: _buildCustomNavbarWidget(),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              _buildTitleWidget(),
              _buildAchievementsWidget(),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleWidget() {
    return Container(
      width: double.maxFinite,
      height: 32.h,
      alignment: Alignment.centerLeft,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Text(
          "Achievements Progress",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildAchievementsWidget() {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Divider(
            color: const Color.fromARGB(128, 144, 152, 177),
            height: 16.h,
            thickness: 0.5.h,
          ),
          SizedBox(height: 4.h),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: achievements?.asMap().entries.map((entry) {
                  final index = entry.key;
                  final achievement = entry.value;

                  Color topLineColor = index == 0
                      ? Colors.transparent
                      : (achievement.isAchieved == true
                          ? const Color.fromARGB(128, 125, 211, 52)
                          : const Color.fromARGB(128, 144, 152, 177));
                  Color circleColor = achievement.isAchieved == true
                      ? const Color.fromARGB(255, 125, 211, 52)
                      : const Color.fromARGB(128, 144, 152, 177);
                  Color bottomLineColor = achievement.isAchieved == true
                      ? const Color.fromARGB(128, 125, 211, 52)
                      : const Color.fromARGB(128, 144, 152, 177);
                  bottomLineColor = index == achievements!.length - 1
                      ? Colors.transparent
                      : bottomLineColor;
                  Color titleColor = achievement.isAchieved == true
                      ? Colors.black
                      : Colors.black.withAlpha(128);

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildAchievementItem(
                        topLineColor: topLineColor,
                        circleColor: circleColor,
                        bottomLineColor: bottomLineColor,
                        titleColor: titleColor,
                        title: achievement.title,
                        subtitle: achievement.subtitle,
                      ),
                    ],
                  );
                }).toList() ??
                [],
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
      crossAxisAlignment: CrossAxisAlignment.center,
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
        Flexible(
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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color.fromARGB(128, 144, 152, 177),
                  height: 1.2,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomNavbarWidget() {
    return const CustomBottomNavBar(
      selectedIndex: 3,
    );
  }

  PreferredSizeWidget _buildCustomAppbarWidget(BuildContext context) {
    return CustomAppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          context.go('/challenges');
        },
        child: Icon(
          Icons.arrow_back_rounded,
          size: 24.sp,
          weight: 54,
        ),
      ),
    );
  }
}
