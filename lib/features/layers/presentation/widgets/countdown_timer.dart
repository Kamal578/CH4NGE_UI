import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeeklyCountdownTimer extends StatefulWidget {
  final TextStyle? textStyle;
  final bool showLabels;

  const WeeklyCountdownTimer({
    super.key,
    this.textStyle,
    this.showLabels = true,
  });

  @override
  State<WeeklyCountdownTimer> createState() => _WeeklyCountdownTimerState();
}

class _WeeklyCountdownTimerState extends State<WeeklyCountdownTimer> {
  late Timer _timer;
  late Duration _remainingTime;

  @override
  void initState() {
    super.initState();
    _remainingTime = _calculateTimeUntilWeekEnd();
    _startTimer();
  }

  Duration _calculateTimeUntilWeekEnd() {
    final now = DateTime.now();
    final daysUntilSunday = (DateTime.sunday - now.weekday + 7) % 7;
    final weekEnd = DateTime(
      now.year,
      now.month,
      now.day + daysUntilSunday,
      23,
      59,
      59,
    );
    return weekEnd.difference(now);
  }

  void _startTimer() {
    final now = DateTime.now();
    final nextMinute = DateTime(now.year, now.month, now.day, now.hour, now.minute + 1);
    final initialDelay = nextMinute.difference(now);

    _timer = Timer(initialDelay, () {
      setState(() => _remainingTime = _calculateTimeUntilWeekEnd());
      _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
        setState(() => _remainingTime = _calculateTimeUntilWeekEnd());
      });
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);

    return "${twoDigits(days)} : ${twoDigits(hours)} : ${twoDigits(minutes)}";
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: widget.showLabels
          ? _buildTimerWithLabels()
          : Text(
              _formatDuration(_remainingTime),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
            ),
    );
  }

  Widget _buildTimerWithLabels() {
    final parts = _formatDuration(_remainingTime).split(' : ');
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTimeUnit(parts[0], 'days'),
        const Text(' : '),
        _buildTimeUnit(parts[1], 'hours'),
        const Text(' : '),
        _buildTimeUnit(parts[2], 'min'),
      ],
    );
  }

  Widget _buildTimeUnit(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: widget.textStyle ??
              TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}