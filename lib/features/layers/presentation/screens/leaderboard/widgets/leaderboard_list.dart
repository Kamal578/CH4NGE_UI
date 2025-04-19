import 'package:ch4nge/features/layers/presentation/screens/leaderboard/widgets/leaderboard_entry.dart';
import 'package:ch4nge/features/layers/presentation/screens/leaderboard/widgets/leaderboard_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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