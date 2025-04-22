import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/features/layers/domain/entities/activity_entity.dart';
import 'package:ch4nge/features/layers/domain/entities/user_entity.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_friends.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_friends_activities.dart';
import 'package:ch4nge/features/layers/presentation/screens/map/widgets/friends_activity_sheet.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_appbar.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_navbar.dart';
import 'package:ch4nge/features/layers/presentation/screens/map/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
    required this.getFriendsActivitiesUseCase,
    required this.getFriendsUseCase,
  });

  final GetFriendsUseCase getFriendsUseCase;
  final GetFriendsActivitiesUseCase getFriendsActivitiesUseCase;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final String userId = AuthManager.getId();
  List<UserEntity>? users = [];
  Map<String, List<ActivityEntity>>? activities = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final users = await widget.getFriendsUseCase(userId);

      final userIdToUsername = {
        for (final user in users) user.userId: user.username,
      };

      final userIds = userIdToUsername.keys.toList();
      final activities = await widget.getFriendsActivitiesUseCase(userIds);

      final Map<String, List<ActivityEntity>> result = {};

      for (final activity in activities) {
        final username = userIdToUsername[activity.userId] ?? 'Unknown';

        result.putIfAbsent(username, () => []).add(activity);
      }

      setState(() {
        this.users = users;
        this.activities = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint('Error loading data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load data. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildCustomAppbarWidget(),
        bottomNavigationBar: _buildCustomNavbarWidget(),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            GHGMap(users: users!, activities: activities!),
            _buildTitleWidget(),
            FriendsActivitySheet(users: users!, activities: activities!),
          ],
        ),
      ),
    );
  }

  _buildTitleWidget() {
    return Container(
      padding: EdgeInsets.only(bottom: 12.h),
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
      child: Padding(
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
    );
  }
}
