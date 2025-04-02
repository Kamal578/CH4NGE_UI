import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding:
              // Platform.isIOS
              //     ? EdgeInsets.zero : // Use only SafeArea's padding on iOS
              EdgeInsets.only(
            // Add custom padding on Android
            left: 16.h,
            top: 8.h,
            right: 16.h,
          ),
          child: Column(
            children: [
              _buildTitleWidget(),
              _buildStreakWidget(),
              _buildWeeklyChallengeWidget(),
            ],
          ),
        ),
      ),
    );
  }

  _buildTitleWidget() {
    return Container(
      width: double.maxFinite,
      height: 48.h,
      alignment: Alignment.centerLeft,
      child: Text(
        "Hello Dima!",
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  _buildStreakWidget() {
    return Container(
      width: double.maxFinite,
      height: 235.h,
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
              "23",
              style: TextStyle(
                fontSize: 96.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 180.h,
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
                  width: 160.w,
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Keep your streak alive!",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
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

  _buildWeeklyChallengeWidget() {
    return Container(
      width: double.maxFinite,
      height: 90.h,
      padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
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
          SizedBox(
            child: _buildCompletedWeeklyAchievementWidget(context),
          ),
        ],
      ),
    );
  }

  _buildCompletedWeeklyAchievementWidget(BuildContext context) {
    // Calculate the percentage of completed credits
    double percentageCompleted = 45.75 / 75;

    return Stack(
      children: [
        // Background bar
        Container(
          height: 20.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: const Color.fromARGB(128, 144, 152, 177),
          ),
        ),
        // Foreground bar representing progress
        FractionallySizedBox(
          widthFactor: percentageCompleted,
          child: Container(
            height: 20.h,
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
}
