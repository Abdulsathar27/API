import 'package:dio/dio.dart';
import 'package:usersproduct/constant/api_constants.dart';
import 'package:usersproduct/model/product_model.dart';

class ProductService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final Response response = await dio.get(ApiConstants.product);

      if (response.statusCode == 200) {
        final List data = response.data;

        return data
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
