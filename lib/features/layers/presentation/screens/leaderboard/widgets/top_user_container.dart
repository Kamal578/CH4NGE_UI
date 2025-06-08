import 'package:ch4nge/features/layers/presentation/screens/leaderboard/widgets/leaderboard_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopUserContainer extends StatelessWidget {
  final LeaderboardEntry entry;

  const TopUserContainer({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.h,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 45.r,
                    backgroundColor: Color(0xFF7DD334),
                    child: CircleAvatar(
                      radius: 42.r,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: (entry.profilePicUrl.isEmpty)
                            ? Image.asset('assets/images/user_profile.png',
                                fit: BoxFit.fitHeight)
                            : Image.network(
                                entry.profilePicUrl,
                                fit: BoxFit.fitHeight,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/user_profile.png',
                                  );
                                },
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                ],
              ),
              Positioned(
                bottom: 0.h,
                right: 0,
                left: 0,
                child: CircleAvatar(
                  radius: 14.r,
                  backgroundColor: Color(0xFF7DD334),
                  child: Text(
                    '${entry.rank}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            entry.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.eco,
                color: Color(0xFF7DD334),
                size: 20.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                '${entry.points} pts',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
