import 'package:e_shop/models/cart.dart';
import 'package:e_shop/models/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartButton extends StatefulWidget {
  const CartButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary)
        : TextButton(
            //Se o contador estiver igual a zero, o botão torna-se nulo, caso não
            //esteja, retorna a função async
            onPressed: widget.cart.itemsCount == 0
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await Provider.of<OrderList>(context, listen: false)
                        .addOrder(widget.cart);
                    setState(() {
                      _isLoading = false;
                      
                    });
                    widget.cart.clear();
                  },
            child: Text(
              'COMPRAR',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold),
            ),
          );
  }
}
