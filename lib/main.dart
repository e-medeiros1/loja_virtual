import 'package:e_shop/models/auth.dart';
import 'package:e_shop/models/cart.dart';
import 'package:e_shop/models/order_list.dart';
import 'package:e_shop/models/product_list.dart';
import 'package:e_shop/others/app_routes.dart';
import 'package:e_shop/pages/auth_or_home_page.dart';
import 'package:e_shop/pages/auth_page.dart';
import 'package:e_shop/pages/cart_page.dart';
import 'package:e_shop/pages/orders_page.dart';
import 'package:e_shop/pages/product_detail_page.dart';
import 'package:e_shop/pages/product_form_page.dart';
import 'package:e_shop/pages/products_page.dart';
import 'package:e_shop/pages/products_overview_page.dart';
import 'package:e_shop/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        //ProductList depende de Auth
        ChangeNotifierProxyProvider<Auth, ProductList>(
          //Cria o provider recebendo os valores vazios
          create: (_) => ProductList([], ''),
          //Atualiza passando os dados para os parâmetros
          update: (ctx, auth, previous) {
            return ProductList(
              //Pega-se a lista de itens também para reaproveitar o provider anterior
              previous?.items ?? [],
              auth.token ?? '',
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList('', []),
          update: (ctx, auth, previous) {
            return OrderList(
              auth.token ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-shop',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.black,
            secondary: Colors.white,
            // error: Colors.red.shade300,
          ),
        ),
        initialRoute: AppRoutes.SPLASH,
        routes: {
          AppRoutes.SPLASH: (ctx) => const SplashPage(),
          AppRoutes.AUTH_OR_HOME: (ctx) => const AuthOrHomePage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
          AppRoutes.CART: (ctx) => const CartPage(),
          AppRoutes.ORDERS: (ctx) => const OrdersPage(),
          AppRoutes.PRODUCTS: (ctx) => ProductsPage(),
          AppRoutes.PRODUCTS_FORM: (ctx) => const ProductFormPage()
        },
      ),
    );
  }
}
