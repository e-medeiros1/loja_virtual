import 'package:e_shop/components/cart_button.dart';
import 'package:e_shop/components/cart_item.dart';

import 'package:e_shop/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        //Bar
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
        //Corpo
        body: Column(
          children: [
            Visibility(
              visible: cart.items.isNotEmpty,
              replacement: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  //Aparece quando o carrinho está vazio
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      const Center(
                        child: Text(
                          'Oops! O carrinho está vazio',
                          style: TextStyle(
                            color: Colors.black,
                            // fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 100),
                        child: Center(
                          child: Image.asset(
                            'assets/images/empty.png',
                            scale: 3,
                            // color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //Aparece quando há itens no carrinho
              child: Expanded(
                  child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (ctx, i) => CartItemWidget(
                  cartItem: items[i],
                ),
              )),
            ),
            //Barra horizontal(Total e valor)
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
                    //Botão comprar
                    CartButton(cart: cart)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
