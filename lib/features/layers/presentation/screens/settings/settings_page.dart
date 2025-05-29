import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/features/layers/domain/use_cases/get_user.dart';
import 'package:ch4nge/features/layers/presentation/screens/authentication/bloc/auth_bloc.dart';
import 'package:ch4nge/features/layers/presentation/widgets/custom_appbar.dart';
import 'package:ch4nge/features/layers/presentation/widgets/small_user_card.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
    required this.getUserUseCase,
  });

  final GetUserUseCase getUserUseCase;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? _selectedImagePath;
  String? _profilePicUrl;
  final ImagePicker _picker = ImagePicker();
  bool _isUploadingImage = false;
  final userId = AuthManager.getId();
  final username = AuthManager.getUsername();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final profilePicUrl = await widget.getUserUseCase(userId).fold(
        (failure) {
          debugPrint('Error: $failure');
          return null;
        },
        (userEntity) => userEntity.profilePicUrl.isEmpty
            ? 'assets/images/user_profile.png'
            : userEntity.profilePicUrl,
      );

      setState(() {
        _profilePicUrl = profilePicUrl;
        _selectedImagePath = null; // Reset selected image path
        _isUploadingImage = false; // Set loading to false after data is loaded
      });
    } catch (e) {
      setState(() => _isUploadingImage = false);
      debugPrint('Error loading data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data. Please try again.')),
      );
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Update Profile Picture',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _buildImageSourceOption(
                      icon: Icons.photo_library_rounded,
                      title: 'Choose from Gallery',
                      subtitle: 'Select a photo from your gallery',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImageFromGallery();
                      },
                    ),
                    SizedBox(height: 12.h),
                    _buildImageSourceOption(
                      icon: Icons.camera_alt_rounded,
                      title: 'Take Photo',
                      subtitle: 'Capture a new photo with camera',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImageFromCamera();
                      },
                    ),
                    if (_selectedImagePath != null) ...[
                      SizedBox(height: 12.h),
                      _buildImageSourceOption(
                        icon: Icons.delete_rounded,
                        title: 'Remove Photo',
                        subtitle: 'Use default profile picture',
                        onTap: () {
                          Navigator.pop(context);
                          _removeProfilePicture();
                        },
                        isDestructive: true,
                      ),
                    ],
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isDestructive
                    ? Colors.red[50]
                    : Color.fromARGB(255, 125, 211, 52).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: isDestructive
                    ? Colors.red
                    : Color.fromARGB(255, 125, 211, 52),
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isDestructive ? Colors.red : Colors.black,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.sp,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        await _processSelectedImage(image.path);
      }
    } catch (e) {
      _showErrorSnackBar('Failed to select image from gallery.');
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        await _processSelectedImage(image.path);
      }
    } catch (e) {
      _showErrorSnackBar('Failed to capture image from camera.');
    }
  }

  Future<void> _processSelectedImage(String imagePath) async {
    setState(() {
      _selectedImagePath = imagePath;
      _isUploadingImage = true;
    });

    try {
      // Here you would typically upload the image to your server
      // For now, we'll simulate the upload process
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isUploadingImage = false;
      });

      _showSuccessSnackBar('Profile picture updated successfully!');
    } catch (e) {
      setState(() {
        _isUploadingImage = false;
        _selectedImagePath = null;
      });
      _showErrorSnackBar('Failed to upload profile picture. Please try again.');
    }
  }

  void _removeProfilePicture() {
    setState(() {
      _selectedImagePath = null;
    });
    _showSuccessSnackBar('Profile picture removed successfully!');
  }

  void _showSuccessSnackBar(String message) {
    final snackbar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontFamily: 'dana',
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 125, 211, 52),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void _showErrorSnackBar(String message) {
    final snackbar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontFamily: 'dana',
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildCustomAppbarWidget(context),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16.h,
              right: 16.h,
            ),
            child: Column(
              children: [
                SizedBox(height: 8.h),
                Stack(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: MySmallUserCard(
                        cardColor: Color.fromARGB(255, 125, 211, 52),
                        backgroundMotifColor: Colors.white,
                        userName: username,
                        userProfilePicUrl: _profilePicUrl,
                        onTap: _showImageSourceDialog,
                      ),
                    ),
                    if (_isUploadingImage)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(
                                    color: Color.fromARGB(255, 125, 211, 52),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Uploading...',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 16.h),
                _buildProfilePictureSettings(),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthRequestSuccessState) {
                      state.response.fold((left) {
                        var snackbar = SnackBar(
                          content: Text(
                            left,
                            style: TextStyle(
                              fontFamily: 'dana',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          duration: const Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }, (right) {
                        context.go('/auth');
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoadingState) {
                      return Stack(
                        children: [
                          _accountSettings(context),
                          Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    }
                    if (state is AuthInitState) {
                      return _accountSettings(context);
                    }
                    if (state is AuthRequestSuccessState) {
                      Widget widget = Text('');
                      state.response.fold((l) {
                        widget = _accountSettings(context);
                      }, (r) {
                        widget = Text('');
                      });
                      return widget;
                    }
                    return Text('');
                  },
                ),
                _otherSettings(context),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePictureSettings() {
    return SizedBox(
      width: double.maxFinite,
      child: SettingsGroup(
        backgroundColor: Colors.grey[50],
        settingsGroupTitle: 'Profile Settings',
        settingsGroupTitleStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        items: [
          SettingsItem(
            icons: Icons.photo_camera_rounded,
            iconStyle: IconStyle(
                iconsColor: Color.fromARGB(255, 125, 211, 52),
                backgroundColor: Colors.white),
            title: 'Update Profile Picture',
            titleStyle: settingsItemTitleStyle,
            subtitleStyle: settingsItemSubtitleStyle,
            onTap: _showImageSourceDialog,
          ),
        ],
      ),
    );
  }

  _buildCustomAppbarWidget(BuildContext context) {
    return CustomAppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          context.pop();
        },
        child: Icon(
          Icons.arrow_back_rounded,
          size: 24.sp,
          weight: 54,
        ),
      ),
      actions: [],
    );
  }

  Widget _accountSettings(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: SettingsGroup(
        backgroundColor: Colors.grey[50],
        settingsGroupTitle: 'Account Settings',
        settingsGroupTitleStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        items: [
          SettingsItem(
            icons: Icons.logout_rounded,
            iconStyle: IconStyle(
                iconsColor: Color.fromARGB(255, 125, 211, 52),
                backgroundColor: Colors.white),
            title: 'Sign Out',
            titleStyle: settingsItemTitleStyle,
            onTap: () {
              BlocProvider.of<AuthBloc>(context).add(AuthLogoutRequest());
            },
          ),
        ],
      ),
    );
  }

  Widget _otherSettings(BuildContext content) {
    return SizedBox(
      width: double.maxFinite,
      child: SettingsGroup(
        backgroundColor: Colors.grey[50],
        settingsGroupTitle: 'Other',
        settingsGroupTitleStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        items: [
          SettingsItem(
            icons: Icons.info_rounded,
            iconStyle: IconStyle(
                iconsColor: Color.fromARGB(255, 125, 211, 52),
                backgroundColor: Colors.white),
            title: 'About',
            titleStyle: settingsItemTitleStyle,
            subtitle: 'Learn more about the app',
            subtitleStyle: settingsItemSubtitleStyle,
            onTap: () {},
          ),
          SettingsItem(
            icons: Icons.help_rounded,
            iconStyle: IconStyle(
                iconsColor: Color.fromARGB(255, 125, 211, 52),
                backgroundColor: Colors.white),
            title: 'Help & Support',
            titleStyle: settingsItemTitleStyle,
            subtitle: 'Contact with us if you have any questions',
            subtitleStyle: settingsItemSubtitleStyle,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

TextStyle settingsItemTitleStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 12.sp,
  color: Colors.black,
  fontWeight: FontWeight.w700,
  letterSpacing: .0,
  wordSpacing: .0,
);

TextStyle settingsItemSubtitleStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 10.sp,
  color: const Color.fromARGB(128, 144, 152, 177),
  fontWeight: FontWeight.w500,
  letterSpacing: .0,
  wordSpacing: .0,
);
