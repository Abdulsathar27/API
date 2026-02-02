import 'package:flutter/material.dart';
import 'package:token/service/auth_service.dart';

class AuthController extends ChangeNotifier {
  final AuthService authService = AuthService();
  bool isLoading = false;
  String error = '';
  String? token;
  Map<String, dynamic>? profile;
  Future<void> loginuser(String email, String password) async {
    isLoading = true;
    error = '';
    notifyListeners();
    final (data, err) = await authService.login(
      email: email,
      password: password,
    );
    if (data != null) {
      token = data;
    } else {
      error = err!;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadprofile() async {
    if (token == null) return;
    isLoading = true;
    notifyListeners();
    final (data, err) = await authService.fetchprofile(token!);
    if (data != null) {
      profile = data;
    } else {
      error = err!;
    }
    isLoading = false;
    notifyListeners();
  }
}
