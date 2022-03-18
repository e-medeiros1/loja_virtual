import 'package:e_shop/others/app_routes.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then(
      (_) => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.cover,
        scale: 2,
      )),
    );
  }
}
