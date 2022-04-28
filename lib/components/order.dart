import 'package:e_shop/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  const OrderWidget({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    final itemsHeight = (widget.order.products.length * 25) + 10.toDouble();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: _expanded ? itemsHeight + 80 : 80,
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('R\$ ${widget.order.total.toStringAsFixed(2)}'),
              subtitle:
                  Text(DateFormat('dd/M/yyyy h:mm').format(widget.order.date)),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: const Icon(
                  Icons.expand_more,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: _expanded ? itemsHeight : 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              child: ListView(
                children: widget.order.products.map((products) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        products.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${products.quantity}x R\$ ${products.price}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
