import 'package:flutter/material.dart';
import 'package:usersdata/model/user_model.dart';
import 'package:usersdata/service/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();
  List<UserModel> user = [];
  bool isLoading = false;
  String? error;
  Future<void> fecthusers() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      user = await _userService.fetchUsers();
    } catch (e) {
      error = 'Failed to Load Users';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
