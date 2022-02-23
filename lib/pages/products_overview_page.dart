import 'package:e_shop/data/dummy_data.dart';
import 'package:e_shop/models/products.dart';
import 'package:flutter/material.dart';

class ProductsOverviewPage extends StatelessWidget {
  final List<Product> LoadedProducts = dummyProducts;

  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My e-Store')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: LoadedProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, i) {
            return Text(LoadedProducts[i].title);
          },
        ),
      ),
    );
  }
}
