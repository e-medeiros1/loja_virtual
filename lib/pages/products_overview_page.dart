import 'package:e_shop/components/product_item.dart';
import 'package:e_shop/data/dummy_data.dart';
import 'package:e_shop/models/product_list.dart';
import 'package:e_shop/models/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Acessando lista de produtos
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts = provider.items;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My e-Store')),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) {
          return ProductItem(products: loadedProducts[i]);
        },
      ),
    );
  }
}
