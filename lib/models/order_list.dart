import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:e_shop/models/cart.dart';
import 'package:e_shop/models/cart_item.dart';
import 'package:e_shop/models/order.dart';
import 'package:e_shop/others/constants.dart';

class OrderList with ChangeNotifier {
  final String _token;
  final String _uid;
  List<Order> _items = [];
  OrderList(this._uid, this._token, this._items);

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  //TODO: Implementar o pull to refresh na orders page
//Carrega os pedidos
  Future<void> loadOrders() async {
    List<Order> items = [];
    // _items.clear();

    final response = await http
        .get(Uri.parse('${Constants.ORDER_BASE_URL}/$_uid.json?auth=$_token'));
    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((orderId, orderData) {
      items.add(Order(
        id: orderId,
        total: orderData['total'],
        date: DateTime.parse(orderData['date']),
        //Convertendo os produtos
        products: (orderData['products'] as List<dynamic>).map((item) {
          return CartItem(
            id: item['id'],
            productId: item['productId'],
            name: item['name'],
            quantity: item['quantity'],
            price: item['price'],
          );
        }).toList(),
      ));
    });
    _items = items.reversed.toList();
    notifyListeners();
  }

//Adiciona os pedidos
  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
        Uri.parse('${Constants.ORDER_BASE_URL}/$_uid.json?auth=$_token'),
        body: jsonEncode(
          {
            'total': cart.totalAmount,
            'date': date.toIso8601String(),
            'products': cart.items.values
                .map((cartItem) => {
                      'id': cartItem.id,
                      'productId': cartItem.productId,
                      'name': cartItem.name,
                      'quantity': cartItem.quantity,
                      'price': cartItem.price,
                    })
                .toList(),
          },
        ));
    final id = jsonDecode(response.body)['name'];
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount!,
        date: date,
        products: cart.items.values.toList(),
      ),
    );
    notifyListeners();
  }
}
