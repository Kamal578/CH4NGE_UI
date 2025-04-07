import 'package:ch4nge/features/layers/presentation/widgets/custom_appbar.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildCustomAppbarWidget(context),
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
              _buildAchievementsWidget(),
              SizedBox(height: 12.h),
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
        "Achievements Progress",
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildAchievementsWidget() {
    int length = 20;

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
            children: List.generate(
              length,
              (index) {
                Color topLineColor = index == 0
                    ? Colors.transparent
                    : (index < 3
                        ? Color.fromARGB(128, 125, 211, 52)
                        : Color.fromARGB(128, 144, 152, 177));
                Color circleColor = index < 2
                    ? Color.fromARGB(255, 125, 211, 52)
                    : Color.fromARGB(128, 144, 152, 177);
                Color bottomLineColor = index < 2
                    ? Color.fromARGB(128, 125, 211, 52)
                    : Color.fromARGB(128, 144, 152, 177);
                bottomLineColor = index == length - 1
                    ? Colors.transparent
                    : bottomLineColor;
                Color titleColor =
                    index < 2 ? Colors.black : Colors.black.withAlpha(128);

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildAchievementItem(
                      topLineColor: topLineColor,
                      circleColor: circleColor,
                      bottomLineColor: bottomLineColor,
                      titleColor: titleColor,
                    ),
                  ],
                );
              },
            ),
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

  _buildCustomNavbarWidget() {
    return CustomBottomNavBar(
      selectedIndex: 3,
    );
  }

  _buildCustomAppbarWidget(BuildContext context) {
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
