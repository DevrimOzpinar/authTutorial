import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> register({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      throw 'Lütfen tüm alanları doldurun';
    }

    if (password != confirmPassword) {
      throw 'Şifreler uyuşmuyor';
    }

    _isLoading = true;
    notifyListeners();

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw 'Bu e-posta zaten kullanımda.';
      } else if (e.code == 'invalid-email') {
        throw 'Geçersiz bir e-posta adresi girdiniz.';
      } else if (e.code == 'weak-password') {
        throw 'Şifre çok zayıf. Lütfen daha güçlü bir şifre seçin.';
      } else {
        throw 'Bir hata oluştu: ${e.message}';
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
