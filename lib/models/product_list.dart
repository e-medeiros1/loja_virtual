import 'package:e_shop/data/dummy_data.dart';
import 'package:e_shop/models/products.dart';
import 'package:flutter/cupertino.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;

//Retornando a referência da lista de produtos, onde quem tiver acesso ao get pode ter acesso a
//outras propriedades do método
//List<Product> get items => _items;

//Retornando um clone do items(Forma correta)
  List<Product> get items => [..._items];

  void addProduct(Product product) {
    _items.add(product);
    //Parte essencial do fluxo de programação reativa
    notifyListeners();
  }


}
