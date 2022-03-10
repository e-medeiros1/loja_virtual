import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Meus pedidos',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      ),
    );
  }
}
