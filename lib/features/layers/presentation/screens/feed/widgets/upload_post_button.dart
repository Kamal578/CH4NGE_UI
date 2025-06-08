import 'dart:io';

import 'package:ch4nge/features/layers/presentation/screens/feed/widgets/upload_post_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadPostButton extends StatelessWidget {
  final Function(String comment, File? imageData) onUpload;

  const UploadPostButton({
    super.key,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF7DD334),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.2 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: IconButton(
          icon: Icon(Icons.add_rounded),
          color: Colors.white,
          onPressed: () {
            _showUploadSheet(context);
          },
        ),
      ),
    );
  }

  void _showUploadSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: UploadPostSheet(onUpload: onUpload),
        );
      },
    );
  }
}