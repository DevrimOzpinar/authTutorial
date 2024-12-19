import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      throw Exception("Lütfen e-posta adresinizi girin.");
    }

    _setLoading(true);
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Bir hata oluştu.";
      if (e.code == "user-not-found") {
        errorMessage = "Bu e-posta adresine ait bir hesap bulunamadı.";
      } else if (e.code == "invalid-email") {
        errorMessage = "Geçersiz bir e-posta adresi.";
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception("Bir hata oluştu. Lütfen tekrar deneyin.");
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
