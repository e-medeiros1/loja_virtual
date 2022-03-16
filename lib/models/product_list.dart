import 'dart:math';

import 'package:e_shop/data/dummy_data.dart';
import 'package:e_shop/models/products.dart';
import 'package:flutter/cupertino.dart';

class ProductList with ChangeNotifier {
//Retornando a referência da lista de produtos, onde quem tiver acesso ao get pode ter acesso a
//outras propriedades do método
//List<Product> get items => _items;

//Retornando um clone do items(Forma correta)
  List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  void addProductFromData(Map<String, Object> data) {
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      title: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    addProduct(newProduct);
  }

  void addProduct(Product product) {
    _items.add(product);
    //Parte essencial do fluxo de programação reativa
    notifyListeners();
  }
}

//  bool _showFavoriteOnly = false;
//   List<Product> get items {
//     if (_showFavoriteOnly) {
//       return _items.where((prod) => prod.isFavorite).toList();
//     }
//     return [..._items];
//   }

//   void showFavoriteOnly() {
//     _showFavoriteOnly = true;
//     notifyListeners();
//   }

//   void showAll() {
//     _showFavoriteOnly = false;
//     notifyListeners();
//   }
