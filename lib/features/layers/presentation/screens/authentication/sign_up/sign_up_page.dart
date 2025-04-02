import 'package:ch4nge/features/layers/presentation/screens/authentication/bloc/auth_bloc.dart';
import 'package:ch4nge/features/layers/presentation/screens/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback show;
  const SignUpPage({super.key, required this.show});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16.h),
              Text("Let's Get Started!", style: TextStyle(fontSize: 16)),
              SizedBox(height: 8.h),
              Text("Create a new account", style: TextStyle(fontSize: 12)),
              SizedBox(height: 18.h),
              _usernameInput(usernameController),
              SizedBox(height: 8.h),
              _emailInput(emailController),
              SizedBox(height: 8.h),
              _passwordInput(passwordController),
              SizedBox(height: 8.h),
              _confirmPasswordSection(confirmPasswordController),
              SizedBox(height: 8.h),
              BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthInitState) {
                    return _signUpButton(usernameController, emailController,
                        passwordController, confirmPasswordController);
                  }
                  if (state is AuthLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is AuthRequestSuccessState) {
                    return state.response.fold(
                      (left) => _signUpButton(
                          usernameController,
                          emailController,
                          passwordController,
                          confirmPasswordController),
                      (right) => Text(right),
                    );
                  }
                  return _signUpButton(usernameController, emailController,
                      passwordController, confirmPasswordController);
                },
                listener: (context, state) {
                  if (state is AuthRequestSuccessState) {
                    state.response.fold(
                      (left) {
                        var snackbar = SnackBar(
                          content: Text(
                            left,
                            style: TextStyle(fontFamily: 'dana', fontSize: 14),
                          ),
                          backgroundColor: Colors.black,
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 1),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      },
                      (right) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
              const Expanded(child: SizedBox()),
              _signInGestureDetector(context),
              SizedBox(height: 20.h)
            ],
          ),
        ),
      )),
    );
  }

  Widget _usernameInput(TextEditingController usernameController) {
    return TextFormField(
      controller: usernameController,
      decoration: InputDecoration(
        hintText: 'Username',
        prefixIcon: const Icon(Icons.mail_outline),
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 16.h,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green, // Modify theme later
            width: 1.h,
          ),
          borderRadius: BorderRadius.circular(8.h), // Modify theme later
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
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
            color: Colors.green, // Modify theme later
            width: 1.h,
          ),
          borderRadius: BorderRadius.circular(8.h), // Modify theme later
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
      ),
      // TODO: Add email validation
      // validator: (value) {
      //   if (value == null || (!(isValidEmail(value, isRequired: true)))) {
      //     return "Please enter valid email";
      //   }
      //   return null;
      // },
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
            color: Colors.green, // Modify theme later
            width: 1.h,
          ),
          borderRadius: BorderRadius.circular(8.h), // Modify theme later
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.green, // Modify theme later
          ),
          onPressed: () {
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        ),
        errorMaxLines: 3,
      ),
      // TODO: Add password validation
      // validator: (value) {
      //   if (value == null || (!isValidPassword(value, isRequired: true))) {
      //     return "Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character (!@#\$&*~).";
      //   }
      //   return null;
      // },
      obscureText: passwordVisible,
    );
  }

  Widget _confirmPasswordSection(
      TextEditingController confirmPasswordController) {
    return TextFormField(
      controller: confirmPasswordController,
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
            color: Colors.green, // Modify theme later
            width: 1.h,
          ),
          borderRadius: BorderRadius.circular(8.h), // Modify theme later
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.green, // Modify theme later
          ),
          onPressed: () {
            setState(() {
              confirmPasswordVisible = !confirmPasswordVisible;
            });
          },
        ),
        errorMaxLines: 3,
      ),
      validator: (value) {
        if (value == null || (value != passwordController.text)) {
          return "Passwords do not match";
        }
        return null;
      },
      obscureText: confirmPasswordVisible,
    );
  }

  Widget _signUpButton(
      TextEditingController usernameController,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController confirmPasswordController) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          BlocProvider.of<AuthBloc>(context).add(
            AuthRegisterRequest(
              emailController.text,
              usernameController.text,
              passwordController.text,
            ),
          );
        }
      },
      // style: CustomButtonStyle.fillPrimary, // Modify theme later
      child: Text(
        "Sign Up",
        // style: CustomTextStyles.elevatedButtonOnPrimary, // Modify theme later
      ),
    );
  }

  Widget _signInGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: widget.show,
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black, // Modify theme later
          ),
          children: [
            TextSpan(
              text: 'Don\'t have an account? ',
              // style: CustomTextStyles.bodySmallOnSecondaryContainer,
            ),
            const TextSpan(text: " "),
            TextSpan(
              text: 'Sign In',
              // style: CustomTextStyles.labelSmallPrimary,
            ),
          ],
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
