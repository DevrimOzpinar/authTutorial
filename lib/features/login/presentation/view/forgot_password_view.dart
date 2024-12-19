import 'package:auto_route/annotations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hadi/core/const/app_keys.dart';
import 'package:hadi/core/const/app_textstyles.dart';
import 'package:hadi/features/login/presentation/widget/my_button.dart';
import 'package:hadi/features/login/presentation/widget/my_textfield.dart';
import 'package:provider/provider.dart';

import '../provider/forgot_password_provider.dart';

@RoutePage(name: 'ForgotPasswordRoute')
class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final forgotPasswordProvider = Provider.of<ForgotPasswordProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              AppKeys.sifreniziMiUnuttunuz,
              style: AppTextstyles.dmSansColorBlackBoldFontSize24,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            AutoSizeText(
              AppKeys.lufenHesabinizaKayitliEpostaAdresiniziGirin,
              style: AppTextstyles.dmSansColorGrey700FontSize16,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            MyTextField(
              prefixIcon: Icon(Icons.email),
              controller: _emailController,
              hintText: AppKeys.exampleEmail,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            forgotPasswordProvider.isLoading
                ? CircularProgressIndicator()
                : MyButtonDedik(
                    onTap: () async {
                      final email = _emailController.text.trim();
                      try {
                        await forgotPasswordProvider.resetPassword(email);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: AutoSizeText(AppKeys.sifreSifirlamaBaglantisiGonderildi),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    },
                    child: AutoSizeText(
                      AppKeys.sifreSifirlamaBaglantisiGonder,
                      style: AppTextstyles.dmSansColorWhiteBoldFontSize16,
                    ),
                  ),
            SizedBox(height: 20),
            MyButtonDedik(
              onTap: () {
                Navigator.pop(context); // Giriş ekranına geri döner
              },
              child: AutoSizeText(
                AppKeys.hesabinizaGirisYapin,
                style: AppTextstyles.dmSansColorWhiteBoldFontSize16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
