import 'package:ch4nge/features/layers/presentation/screens/authentication/bloc/auth_bloc.dart';
import 'package:ch4nge/features/layers/presentation/screens/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              SizedBox(height: 16.h),
              Text("Welcome!",
                  style: TextStyle(fontSize: 16)), // Modify theme later
              SizedBox(height: 8.h),
              Text("Sign in to continue",
                  style: TextStyle(fontSize: 12)), // Modify theme later
              SizedBox(height: 18.h),
              _emailInput(emailController),
              SizedBox(height: 10.h),
              _passwordInput(passwordController),
              SizedBox(height: 16.h),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthRequestSuccessState) {
                    state.response.fold((left) {
                      emailController.text = '';
                      passwordController.text = '';
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
                    }, (right) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    });
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return CircularProgressIndicator();
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
                      widget = Text(r);
                    });
                    return widget;
                  }
                  return Text('');
                },
              ),
              const Expanded(child: SizedBox()),
              _signUpGestureDetector(context),
              SizedBox(height: 24.h)
            ],
          ),
        ),
      )),
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
          borderRadius:
              BorderRadius.all(Radius.circular(8.r)), // Modify theme later
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
          borderRadius: BorderRadius.circular(8), // // Modify theme later
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

  Widget _signInButton(TextEditingController emailController,
      TextEditingController passwordController) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<AuthBloc>(context).add(
            AuthLoginRequest(emailController.text, passwordController.text));
      },
      // style: CustomButtonStyle.fillPrimary,
      child: Text(
        "Sign In",
        // style: CustomTextStyles.elevatedButtonOnPrimary, // Modify theme later
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
                  fontSize: 12, color: Colors.black), // Modify theme later
            ),
            const TextSpan(text: " "),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                  fontSize: 12, color: Colors.black), // Modify theme later
            ),
          ],
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
