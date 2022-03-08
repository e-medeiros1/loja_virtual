import 'package:e_shop/components/product_grid.dart';
import 'package:e_shop/models/product_list.dart';
import 'package:e_shop/models/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favorite, All }

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Somente favoritos'),
                value: FilterOptions.Favorite,
              ),
              const PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {});
              if (selectedValue == FilterOptions.Favorite) {
                _showFavoriteOnly = true;
              } else {
                _showFavoriteOnly = false;
              }
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Center(
            child: Text(
          'Minha loja virtual',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
      body:  ProductGrid(showFavoriteOnly: _showFavoriteOnly),
    );
  }
}
