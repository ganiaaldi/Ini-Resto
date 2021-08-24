import 'package:flutter/material.dart';
import 'package:ini_resto/data/preferences/preferences_helper.dart';
import 'package:ini_resto/widgets/styles.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getRestaurantPreferences();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool __isRestaurantActive = false;
  bool get isDailyNewsActive => __isRestaurantActive;

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getRestaurantPreferences() async {
    __isRestaurantActive = await preferencesHelper.isDailyNewsActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void enableRestaurant(bool value) {
    preferencesHelper.setDailyNews(value);
    _getRestaurantPreferences();
  }
}