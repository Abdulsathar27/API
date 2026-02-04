import 'package:flutter/material.dart';
import 'package:usersproduct/model/product_model.dart';
import 'package:usersproduct/service/product_service.dart';

class ProductController extends ChangeNotifier {
  final ProductService _productService = ProductService();

  List<ProductModel> products = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchProduct() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      products = await _productService.fetchProducts();
    } catch (e) {
      error = e.toString();
      debugPrint('Product Fetch Error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
