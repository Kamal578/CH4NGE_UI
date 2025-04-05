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
            LeaderboardSheet(entries: leaderboardData),
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

  _buildCustomNavbarWidget() {
    return CustomBottomNavBar(
      selectedIndex: 1,
    );
  }

  _buildCustomAppbarWidget() {
    return CustomAppBar(
      actions: [
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            "assets/icons/notifications_icon.png",
            width: 28.w,
            height: 28.h,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            "assets/icons/settings_icon.png",
            width: 28.w,
            height: 28.h,
          ),
        ),
      ],
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

// 1. Data Model
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

// 2. Individual Item Widget
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

// 3. List Widget
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
