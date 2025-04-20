import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.height,
    this.shape,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
    this.backgroundColor,
  });

  final double? height;
  final ShapeBorder? shape;
  final double? leadingWidth;
  final Widget? leading;
  final Widget? title;
  final bool? centerTitle;
  final List<Widget>? actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: backgroundColor,
        leading: leading,
        actions: actions ??
            [
              // GestureDetector(
              //   onTap: () {},
              //   child: Image.asset(
              //     "assets/icons/notifications_icon.png",
              //     width: 28.w,
              //     height: 28.h,
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  context.go('/settings');
                },
                child: Image.asset(
                  "assets/icons/settings_icon.png",
                  width: 28.w,
                  height: 28.h,
                ),
              ),
            ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 56.h);
}
