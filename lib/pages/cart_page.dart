import 'package:e_shop/components/cart_item.dart';
import 'package:e_shop/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'Carrinho',
          // textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total: ',
                    style: TextStyle(fontSize: 20),
                  ),
                  Chip(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      label: Text(
                        'R\$ ${cart.totalAmount!.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                        //
                      )),
                  const Spacer(),
                  TextButton(
                    // style: TextButton.styleFrom(
                    //   textStyle: const TextStyle(
                    //     color: Colors.black,
                    //   ),
                    // ),
                    onPressed: () {},
                    child: const Text(
                      'COMPRAR',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, i) => CartItemWidget(
              cartItem: items[i],
            ),
          )),
        ],
      ),
    );
  }
}
