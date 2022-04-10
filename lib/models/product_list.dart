import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:e_shop/exceptions/http_exceptions.dart';
import 'package:e_shop/models/products.dart';
import 'package:e_shop/others/constants.dart';

//Retornando a referência da lista de produtos, onde quem tiver acesso ao get pode ter acesso a
//outras propriedades do método
// List<Product> get items => _items;

//Retornando um clone do items(Forma correta)
class ProductList with ChangeNotifier {
  List<Product> _items = [];
  final String _token;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  //Construtor
  ProductList(this._items, this._token);

  int get itemsCount {
    return _items.length;
  }

  //Carrega produtos
  Future<void> loadProducts() async {
    _items.clear();

    final response =
        //Aguarda o get da Url + token
        //É necessário informar pro firebase que você está logado
        await http
            .get(Uri.parse('${Constants.PRODUCT_BASE_URL}.json?auth=$_token'));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      _items.add(
        Product(
          id: productId,
          title: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ),
      );
    });
    notifyListeners();
  }

  //Salva produtos
  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final newProduct = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      return updateProduct(newProduct);
    } else {
      return addProduct(newProduct);
    }
  }

  //Adiciona produtos
  Future<void> addProduct(Product product) async {
    //Encode do Json
    final response = await http.post(
        Uri.parse('${Constants.PRODUCT_BASE_URL}.json?auth=$_token'),
        body: jsonEncode(
          {
            "name": product.title,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
            "isFavorite": product.isFavorite,
          },
        ));

    //Decode do Json
    final id = jsonDecode(response.body)['name'];
    _items.add(Product(
        id: id,
        description: product.description,
        imageUrl: product.imageUrl,
        title: product.title,
        price: product.price,
        isFavorite: product.isFavorite));
    //Parte essencial do fluxo de programação reativa
    notifyListeners();
    //manda o produto novo pro servidor e depois aparece na lista de produtos
  }

  //Atualiza produtos
  Future<void> updateProduct(Product product) async {
    //Verifica se o index é válido, caso não encontre, retorna -1, que não é um valor int aceitável
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
          Uri.parse(
              '${Constants.PRODUCT_BASE_URL}/${product.id}.json?auth=$_token'),
          body: jsonEncode(
            {
              "name": product.title,
              "description": product.description,
              "price": product.price,
              "imageUrl": product.imageUrl,
            },
          ));
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  //Remoção de produtos
  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse(
            '${Constants.PRODUCT_BASE_URL}/${product.id}.json?auth=$_token'),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpExceptions(
          msg: 'Não foi possível excluir o produto.',
          statusCode: response.statusCode,
        );
      }
    }
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
