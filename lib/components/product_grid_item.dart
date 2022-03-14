import 'package:e_shop/models/cart.dart';
import 'package:e_shop/models/products.dart';
import 'package:e_shop/others/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
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
          backgroundColor: Colors.black87,
          //Cart icon
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Produto adicionado com sucesso!',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16),
                      ),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      action: SnackBarAction(
                          label: 'DESFAZER',
                          textColor: Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            cart.removeSingleItem(product.id);
                          }),
                    ),
                  );
                  cart.addItem(product);
                },
                icon: const Icon(
                  Icons.add_shopping_cart,
                )),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17),
          ),
          //Favorite Icon
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
