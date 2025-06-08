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
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildCustomAppbarWidget(),
        bottomNavigationBar: _buildCustomNavbarWidget(),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            _buildTitleWidget(),
            _buildTopUserWidget(),
            LeaderboardSheet(entries: leaderboardData.sublist(3)),
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
        mainAxisAlignment: MainAxisAlignment.center, // Center the main row
        crossAxisAlignment: CrossAxisAlignment.end, // Align items at the bottom
        children: [
          // Second place (left)
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: TopUserContainer(
                  entry: leaderboardData[1],
                ),
              ),
            ),
          ),

          // First place (center)
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: TopUserContainer(
                entry: leaderboardData[0],
              ),
            ),
          ),

          // Third place (right)
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: TopUserContainer(
                  entry: leaderboardData[2],
                ),
              ),
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

  const LeaderboardSheet({
    super.key,
    required this.entries,
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
              LeaderboardList(
                entries: entries,
                separatorColor: Colors.grey[300],
                separatorHeight: 0.5,
              ),
            ],
          ),
        );
      },
    );
  }
}
