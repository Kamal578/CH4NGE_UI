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
        body: Container(
          padding:
              // Platform.isIOS
              //     ? EdgeInsets.zero : // Use only SafeArea's padding on iOS
              EdgeInsets.only(
            // Add custom padding on Android
            left: 16.h,
            right: 16.h,
          ),
          color: Colors.white,
          child: Column(
            children: [
              _buildTitleWidget(),
              SizedBox(height: 24.h),
              _buildWeeklyChallengeWidget(),
              SizedBox(height: 6.h),
              _buildNextAchievementWidget(),
              SizedBox(height: 6.h),
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

  _buildWeeklyChallengeWidget() {
    return Container(
      width: double.maxFinite,
      height: 90.h,
      padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color.fromARGB(255, 144, 152, 177),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pedal Power Challenge",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "75 KM on a bicycle in 7 Days!",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 144, 152, 177),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                width: 90.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: const Color.fromARGB(255, 144, 152, 177),
                    width: 0.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "05 : 13 : 24",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "days hrs min",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color.fromARGB(255, 217, 217, 217),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          SizedBox(child: _buildCompletedWeeklyAchievementBar(context)),
        ],
      ),
    );
  }

  _buildCompletedWeeklyAchievementBar(BuildContext context) {
    // Calculate the percentage of completed credits
    double percentageCompleted = 45.75 / 75;

    return Stack(
      children: [
        // Background bar
        Container(
          height: 18.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: const Color.fromARGB(128, 144, 152, 177),
          ),
        ),
        // Foreground bar representing progress
        FractionallySizedBox(
          widthFactor: percentageCompleted,
          child: Container(
            height: 18.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              color: const Color.fromARGB(255, 5, 149, 186),
            ),
            child: Container(
              padding: EdgeInsets.only(left: 16.w),
              alignment: Alignment.centerLeft,
              child: Text(
                "45.75 / 75",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildNextAchievementWidget() {
    return Container(
      width: double.maxFinite,
      height: 110.h,
      padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color.fromARGB(255, 144, 152, 177),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Achievements Progress",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Divider(
            color: const Color.fromARGB(128, 144, 152, 177),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Vertical line (stick) above
                  Container(
                    width: 2,
                    height: 8,
                    color: const Color.fromARGB(128, 144, 152, 177),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(128, 144, 152, 177),
                      shape: BoxShape.circle,
                    ),
                  ),
                  // Vertical line (stick) below
                  Container(
                    width: 2,
                    height: 8,
                    color: const Color.fromARGB(128, 144, 152, 177),
                  ),
                ],
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Stealthy Water Warrior",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Saving 1,000+ liters of water in a month through mindful habits",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color.fromARGB(128, 144, 152, 177),
                        height: 1.4,
                      ),
                      maxLines: 2,
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
