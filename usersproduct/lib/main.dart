import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usersproduct/View/product_page.dart';
import 'package:usersproduct/controller/product_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductController())],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProductPage(),
    ),
    
    );
  }
}
