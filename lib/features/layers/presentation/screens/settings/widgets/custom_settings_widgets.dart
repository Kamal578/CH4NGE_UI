// custom_settings_group.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSettingsGroup extends StatelessWidget {
  final String settingsGroupTitle;
  final TextStyle? settingsGroupTitleStyle;
  final Color? backgroundColor;
  final List<Widget> items;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const CustomSettingsGroup({
    super.key,
    required this.settingsGroupTitle,
    required this.items,
    this.settingsGroupTitleStyle,
    this.backgroundColor,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin ?? EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Group Title
          Padding(
            padding: EdgeInsets.only(left: 12.w, bottom: 6.h),
            child: Text(
              settingsGroupTitle,
              style: settingsGroupTitleStyle ??
                  TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
            ),
          ),
          // Settings Items Container
          Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.grey[50],
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: Colors.grey[200]!,
                width: 0.5,
              ),
            ),
            child: Column(
              children: _buildItemsWithDividers(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildItemsWithDividers() {
    List<Widget> widgets = [];
    
    for (int i = 0; i < items.length; i++) {
      widgets.add(items[i]);
      
      // Add divider between items (but not after the last item)
      if (i < items.length - 1) {
        widgets.add(
          Divider(
            height: 0.5,
            thickness: 0.5,
            color: Colors.grey[200],
            indent: 12.w,
            endIndent: 12.w,
          ),
        );
      }
    }
    
    return widgets;
  }
}

// custom_settings_item.dart
class IconStyle {
  final Color iconsColor;
  final Color backgroundColor;
  final double? iconSize;
  final EdgeInsets? padding;

  const IconStyle({
    required this.iconsColor,
    required this.backgroundColor,
    this.iconSize,
    this.padding,
  });
}

class CustomSettingsItem extends StatelessWidget {
  final IconData icons;
  final IconStyle? iconStyle;
  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showArrow;
  final EdgeInsets? padding;

  const CustomSettingsItem({
    super.key,
    required this.icons,
    required this.title,
    this.iconStyle,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.onTap,
    this.trailing,
    this.showArrow = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Row(
          children: [
            // Icon Container
            if (iconStyle != null) ...[
              Container(
                padding: iconStyle!.padding ?? EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: iconStyle!.backgroundColor,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  icons,
                  color: iconStyle!.iconsColor,
                  size: iconStyle!.iconSize ?? 16.sp,
                ),
              ),
              SizedBox(width: 12.w),
            ] else ...[
              Icon(
                icons,
                size: 16.sp,
                color: Colors.grey[600],
              ),
              SizedBox(width: 12.w),
            ],
            
            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: titleStyle ??
                        TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 1.h),
                    Text(
                      subtitle!,
                      style: subtitleStyle ??
                          TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ],
              ),
            ),
            
            // Trailing Widget or Arrow
            if (trailing != null) ...[
              SizedBox(width: 6.w),
              trailing!,
            ] else if (showArrow && onTap != null) ...[
              SizedBox(width: 6.w),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 12.sp,
                color: Colors.grey[400],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Extension to maintain backward compatibility with your existing code
extension SettingsGroupAlias on CustomSettingsGroup {
  static Widget create({
    required String settingsGroupTitle,
    required List<Widget> items,
    TextStyle? settingsGroupTitleStyle,
    Color? backgroundColor,
    EdgeInsets? margin,
    EdgeInsets? padding,
  }) {
    return CustomSettingsGroup(
      settingsGroupTitle: settingsGroupTitle,
      items: items,
      settingsGroupTitleStyle: settingsGroupTitleStyle,
      backgroundColor: backgroundColor,
      margin: margin,
      padding: padding,
    );
  }
}

extension SettingsItemAlias on CustomSettingsItem {
  static Widget create({
    required IconData icons,
    required String title,
    IconStyle? iconStyle,
    TextStyle? titleStyle,
    String? subtitle,
    TextStyle? subtitleStyle,
    VoidCallback? onTap,
    Widget? trailing,
    bool showArrow = true,
    EdgeInsets? padding,
  }) {
    return CustomSettingsItem(
      icons: icons,
      title: title,
      iconStyle: iconStyle,
      titleStyle: titleStyle,
      subtitle: subtitle,
      subtitleStyle: subtitleStyle,
      onTap: onTap,
      trailing: trailing,
      showArrow: showArrow,
      padding: padding,
    );
  }
}