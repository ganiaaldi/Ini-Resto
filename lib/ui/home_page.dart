
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
    ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(),
      child: Settings(),
    ),
  ];

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
      body: _bottomNavIndex == 0 ? _listWidget[0] : _listWidget[1],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
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