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
    return SizedBox(
      height: 75.h,
      child: Stack(
        children: [
          // Background container
          Container(
            height: 75.h,
            color: Colors.white,
          ),
          // Floating navbar container
          Container(
            height: 80.h,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: CustomNavbar(
              currentIndex: _currentIndex,
              onTap: _onItemTapped,
              backgroundColor: Colors.white,
              selectedItemColor: const Color.fromARGB(255, 125, 211, 52),
              unselectedItemColor: const Color.fromARGB(255, 144, 152, 177),
              iconPaths: [
                'assets/icons/earth-13-svgrepo-com.svg',
                'assets/icons/trophy-material-7-svgrepo-com.svg',
                'assets/icons/leaf-svgrepo-com.svg',
                'assets/icons/lightning-fill-svgrepo-com.svg',
                'assets/icons/tree-svgrepo-com.svg',
              ],
            ),
          ),
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
      height: 75.h,
      padding: EdgeInsets.symmetric(vertical: 5.h),
      color: backgroundColor,
      child: Row(
        children: List.generate(iconPaths.length, (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 24.h,
                    width: 50.w, // Assigns equal maximum width to all icons
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
                  SizedBox(height: 8.h), // Adds spacing
                  Container(
                    height: 2.h,
                    width:
                        50.w, // Ensures underline width matches the icon width
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
    );
  }
}
