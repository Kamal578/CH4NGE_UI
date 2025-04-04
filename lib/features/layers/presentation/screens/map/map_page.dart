import 'package:ch4nge/features/layers/presentation/widgets/custom_appbar.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_navbar.dart';
import 'package:ch4nge/features/layers/presentation/widgets/draggable_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildCustomAppbarWidget(),
        bottomNavigationBar: _buildCustomNavbarWidget(),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              children: [
                _buildTitleWidget(),
              ],
            ),
            FriendsActivitySheet(),
          ],
        ),
      ),
    );
  }

  _buildTitleWidget() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            width: double.maxFinite,
            height: 32.h,
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: Text(
              "Your Friends' Activities",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          height: 10.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.r),
              bottomRight: Radius.circular(12.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 224),
                blurRadius: 3,
                spreadRadius: 0.5,
                offset: const Offset(0, 5),
              )
            ],
          ),
        ),
      ],
    );
  }

  _buildCustomNavbarWidget() {
    return CustomBottomNavBar(
      selectedIndex: 4,
    );
  }

  _buildCustomAppbarWidget() {
    return CustomAppBar(
      backgroundColor: Colors.white,
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

class FriendsActivitySheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      minHeightRatio: 0.25,
      maxHeightRatio: 0.95,
      backgroundColor: Colors.white,
      headerText: "See Friends' Activities",
      builder: (context, sheetPosition) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              _buildActivityItem(
                username: "Kamush Skibidi",
                time: "9:41",
                action: "Planted a tree",
                points: 10,
              ),
              _buildActivityItem(
                username: "Kamush Skibidi",
                time: "9:41",
                action:
                    "Planted a tree, and saved a cat from a tree, and bla bla bla ble ble ble blu blu blu",
                points: 52,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActivityItem(
      {required String username,
      required String action,
      required String time,
      required int points}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.r,
            spreadRadius: 1.r,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(12.r),
        leading: CircleAvatar(
          radius: 24.r,
          backgroundColor: Color(0xFF7DD334).withValues(alpha: .1),
          child: Icon(Icons.person, color: Color(0xFF7DD334), size: 28.r),
        ),
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87,
              height: 1.4,
            ),
            children: [
              TextSpan(
                text: username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(text: ' '),
              TextSpan(text: action),
            ],
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Text(
            time,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.eco,
              color: Color(0xFF7DD334),
              size: 20.sp,
            ),
            SizedBox(width: 4.w),
            Text(
              '+$points',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7DD334),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
