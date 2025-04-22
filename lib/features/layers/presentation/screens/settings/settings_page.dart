import 'package:ch4nge/features/layers/presentation/widgets/custom_appbar.dart';
import 'package:ch4nge/features/layers/presentation/widgets/small_user_card.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildCustomAppbarWidget(context),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16.h,
            right: 16.h,
          ),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              SizedBox(
                width: double.maxFinite,
                child: MySmallUserCard(
                  cardColor: Color.fromARGB(255, 125, 211, 52),
                  backgroundMotifColor: Colors.white,
                  userName: 'Kamal Ahmadov',
                  userProfilePicUrl:
                      'https://media.licdn.com/dms/image/v2/D4E03AQGmDNSQfbfNyA/profile-displayphoto-shrink_800_800/B4EZRLVsZ5HsAg-/0/1736430768821?e=1749081600&v=beta&t=07-DpvjdQwq44Z5hByz1y8S0nppacCm1b6RNsbA6THE',
                  onTap: () {},
                ),
              ),
              // _applicationSettings(context),
              _accountSettings(context),
              _otherSettings(context),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }

  _buildCustomAppbarWidget(BuildContext context) {
    return CustomAppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          context.go('/');
        },
        child: Icon(
          Icons.arrow_back_rounded,
          size: 24.sp,
          weight: 54,
        ),
      ),
      actions: [],
    );
  }

  Widget _applicationSettings(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: SettingsGroup(
        backgroundColor: Colors.grey[50],
        settingsGroupTitle: 'Application Settings',
        settingsGroupTitleStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        items: [
          SettingsItem(
            icons: Icons.notifications_rounded,
            iconStyle: IconStyle(
                iconsColor: Color.fromARGB(255, 125, 211, 52),
                backgroundColor: Colors.white),
            title: 'Notifications',
            titleStyle: settingsItemTitleStyle,
            subtitle: 'Modify you notifications settings',
            subtitleStyle: settingsItemSubtitleStyle,
          ),
        ],
      ),
    );
  }

  Widget _accountSettings(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: SettingsGroup(
        backgroundColor: Colors.grey[50],
        settingsGroupTitle: 'Account Settings',
        settingsGroupTitleStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        items: [
          // SettingsItem(
          //   icons: Icons.lock_rounded,
          //   iconStyle: IconStyle(
          //       iconsColor: Color.fromARGB(255, 125, 211, 52),
          //       backgroundColor: Colors.white),
          //   title: 'Reset Password',
          //   titleStyle: settingsItemTitleStyle,
          //   onTap: () {
          //     context.go('/change_password');
          //   },
          // ),
          SettingsItem(
              icons: Icons.logout_rounded,
              iconStyle: IconStyle(
                  iconsColor: Color.fromARGB(255, 125, 211, 52),
                  backgroundColor: Colors.white),
              title: 'Sign Out',
              titleStyle: settingsItemTitleStyle,
              onTap: () {
                context.go('/sign_in');
              }),
        ],
      ),
    );
  }

  Widget _otherSettings(BuildContext content) {
    return SizedBox(
      width: double.maxFinite,
      child: SettingsGroup(
        backgroundColor: Colors.grey[50],
        settingsGroupTitle: 'Other',
        settingsGroupTitleStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        items: [
          SettingsItem(
            icons: Icons.info_rounded,
            iconStyle: IconStyle(
                iconsColor: Color.fromARGB(255, 125, 211, 52),
                backgroundColor: Colors.white),
            title: 'About',
            titleStyle: settingsItemTitleStyle,
            subtitle: 'Learn more about the app',
            subtitleStyle: settingsItemSubtitleStyle,
            onTap: () {},
          ),
          SettingsItem(
            icons: Icons.help_rounded,
            iconStyle: IconStyle(
                iconsColor: Color.fromARGB(255, 125, 211, 52),
                backgroundColor: Colors.white),
            title: 'Help & Support',
            titleStyle: settingsItemTitleStyle,
            subtitle: 'Contact with us if you have any questions',
            subtitleStyle: settingsItemSubtitleStyle,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

TextStyle settingsItemTitleStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 12.sp,
  color: Colors.black,
  fontWeight: FontWeight.w700,
  letterSpacing: .0,
  wordSpacing: .0,
);

TextStyle settingsItemSubtitleStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 10.sp,
  color: const Color.fromARGB(128, 144, 152, 177),
  fontWeight: FontWeight.w500,
  letterSpacing: .0,
  wordSpacing: .0,
);
