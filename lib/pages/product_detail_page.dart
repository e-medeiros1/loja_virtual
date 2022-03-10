import 'package:e_shop/models/products.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.secondary),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: Text(
          product.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 500,
              width: double.infinity,
              child: InteractiveViewer(
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).colorScheme.primary),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Chip(
              backgroundColor: Theme.of(context).colorScheme.primary,
              label: Text(
                'R\$ ${product.price}',
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.secondary,
                  // backgroundColor: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
