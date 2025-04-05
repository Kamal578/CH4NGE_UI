import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DraggableBottomSheet extends StatefulWidget {
  final Widget Function(BuildContext, double) builder;
  final double minHeightRatio;
  final Color backgroundColor;
  final String headerText;
  final BorderRadiusGeometry borderRadius;
  final BoxShadow shadow;

  const DraggableBottomSheet({
    super.key,
    required this.builder,
    this.headerText = '',
    this.minHeightRatio = 0.25,
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
  late String headerText;
  final double _maxHeightRatio = 0.95;

  @override
  void initState() {
    super.initState();
    headerText = widget.headerText;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _controller.value = 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    final screenHeight = MediaQuery.of(context).size.height;
    final delta = details.primaryDelta!;
    final deltaFraction = delta / (screenHeight * (_maxHeightRatio - widget.minHeightRatio));
    _controller.value = (_controller.value - deltaFraction).clamp(0.0, 1.0);
  }

  void _handleDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity.abs() > 1000) {
      velocity < 0 ? _controller.animateTo(1) : _controller.animateTo(0);
    } else {
      _controller.value > 0.5 ? _controller.animateTo(1) : _controller.animateTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final heightRatio = widget.minHeightRatio + 
            (_maxHeightRatio - widget.minHeightRatio) * _controller.value;

        return Stack(
          children: [
            // Draggable sheet
            Positioned(
              top: screenHeight * (1 - heightRatio) - 32.h,
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
                      Center(child: _buildDragHandle()),
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
                      SizedBox(height: 8.h),
                      Expanded(
                        child: widget.builder(context, heightRatio),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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