import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class UploadPostSheet extends StatefulWidget {
  final Function(String comment, dynamic imageData) onUpload;
  const UploadPostSheet({super.key, required this.onUpload});

  @override
  UploadPostSheetState createState() => UploadPostSheetState();
}

class UploadPostSheetState extends State<UploadPostSheet> {
  final TextEditingController _commentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Create New Post",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),
          // Photo upload container: shows prompt or the selected image
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: double.infinity,
              height: _image == null ? 200.h : null,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF7DD334), width: 1.5),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: _image == null
                  ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo,
                            size: 20.sp,
                            color: const Color(0xFF7DD334),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "Upload Photo",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: const Color(0xFF7DD334)),
                          ),
                        ],
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _image!,
                        fit: BoxFit.contain,
                      ),
                    ),
            ),
          ),
          SizedBox(height: 16.h),
          // Post comment text field
          TextField(
            controller: _commentController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: "Post Comment",
              labelStyle: TextStyle(fontSize: 16.sp, color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: const Color(0xFF7DD334), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: const Color(0xFF7DD334), width: 1.5),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // Fit Width switch row
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7DD334),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                  ),
                  onPressed: () {
                    widget.onUpload(
                      _commentController.text,
                      _image,
                    );
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Post",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}