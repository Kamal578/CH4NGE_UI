import 'package:ch4nge/features/layers/presentation/widgets/custom_appbar.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({super.key});

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  @override
  Widget build(BuildContext context) {
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
        "Weekly Challenges ",
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
    constraints: BoxConstraints(minHeight: 90.h), // Use constraints instead of fixed height
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
                    "Pedal Power Challenge",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "75 KM on a bicycle in 7 Days!",
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
                  FittedBox( // Ensure time text scales down
                    child: Text(
                      "05 : 13 : 24",
                      style: TextStyle(
                        fontSize: 14.sp, // Reduced base size
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
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
  double percentageCompleted = 45.75 / 75;

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
                    "45.75 / 75",
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
                onPressed: () {},
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
          ),

          // Second Achievement Item
          _buildAchievementItem(
            topLineColor: Color.fromARGB(128, 125, 211, 52),
            circleColor: Color.fromARGB(255, 125, 211, 52),
            bottomLineColor: Color.fromARGB(128, 144, 152, 177),
            titleColor: Colors.black,
          ),

          // Third Achievement Item
          _buildAchievementItem(
            topLineColor: Color.fromARGB(128, 144, 152, 177),
            circleColor: Color.fromARGB(128, 144, 152, 177),
            bottomLineColor: Color.fromARGB(128, 144, 152, 177),
            titleColor: Colors.black,
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
                "Stealthy Water Warrior",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Saving 1,000+ liters of water in a month through mindful habits",
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
              itemExtent: 200,
              children: List.generate(
                10,
                (index) {
                  return Container(
                    color: Color.fromARGB(255, 125, 211, 52),
                  );
                },
              ),
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
      actions: [
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            "assets/icons/notifications_icon.png",
            width: 28.w,
            height: 28.h,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            "assets/icons/settings_icon.png",
            width: 28.w,
            height: 28.h,
          ),
        ),
      ],
    );
  }
}
