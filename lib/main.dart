import 'package:e_shop/models/cart.dart';
import 'package:e_shop/models/product_list.dart';
import 'package:e_shop/others/app_routes.dart';
import 'package:e_shop/pages/product_detail_page.dart';
import 'package:e_shop/pages/products_overview_page.dart';
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
          create: (_) => ProductList(),
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
            primary: Colors.yellow.shade50,
            secondary: Colors.yellow.shade300,
          ),
        ),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
        },
        home: const ProductsOverviewPage(),
      ),
    );
  }
}
