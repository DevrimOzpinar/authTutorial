import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hadi/core/const/app_keys.dart';
import 'package:hadi/core/const/app_image_path.dart';
import 'package:hadi/core/const/app_textstyles.dart';
import 'package:hadi/core/routing/router.gr.dart';
import 'package:hadi/features/login/presentation/provider/login_provider.dart';
import 'package:hadi/features/login/presentation/widget/my_button.dart';
import 'package:hadi/features/login/presentation/widget/my_textfield.dart';
import 'package:hadi/features/login/presentation/widget/square_tile.dart';
import 'package:provider/provider.dart';

@RoutePage(name: 'SignInRoute')
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
// text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              // logo
              Icon(Icons.lock, size: 100.h),
              SizedBox(height: 20.h),
              // welcome back you
              AutoSizeText(AppKeys.welcomeBackYouVeBeenMissed, style: AppTextstyles.dmSansColorGrey700FontSize16),
              SizedBox(height: 25.h),
              // Email textfield
              MyTextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                hintText: AppKeys.email,
                obscureText: false,
              ),
              SizedBox(height: 10.h),
              // password textfield
              MyTextField(
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                hintText: AppKeys.password,
                obscureText: true,
              ),
              // forgot password
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        context.pushRoute(ForgotPasswordRoute());
                      },
                      child: AutoSizeText(AppKeys.forgotPassword, style: AppTextstyles.dmSansColorGrey600FontSize16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              // sign in button
              MyButtonDedik(
                onTap: authProvider.isLoading
                    ? null
                    : () async {
                        try {
                          await authProvider.login(
                            emailController.text,
                            passwordController.text,
                          );
                          if (authProvider.isAuthenticated) {
                            // Success: Navigate to Home
                            context.replaceRoute(HomeViewRoute());
                          } else if (authProvider.errorMessage != null) {
                            // Error: Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(authProvider.errorMessage!)),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      },
                child: authProvider.isLoading
                    ? CircularProgressIndicator()
                    : AutoSizeText(
                        AppKeys.signIn,
                        style: AppTextstyles.dmSansColorWhiteBoldFontSize16,
                      ),
              ),
              SizedBox(height: 25.h),
              // or continue with
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0.r),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                child: AutoSizeText(AppKeys.orContinueWith, style: AppTextstyles.dmSansColorGrey600FontSize16),
              ),
              // google + apple sign in button
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(imagePath: AppImagePath.googlePng),
                  SizedBox(width: 25.w),
                  // apple button
                  SquareTile(imagePath: AppImagePath.applePng),
                ],
              ),
              SizedBox(height: 20.h),
              // not a number? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(AppKeys.notANumber, style: AppTextstyles.dmSansColorGrey600FontSize16),
                  SizedBox(height: 4.h),
                  InkWell(
                    onTap: () {
                      //
                      context.pushRoute(SignUpRoute());
                    },
                    child: AutoSizeText(AppKeys.registerNow, style: AppTextstyles.dmSansColorBlueBoldFontSize16),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
