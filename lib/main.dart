import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ini_resto/data/api/api_service.dart';
import 'package:ini_resto/navigation.dart';
import 'package:ini_resto/provider/database_provider.dart';
import 'package:ini_resto/provider/preferences_provider.dart';
import 'package:ini_resto/provider/restaurant_provider.dart';
import 'package:ini_resto/provider/scheduling_provider.dart';
import 'package:ini_resto/ui/detail_restaurant.dart';
import 'package:ini_resto/ui/favorite.dart';
import 'package:ini_resto/ui/home_page.dart';
import 'package:ini_resto/ui/list_restaurant.dart';
import 'package:ini_resto/ui/settings.dart';
import 'package:ini_resto/ui/splash.dart';
import 'package:ini_resto/utils/background_service.dart';
import 'package:ini_resto/utils/notification_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/database/database_helper.dart';
import 'data/model/restaurant.dart';
import 'data/preferences/preferences_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              RestaurantProvider(apiService: ApiService(), type: '', id: ''),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            // theme: ThemeData(
            //   primaryColor: primaryColor,
            //   accentColor: secondaryColor,
            //   textTheme: myTextTheme,
            //   visualDensity: VisualDensity.adaptivePlatformDensity,
            //   appBarTheme: AppBarTheme(textTheme: myTextTheme),
            // ),
            title: 'Ini Resto',
            theme: provider.themeData,
            navigatorKey: navigatorKey,
            initialRoute: SplashPage.routeName,
            routes: {
              HomePage.routeName: (context) => HomePage(),
              SplashPage.routeName: (context) => SplashPage(),
              RestaurantList.routeName: (context) => RestaurantList(),
              RestaurantDetail.routeName: (context) => RestaurantDetail(
                    restaurant: ModalRoute.of(context)?.settings.arguments
                        as Restaurant,
                  ),
              Favorite.routeName: (context) => Favorite(),
              Settings.routeName: (context) => Settings(),
            },
          );
        },
      ),
    );
  }
}
