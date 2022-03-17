import 'package:e_shop/models/product_list.dart';
import 'package:e_shop/models/products.dart';
import 'package:e_shop/others/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (_) {
        return showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('Excluir produto'),
                  content: const Text('Tem certeza?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: const Text('Cancelar')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: const Text('Ok')),
                  ],
                )).then((value) {
          if (value ?? false) {
            Provider.of<ProductList>(
              context,
              listen: false,
            ).removeProduct(product);
          }
        });
      },
      onDismissed: (_) {},
      key: ValueKey(product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.black87,
        child: const Text(
          'Excluir',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 4,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(product.imageUrl),
            ),
            title: Text(product.title, style: const TextStyle(fontSize: 18)),
            trailing: SizedBox(
              width: 30,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.PRODUCTS_FORM,
                    arguments: product,
                  );
                },
                icon: Icon(Icons.edit,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
