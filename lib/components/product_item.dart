import 'package:e_shop/models/products.dart';
import 'package:e_shop/others/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {},
              icon: const Icon(
                Icons.local_grocery_store_outlined,
              )),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                product.toggleFavorite();
              },
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
