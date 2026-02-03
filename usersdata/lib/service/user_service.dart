import 'package:dio/dio.dart';
import 'package:usersdata/constant/api_constants.dart';
import 'package:usersdata/model/user_model.dart';

class UserService {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseurl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<List<UserModel>> fetchUsers() async {
    try {
      Response response = await UserService.dio.get(ApiConstants.users);
      if (response.statusCode == 200) {
        List usersjson = response.data['users'];
        return usersjson.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('server error : ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error : ${e.message}');
    } catch (e) {
      throw Exception("Unexpected error : $e");
    }
  }
}
