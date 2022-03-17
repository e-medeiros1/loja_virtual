import 'package:e_shop/models/products.dart';
import 'package:e_shop/others/app_routes.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCTS_FORM,
                  arguments: product,
                );
              },
              icon: Icon(Icons.edit,
                  color: Theme.of(context).colorScheme.primary),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete_forever_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
