import 'package:e_shop/components/product_item.dart';
import 'package:e_shop/models/product_list.dart';
import 'package:e_shop/models/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool? showFavoriteOnly;

  const ProductGrid({Key? key, required this.showFavoriteOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Acessando lista de produtos
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts =
        showFavoriteOnly! ? provider.favoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) {
        return ChangeNotifierProvider.value(
          child: ProductItem(),
          value: loadedProducts[i],
        );
      },
    );
  }
}
