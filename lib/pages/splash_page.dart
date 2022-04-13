import 'package:e_shop/others/app_routes.dart';
import 'package:e_shop/pages/auth_or_home_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(const Duration(seconds: 2)).then(
  //     (_) => Navigator.of(context).pushReplacementNamed(AppRoutes.AUTH_OR_HOME),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 300,
      nextScreen: const AuthOrHomePage(),
      splashTransition: SplashTransition.scaleTransition,
      duration: 200,
      splash: Container(
        color: Colors.white,
        child: Center(
            child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
          scale: 2,
        )),
      ),
    );
  }
}
