import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool get isAuthenticated => _user != null;

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      _errorMessage = "Lütfen tüm alanları doldurun.";
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null; // Reset error message on each new attempt
    notifyListeners();

    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      _user = credential.user;
      _errorMessage = null; // Clear error message on successful login
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'Bu e-posta ile kayıtlı kullanıcı bulunamadı.';
      } else if (e.code == 'wrong-password') {
        message = 'Şifre hatalı, lütfen tekrar deneyin.';
      } else {
        message = 'Kullanıcı adı veya şifre yanlış';
      }
      _errorMessage = message;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}
