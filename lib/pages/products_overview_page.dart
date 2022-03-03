import 'package:e_shop/components/product_grid.dart';
import 'package:flutter/material.dart';

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My e-Store')),
      ),
      body: const ProductGrid(),
    );
  }
}

