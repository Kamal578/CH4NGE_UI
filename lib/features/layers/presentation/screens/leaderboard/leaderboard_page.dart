import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_all_users.dart';
import 'package:ch4nge/features/layers/presentation/screens/leaderboard/widgets/leaderboard_entry.dart';
import 'package:ch4nge/features/layers/presentation/screens/leaderboard/widgets/leaderboard_list.dart';
import 'package:ch4nge/features/layers/presentation/screens/leaderboard/widgets/top_user_container.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_appbar.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_navbar.dart';
import 'package:ch4nge/features/layers/presentation/widgets/draggable_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({
    super.key,
    required this.getAllUsersUseCase,
  });

  final GetAllUsersUseCase getAllUsersUseCase;

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final String userId = AuthManager.getId();
  List<LeaderboardEntry> leaderboardData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final users = await widget.getAllUsersUseCase();
      List<LeaderboardEntry> leaderboardData = convertToLeaderboard(
        users.right,
        userId,
      );
      setState(() {
        this.leaderboardData = leaderboardData;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint('Error loading data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildCustomAppbarWidget(),
      bottomNavigationBar: _buildCustomNavbarWidget(),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            _buildTitleWidget(),
            if (leaderboardData.isNotEmpty) _buildTopUserWidget(),
            LeaderboardSheet(
              entries: leaderboardData.length > 3 
                ? leaderboardData.sublist(3) 
                : [],
              hasEnoughUsers: leaderboardData.length > 3,
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildTitleWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.maxFinite,
        height: 32.h,
        color: Colors.white,
        alignment: Alignment.centerLeft,
        child: Text(
          "Leaderboard",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildTopUserWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Second place (left)
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: leaderboardData.length > 1
                  ? TopUserContainer(entry: leaderboardData[1])
                  : _buildPlaceholderContainer("2nd"),
              ),
            ),
          ),

          // First place (center)
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: leaderboardData.isNotEmpty
                ? TopUserContainer(entry: leaderboardData[0])
                : _buildPlaceholderContainer("1st"),
            ),
          ),

          // Third place (right)
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: leaderboardData.length > 2
                  ? TopUserContainer(entry: leaderboardData[2])
                  : _buildPlaceholderContainer("3rd"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderContainer(String position) {
    return Container(
      width: 80.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_outline,
            size: 32.sp,
            color: Colors.grey[400],
          ),
          SizedBox(height: 4.h),
          Text(
            position,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  CustomBottomNavBar _buildCustomNavbarWidget() {
    return CustomBottomNavBar(
      selectedIndex: 1,
    );
  }

  CustomAppBar _buildCustomAppbarWidget() {
    return CustomAppBar(
      backgroundColor: Colors.white,
    );
  }
}

// 1. Draggable Bottom Sheet
class LeaderboardSheet extends StatelessWidget {
  final List<LeaderboardEntry> entries;
  final bool hasEnoughUsers;

  const LeaderboardSheet({
    super.key,
    required this.entries,
    required this.hasEnoughUsers,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      minHeightRatio: 0.60,
      maxHeightRatio: 0.95,
      backgroundColor: Color.fromARGB(255, 178, 253, 112),
      borderColor: Color.fromARGB(255, 178, 253, 112),
      dragHandleColor: Colors.white,
      shadow: BoxShadow(),
      builder: (context, sheetPosition) {
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h),
              if (hasEnoughUsers)
                LeaderboardList(
                  entries: entries,
                  separatorColor: Colors.grey[300],
                  separatorHeight: 0.5,
                )
              else
                _buildPlaceholderContent(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlaceholderContent() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.emoji_events_outlined,
            size: 64.sp,
            color: Colors.white.withValues(alpha: 0.7),
          ),
          SizedBox(height: 16.h),
          Text(
            "More competitors needed!",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            "Invite more friends to see the full leaderboard",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}