import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/features/layers/domain/entities/activity_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:ch4nge/features/layers/presentation/widgets/draggable_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendsActivitySheet extends StatelessWidget {
  FriendsActivitySheet({
    super.key,
    required this.activities,
    required this.users,
  });
  final Map<String, List<ActivityEntity>> activities;
  final String username = AuthManager.getUsername();
  late final Map<String, List<ActivityEntity>> filteredActivities;
  late final List<UserEntity> users;

  @override
  Widget build(BuildContext context) {
    filteredActivities = Map.fromEntries(
      activities.entries.where((entry) => entry.key != username),
    );
    
    final totalActivities = filteredActivities.values
        .fold(0, (sum, list) => sum + list.length);
    
    return DraggableBottomSheet(
      minHeightRatio: 0.25,
      backgroundColor: Colors.white,
      headerText: "See Friends' Activities",
      builder: (context, sheetPosition) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              if (totalActivities == 0)
                _buildEmptyState()
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: totalActivities,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8.h,
                  ),
                  itemBuilder: (context, index) {
                    int currentIndex = 0;
                    for (var entry in filteredActivities.entries) {
                      if (index < currentIndex + entry.value.length) {
                        final activity = entry.value[index - currentIndex];
                        return _buildActivityItem(
                          username: entry.key,
                          action: activity.title,
                          points: activity.value,
                        );
                      }
                      currentIndex += entry.value.length;
                    }
                    return const SizedBox.shrink();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.group_outlined,
            size: 48.sp,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16.h),
          Text(
            "No friend activities yet",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "When your friends complete activities,\nthey'll appear here",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[500],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
      {required String username, required String action, required int points}) {
    String profilePicUrl =
        users.firstWhere((user) => user.username == username).profilePicUrl;
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
          backgroundColor: const Color(0xFF7DD334).withValues(alpha: 0.1),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: (profilePicUrl.isEmpty)
                ? Image.asset(
                    'assets/images/user_profile.png',
                    fit: BoxFit.cover,
                    height: 24.h,
                    width: 24.h,
                  )
                : Image.network(
                    profilePicUrl,
                    fit: BoxFit.cover,
                    height: 24.h,
                    width: 24.h,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/user_profile.png',
                      );
                    },
                  ),
          ),
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
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const TextSpan(text: '  '),
              TextSpan(text: action),
            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (points > 0)
              Icon(
                Icons.eco,
                color: const Color(0xFF7DD334),
                size: 20.sp,
              ),
            SizedBox(width: 4.w),
            Text(
              '$points',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: points > 0 ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(width: 8.w),
          ],
        ),
      ),
    );
  }
}