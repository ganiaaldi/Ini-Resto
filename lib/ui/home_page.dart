
import 'package:flutter/material.dart';
import 'package:ini_resto/provider/scheduling_provider.dart';
import 'package:ini_resto/ui/list_restaurant.dart';
import 'package:ini_resto/ui/settings.dart';
import 'package:ini_resto/utils/notification_helper.dart';
import 'package:ini_resto/widgets/floating_button.dart';
import 'package:provider/provider.dart';

import 'detail_restaurant.dart';
import 'favorite.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
  HomePage({
    Key? key,
  }) : super(key: key);
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<AnimatedFloatingActionButtonState> key =
  GlobalKey<AnimatedFloatingActionButtonState>();
  int _bottomNavIndex = 0;
  final NotificationHelper _notificationHelper = NotificationHelper();

  List<Widget> _listWidget = [
    RestaurantList(),
    Favorite(),
    Settings(),
  ];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Beranda',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorit',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Pengaturan',
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetail.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
      floatingActionButton: AnimatedFloatingActionButton(
        key: key,
        fabButtons: <Widget>[
          settings(),
          favorite(),
        ],
        colorStartAnimation: Colors.green,
        colorEndAnimation: Colors.red,
        animatedIconData: AnimatedIcons.menu_close,
      ),
    );
  }

  Widget favorite() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, Favorite.routeName);
        },
        heroTag: "Image",
        tooltip: 'Image',
        child: Icon(Icons.favorite),
      ),
    );
  }

  Widget settings() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          // Navigator.replace(context, Settings.routeName);
        },
        heroTag: "Settings",
        tooltip: 'Settings',
        child: Icon(Icons.settings),
      ),
    );
  }
}