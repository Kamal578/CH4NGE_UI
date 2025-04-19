import 'package:ch4nge/features/layers/presentation/screens/leaderboard/widgets/leaderboard_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          SizedBox(
            width: 20.w,
            child: Text(
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
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              entry.profilePicUrl,
              fit: BoxFit.cover,
              width: 24.w,
              height: 24.h,
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
