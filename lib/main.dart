import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ini_resto/model/restaurant.dart';
import 'package:ini_resto/resources/styles.dart';

import 'detail_restaurant.dart';

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
      initialRoute: RestaurantList.routeName,
      routes: {
        RestaurantList.routeName: (context) => RestaurantList(),
        RestaurantDetail.routeName: (context) => RestaurantDetail(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}

class RestaurantList extends StatelessWidget {
  static const routeName = '/restaurant_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ini Resto'),
      ),
      body: new Column(
        children: <Widget>[
          Text('Selamat datang di IniResto',
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,),
          SizedBox(height: 10),
          Text('Pilih restaurant yang diinginkan',
              style: Theme.of(context).textTheme.subtitle1),
          Expanded(
            child: Container(
              child: FutureBuilder<String>(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/local_restaurant.json'),
                builder: (context, snapshot) {
                  final List<Restaurant> restaurant =
                      parseRestaurant(snapshot.data);
                  return ListView.builder(
                    itemCount: restaurant.length,
                    itemBuilder: (context, index) {
                      return _buildRestaurantItem(context, restaurant[index]);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: Hero(
      tag: restaurant.pictureId,
      child: Image.network(
        restaurant.pictureId,
        width: 100,
      ),
    ),
    title: Text("${restaurant.name}"),
    subtitle: Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.black12,
        ),
        Text("${restaurant.rating} - "),
        Text("${restaurant.city}"),
      ],
    ),
    onTap: () {
      Navigator.pushNamed(context, RestaurantDetail.routeName,
          arguments: restaurant);
    },
  );
}
