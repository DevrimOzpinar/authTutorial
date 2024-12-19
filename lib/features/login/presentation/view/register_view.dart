import 'package:auto_route/annotations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hadi/core/const/app_keys.dart';
import 'package:hadi/core/const/app_textstyles.dart';
import 'package:hadi/features/login/presentation/provider/register_provider.dart';
import 'package:hadi/features/login/presentation/widget/my_button.dart';
import 'package:hadi/features/login/presentation/widget/my_textfield.dart';
import 'package:provider/provider.dart';

@RoutePage(name: 'SignUpRoute')
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void register(RegisterProvider provider) async {
    try {
      await provider.register(
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: AutoSizeText(AppKeys.kayitBasarili)),
      );

      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: AutoSizeText(error.toString())),
      );
    }
  }

  void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AutoSizeText(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AutoSizeText(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Icon(Icons.abc_sharp, size: 100.h),
              SizedBox(height: 20.h),
              MyTextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                hintText: AppKeys.exampleEmail,
                obscureText: false,
              ),
              SizedBox(height: 20.h),
              MyTextField(
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                hintText: AppKeys.password,
                obscureText: true,
              ),
              SizedBox(height: 20.h),
              MyTextField(
                keyboardType: TextInputType.visiblePassword,
                controller: _confirmPasswordController,
                hintText: AppKeys.confirmPassword,
                obscureText: true,
              ),
              SizedBox(height: 20.h),
              MyButtonDedik(
                onTap: () => register(Provider.of<RegisterProvider>(context, listen: false)),
                child: registerProvider.isLoading ? CircularProgressIndicator() : AutoSizeText(AppKeys.signUp, style: AppTextstyles.dmSansColorWhiteBoldFontSize16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
