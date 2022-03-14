import 'package:e_shop/components/app_drawer.dart';
import 'package:e_shop/components/product_item.dart';
import 'package:e_shop/models/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Gerenciar produtos',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (ctx, i) => Column(
                  children: [
                    ProductItem(product: products.items[i]),
                    const Divider(),
                  ],
                )),
      ),
    );
  }
}
