import 'package:flutter/material.dart';
import 'package:token/service/auth_service.dart';

class AuthController extends ChangeNotifier {
  final AuthService authService = AuthService();

  // ========================
  // Text Controllers (UI State)
  // ========================
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ========================
  // App State
  // ========================
  bool isLoginLoading = false;
  bool isProfileLoading = false;

  String error = '';
  String? token;
  Map<String, dynamic>? profile;

  // Internal guard to prevent multiple profile API calls
  bool _isProfileLoaded = false;

  // ========================
  // LOGIN
  // ========================
  Future<void> loginUser() async {
    isLoginLoading = true;
    error = '';
    notifyListeners();

    final (data, err) = await authService.login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (data != null) {
      token = data;
      _resetProfileState(); // important when logging in again
    } else {
      error = err ?? 'Login failed';
    }

    isLoginLoading = false;
    notifyListeners();
  }

  // ========================
  // LOAD PROFILE (SAFE)
  // ========================
  Future<void> loadProfile() async {
    // Controller decides whether API should be called
    if (token == null || _isProfileLoaded || isProfileLoading) return;

    isProfileLoading = true;
    error = '';
    notifyListeners();

    final (data, err) = await authService.fetchprofile(token!);

    if (data != null) {
      profile = data;
      _isProfileLoaded = true;
    } else {
      error = err ?? 'Failed to load profile';
    }

    isProfileLoading = false;
    notifyListeners();
  }

  // ========================
  // LOGOUT / RESET
  // ========================
  void logout() {
    token = null;
    _resetProfileState();
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  void _resetProfileState() {
    profile = null;
    _isProfileLoaded = false;
  }

  // ========================
  // DISPOSE
  // ========================
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
