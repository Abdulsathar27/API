import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usersproduct/controller/product_controller.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductController>().fetchProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Consumer<ProductController>(
        builder: (context, controller, _) {

          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.error != null) {
            return Center(
              child: Text(
                controller.error!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (controller.products.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          return GridView.builder(
            itemCount: controller.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final product = controller.products[index];

              return Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(product.image),
                    ),
                    Text(product.title),
                    Text('₹ ${product.price}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
