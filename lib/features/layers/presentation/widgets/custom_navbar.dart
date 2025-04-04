import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int selectedIndex;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
  });

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    final routes = [
      '/feed',
      '/leaderboard',
      '/',
      '/challenges',
      '/map',
    ];

    if (index >= 0 && index < routes.length) {
      context.go(routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      padding: EdgeInsets.only(bottom: 12.h),
      child: CustomNavbar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF7DD334),
        unselectedItemColor: const Color(0xFF9098B1),
        iconPaths: [
          'assets/icons/earth-13-svgrepo-com.svg',
          'assets/icons/trophy-material-7-svgrepo-com.svg',
          'assets/icons/leaf-svgrepo-com.svg',
          'assets/icons/lightning-fill-svgrepo-com.svg',
          'assets/icons/tree-svgrepo-com.svg',
        ],
      ),
    );
  }
}

class CustomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final List<String> iconPaths;

  const CustomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.backgroundColor,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.iconPaths,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 10.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          height: 80.h,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 16,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: List.generate(iconPaths.length, (index) {
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10.h),
                      SizedBox(
                        height: 24.h,
                        width: 50.w,
                        child: SvgPicture.asset(
                          iconPaths[index],
                          fit: BoxFit.contain,
                          colorFilter: ColorFilter.mode(
                            currentIndex == index
                                ? selectedItemColor
                                : unselectedItemColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 2.h,
                        width: 60.w,
                        color: currentIndex == index
                            ? selectedItemColor
                            : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
