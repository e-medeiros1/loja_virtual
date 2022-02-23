import 'package:e_shop/pages/products_overview_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-shop',
      theme: ThemeData(
        accentColor: Colors.deepOrange,
        primarySwatch: Colors.blue,
        fontFamily: 'Lato',
      ),
      home: ProductsOverviewPage(),
    );
  }
}
