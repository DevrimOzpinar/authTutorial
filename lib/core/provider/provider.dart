import 'package:flutter/material.dart';
import 'package:hadi/features/login/presentation/provider/forgot_password_provider.dart';
import 'package:hadi/features/login/presentation/provider/login_provider.dart';
import 'package:hadi/features/login/presentation/provider/register_provider.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
      ],
      child: child,
    );
  }
}
