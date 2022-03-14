import 'package:e_shop/others/app_routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Colors.white70,
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: const Center(
                child: Text(
              'Bem vindo, Medeiros!',
            )),
          ),
          const Divider(),
          ListTile(
            // leading: Icon(
            //   Icons.shop,
            //   color: Theme.of(context).colorScheme.primary,
            // ),
            title: Text(
              'Loja',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.HOME,
              );
            },
          ),
          const Divider(),
          ListTile(
            // leading: Icon(
            //   Icons.payment,
            //   color: Theme.of(context).colorScheme.primary,
            // ),
            title: Text(
              'Pedidos',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.ORDERS,
              );
            },
          ),
          const Divider(),
          ListTile(
            // leading: Icon(
            //   Icons.shop,
            //   color: Theme.of(context).colorScheme.primary,
            // ),
            title: Text(
              'Gerenciar Produtos',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.PRODUCTS,
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
