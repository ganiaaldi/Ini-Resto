import 'package:flutter/material.dart';
import 'package:ini_resto/resources/styles.dart';

import '../main.dart';
import 'home_page.dart';

class SplashPage extends StatelessWidget {

  static const routeName = '/splash_page';

  @override
  Widget build(BuildContext context) {


    Future.delayed(
        const Duration(seconds: 4),
            () => Navigator.pushReplacementNamed(context, RestaurantList.routeName)
    );

    return Scaffold(
      backgroundColor: primaryColor,
      body:
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/splash.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
    );
  }
}