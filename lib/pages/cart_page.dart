import 'package:e_shop/components/cart_item.dart';
import 'package:e_shop/models/cart.dart';
import 'package:e_shop/models/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        elevation: 0,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.secondary),
        centerTitle: true,
        title: Text(
          'Carrinho',
          // textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary, fontSize: 23),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, i) => CartItemWidget(
              cartItem: items[i],
            ),
          )),
          Card(
            color: Theme.of(context).colorScheme.primary,
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ',
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  Chip(
                      backgroundColor: Colors.black12,
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
                    onPressed: () {
                      Provider.of<OrderList>(context, listen: false)
                          .addOrder(cart);
                      cart.clear();
                    },
                    child: Text(
                      'COMPRAR',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
