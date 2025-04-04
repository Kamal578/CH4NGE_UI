import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DraggableBottomSheet extends StatefulWidget {
  final Widget Function(BuildContext, double) builder;
  final double minHeightRatio;
  final double maxHeightRatio;
  final Color backgroundColor;
  final String headerText;
  final BorderRadiusGeometry borderRadius;
  final BoxShadow shadow;

  const DraggableBottomSheet({
    super.key,
    required this.builder,
    this.headerText = '',
    this.minHeightRatio = 0.25,
    this.maxHeightRatio = 0.75,
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.vertical(top: Radius.circular(32)),
    this.shadow = const BoxShadow(
      color: Colors.black26,
      blurRadius: 10,
      spreadRadius: 2,
    ),
  });

  @override
  State<DraggableBottomSheet> createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double _currentPosition;
  late double _minPosition;
  late double _maxPosition;
  late String headerText;

  @override
  void initState() {
    super.initState();
    _currentPosition = widget.minHeightRatio;
    _minPosition = widget.minHeightRatio;
    _maxPosition = widget.maxHeightRatio;
    headerText = widget.headerText;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    final delta = details.primaryDelta! / MediaQuery.of(context).size.height;
    setState(() {
      _currentPosition =
          (_currentPosition - delta).clamp(_minPosition, _maxPosition);
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity.abs() > 1000) {
      _currentPosition = velocity < 0 ? _maxPosition : _minPosition;
    } else {
      _currentPosition = _currentPosition > (_minPosition + _maxPosition) / 2
          ? _maxPosition
          : _minPosition;
    }

    _controller.animateTo(
      _currentPosition,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          top: screenHeight * (1 - _currentPosition) - 32.h,
          left: 0,
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            child: Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: widget.borderRadius,
                boxShadow: [widget.shadow],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: _buildDragHandle(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Text(
                      headerText,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: widget.builder(context, _currentPosition),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDragHandle() {
    return Container(
      width: 40,
      height: 5,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(128, 144, 152, 177),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
