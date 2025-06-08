import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySmallUserCard extends StatelessWidget {
  final Color? cardColor;
  final double? cardRadius;
  final Color? backgroundMotifColor;
  final VoidCallback? onTap;
  final String? userName;
  final Widget? userMoreInfo;
  final Image? userProfilePic;
  final String? userProfilePicUrl;

  const MySmallUserCard({
    super.key,
    required this.cardColor,
    this.cardRadius = 36,
    required this.userName,
    this.backgroundMotifColor = Colors.white,
    this.userMoreInfo,
    this.userProfilePic,
    this.userProfilePicUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: mediaQueryHeight / 6,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius:
              BorderRadius.circular(double.parse(cardRadius!.toString())),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: backgroundMotifColor!.withValues(alpha: .1),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 400,
                backgroundColor: backgroundMotifColor!.withValues(alpha: .05),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CircleAvatar(
                          radius: mediaQueryHeight / 18,
                          child: userProfilePicUrl == null ||
                                  userProfilePicUrl?.isEmpty == true
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    'assets/images/user_profile.png',
                                    fit: BoxFit.cover,
                                    width: mediaQueryHeight / 9,
                                    height: mediaQueryHeight / 9,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    userProfilePicUrl!,
                                    fit: BoxFit.cover,
                                    width: mediaQueryHeight / 9,
                                    height: mediaQueryHeight / 9,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/user_profile.png',
                                        fit: BoxFit.cover,
                                        width: mediaQueryHeight / 9,
                                        height: mediaQueryHeight / 9,
                                      );
                                    },
                                  ),
                                ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(userName!,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                )),
                            if (userMoreInfo != null) ...[
                              userMoreInfo!,
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
