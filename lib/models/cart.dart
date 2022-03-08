import 'dart:math';

import 'package:e_shop/models/cart_item.dart';
import 'package:e_shop/models/products.dart';
import 'package:flutter/widgets.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
//Make a clone
  Map<String, CartItem> get items {
    return {..._items};
  }

//Adds item to cart
  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
          product.id,
          () => CartItem(
                id: Random().nextDouble().toString(),
                productId: product.id,
                name: product.title,
                quantity: 1,
                price: product.price,
              ));
    }
    notifyListeners();
  }

//Calculate total
  double? get totalAmount {
     double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
  }

//Count items
  int get itemsCount {
    return _items.length;
  }

//Remove items
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

//Clear items
  void clear() {
    _items = {};
    notifyListeners();
  }
}
