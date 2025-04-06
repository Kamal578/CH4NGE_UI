import 'package:ch4nge/core/utils/validation_functions.dart';
import 'package:ch4nge/features/layers/presentation/screens/authentication/bloc/auth_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  final VoidCallback show;
  const SignInPage({super.key, required this.show});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Container(
          width: double.maxFinite,
          padding:
              // Platform.isIOS
              //     ? EdgeInsets.zero : // Use only SafeArea's padding on iOS
              EdgeInsets.only(
            // Add custom padding on Android
            left: 16.h,
            top: 68.h,
            right: 16.h,
          ),
          child: Column(
            children: [
              _buildLogo(),
              SizedBox(height: 16.h),
              Text(
                "Welcome!",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Sign in to continue",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 112, 112, 112),
                ),
              ), // Modify theme later
              SizedBox(height: 18.h),
              _emailInput(emailController),
              SizedBox(height: 10.h),
              _passwordInput(passwordController),
              SizedBox(height: 12.h),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthRequestSuccessState) {
                    state.response.fold((left) {
                      emailController.text = '';
                      passwordController.text = '';
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
                        backgroundColor:  Colors.red,
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
                      context.go('/');
                    });
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return Stack(
                      children: [
                        _signInButton(emailController, passwordController),
                        Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  }
                  if (state is AuthInitState) {
                    return _signInButton(emailController, passwordController);
                  }
                  if (state is AuthRequestSuccessState) {
                    Widget widget = Text('');
                    state.response.fold((l) {
                      widget =
                          _signInButton(emailController, passwordController);
                    }, (r) {
                      widget = Text('');
                    });
                    return widget;
                  }
                  return Text('');
                },
              ),
              const Expanded(child: SizedBox()),
              _signUpGestureDetector(context),
              SizedBox(height: 20.h)
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: SizedBox(
        width: 200,
        height: 150,
        child: Image.asset('assets/images/logo.jpeg'),
      ),
    );
  }

  Widget _emailInput(TextEditingController emailController) {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: const Icon(Icons.mail_outline),
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 16.h,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(128, 144, 152, 177),
            width: 1.h,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: const Color(0xFF9098B1),
            width: 1.5,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
      ),
      validator: (value) {
        if (value == null || (!EmailValidator.validate(value))) {
          return "Please enter valid email";
        }
        return null;
      },
    );
  }

  Widget _passwordInput(TextEditingController passwordController) {
    return TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
        hintText: 'Password',
        prefixIcon: const Icon(Icons.lock_outline),
        contentPadding: EdgeInsets.fromLTRB(
          16.h,
          12.h,
          10.h,
          12.h,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(128, 144, 152, 177),
            width: 1.h,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: const Color(0xFF9098B1),
            width: 1.5,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFF9098B1),
          ),
          onPressed: () {
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        ),
        errorMaxLines: 3,
      ),
      obscureText: passwordVisible,
    );
  }

  Widget _signInButton(TextEditingController emailController,
      TextEditingController passwordController) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          BlocProvider.of<AuthBloc>(context).add(
              AuthLoginRequest(emailController.text, passwordController.text));
        }
      },
      style: ElevatedButton.styleFrom(
        elevation: 3,
        backgroundColor: const Color(0xFF7DD334),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.h),
        ),
        padding: EdgeInsets.all(20.h),
        fixedSize: Size(double.maxFinite, 50.h),
      ),
      child: Text(
        "Sign In",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _signUpGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: widget.show,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an account? ',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 144, 152, 177),
              ),
            ),
            const TextSpan(text: " "),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF7DD334),
              ),
            ),
          ],
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
