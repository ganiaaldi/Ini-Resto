import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ini_resto/model/restaurant.dart';
import 'package:ini_resto/resources/styles.dart';
import 'package:ini_resto/ui/home_page.dart';
import 'package:ini_resto/ui/splash.dart';

import 'ui/detail_restaurant.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        textTheme: myTextTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(textTheme: myTextTheme),
      ),
      title: 'Ini Resto',
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => SplashPage(),
        RestaurantList.routeName: (context) => RestaurantList(),
        RestaurantDetail.routeName: (context) => RestaurantDetail(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
