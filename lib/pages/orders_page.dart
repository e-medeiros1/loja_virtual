import 'package:e_shop/components/app_drawer.dart';
import 'package:e_shop/components/order.dart';
import 'package:e_shop/models/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Meus pedidos',
          style: TextStyle(
              fontSize: 20, color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx, i) => OrderWidget(
          order: orders.items[i],
        ),
      ),
    );
  }
}
