import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:token/constant/constants.dart';

class AuthService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<(String?, String?)> login({
    required String email,
    required String password,
  }) async {
    try {
      log('Logging in....');
      final response = await dio.post(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        log('Login response:${response.data}');
        final String? token = response.data['access_token'];
        return (token, null);
      } else {
        return (null, 'Invalid response');
      }
    } on DioException catch (e) {
      log('Login error : ${e.response?.data}');
      return (null, e.message ?? 'Login failed');
    } catch (e) {
      return (null, 'Something Went Wrong');
    }
  }

  Future<(Map<String, dynamic>?, String?)> fetchprofile(String token) async {
    try {
      log('fetching profile');
      final respone = await dio.get(
        ApiConstants.profile,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (respone.statusCode == 200) {
        final Map<String, dynamic> profile = Map<String, dynamic>.from(
          respone.data,
        );
        return (profile, null);
      } else {
        return (null, 'Unauthorized');
      }
    } on DioException catch (e) {
      log('Profile error : ${e.response?.data}');
      return (null, 'Session expired');
    } catch (e) {
      return (null, 'Something Went Wrong');
    }
  }
}
