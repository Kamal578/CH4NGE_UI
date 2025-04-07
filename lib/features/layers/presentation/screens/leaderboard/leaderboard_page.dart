import 'package:ch4nge/features/layers/presentation/widgets/custom_appbar.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_navbar.dart';
import 'package:ch4nge/features/layers/presentation/widgets/draggable_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final List<LeaderboardEntry> leaderboardData = [
    LeaderboardEntry(rank: 1, name: 'Lynn Mcclain', points: 40),
    LeaderboardEntry(rank: 2, name: 'Marsha Fisheeeeeeeeer', points: 39),
    LeaderboardEntry(rank: 3, name: 'Juanita Cormier', points: 38),
    LeaderboardEntry(rank: 4, name: 'Marsha Fisher', points: 36),
    LeaderboardEntry(rank: 5, name: 'Juanita Cormier', points: 35),
    LeaderboardEntry(rank: 6, name: 'You', points: 34, isCurrentUser: true),
    LeaderboardEntry(rank: 7, name: 'Tamara Schmidt', points: 33),
    LeaderboardEntry(rank: 8, name: 'Ricardo Veum', points: 32),
    LeaderboardEntry(rank: 9, name: 'Gary Sanford', points: 31),
    LeaderboardEntry(rank: 10, name: 'Lynn Mcclain', points: 30),
    LeaderboardEntry(rank: 11, name: 'Lynn Mcclain', points: 30),
    LeaderboardEntry(rank: 12, name: 'Lynn Mcclain', points: 30),
    LeaderboardEntry(rank: 13, name: 'Lynn Mcclain', points: 30),
    LeaderboardEntry(rank: 14, name: 'Lynn Mcclain', points: 30),
    LeaderboardEntry(rank: 15, name: 'Lynn Mcclain', points: 30),
  ];

  @override
  Widget build(BuildContext context) {
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

  _buildTitleWidget() {
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
                padding: EdgeInsets.only(top: 40.h), // Push down from top
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
                padding: EdgeInsets.only(top: 40.h), // Push down from top
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

  _buildCustomNavbarWidget() {
    return CustomBottomNavBar(
      selectedIndex: 1,
    );
  }

  _buildCustomAppbarWidget() {
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

// 2. Data Model
class LeaderboardEntry {
  final int rank;
  final String name;
  final int points;
  final bool isCurrentUser;

  LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.points,
    this.isCurrentUser = false,
  });
}

// 3. Individual Item Widget
class LeaderboardItem extends StatelessWidget {
  final LeaderboardEntry entry;
  final Color? backgroundColor;
  final Color currentUserHighlight;
  final TextStyle? textStyle;
  final Color? textColor;

  const LeaderboardItem({
    super.key,
    required this.entry,
    this.backgroundColor = Colors.white,
    this.currentUserHighlight = const Color.fromARGB(255, 125, 211, 52),
    this.textColor = Colors.black,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    Color? textColor = entry.isCurrentUser ? Colors.white : this.textColor;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: entry.isCurrentUser ? currentUserHighlight : backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Text(
            '${entry.rank}',
            style: textStyle?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ) ??
                TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(width: 20),
          CircleAvatar(
            radius: 16.r,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              color: Colors.black,
              size: 16.r,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              entry.name,
              style: textStyle?.copyWith(
                    color: textColor,
                    fontWeight:
                        entry.isCurrentUser ? FontWeight.w600 : FontWeight.w500,
                  ) ??
                  TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight:
                        entry.isCurrentUser ? FontWeight.w600 : FontWeight.w500,
                  ),
            ),
          ),
          Text(
            '${entry.points} pts',
            style: textStyle?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ) ??
                TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

// 4. List Widget
class LeaderboardList extends StatelessWidget {
  final List<LeaderboardEntry> entries;
  final Color? separatorColor;
  final double separatorHeight;

  const LeaderboardList({
    super.key,
    required this.entries,
    this.separatorColor,
    this.separatorHeight = 1,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: entries.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 8.h,
      ),
      itemBuilder: (context, index) {
        return LeaderboardItem(
          entry: entries[index],
        );
      },
    );
  }
}

// Top User Container
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
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 16.r,
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
