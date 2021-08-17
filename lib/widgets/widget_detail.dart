import 'package:flutter/material.dart';
import 'package:ini_resto/data/model/restaurant.dart';
import 'package:ini_resto/provider/restaurant_provider.dart';

class RestaurantDetailWidgets extends StatelessWidget {
  final DetailRestaurant restaurant;
  final RestaurantProvider provider;

  const RestaurantDetailWidgets(
      {required this.restaurant, required this.provider});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
              tag: restaurant.pictureId,
              child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/large/" +
                      restaurant.pictureId)),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  restaurant.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Lokasi: ${restaurant.city}'),
                      ],
                    ),
                    Expanded(
                        child: Container(
                            height: 15,
                            child: VerticalDivider(color: Colors.blueGrey))),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.black12,
                            ),
                            Text("${restaurant.rating}"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  '${restaurant.address}',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Divider(color: Colors.grey),
                Text('${restaurant.description}'),
                SizedBox(height: 10),
                Divider(color: Colors.grey),
                SizedBox(height: 10),
                Text('Kategori'),
                Divider(color: Colors.grey),
                Container(
                  height: 100,
                  child: ListView(
                    children: restaurant.categories.map((e) {
                      return Card(
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("- ${e.name.toString()}"),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10),
                Text('Makanan'),
                Divider(color: Colors.grey),
                Container(
                  height: 200,
                  child: ListView(
                    children: restaurant.menus.foods.map((e) {
                      return Card(
                        elevation: 6.0,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("- ${e.name.toString()}"),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10),
                Text('Minuman'),
                Divider(color: Colors.grey),
                Container(
                  height: 200,
                  child: ListView(
                    children: restaurant.menus.drinks.map((e) {
                      return Card(
                        elevation: 6.0,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("- ${e.name.toString()}"),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10),
                Text('Reviews'),
                Divider(color: Colors.grey),
                Container(
                  height: 200,
                  child: ListView(
                    children: restaurant.customerReviews.map((e) {
                      return Card(
                        elevation: 6.0,
                        child: Container(
                          child : Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(e.name, style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(e.date, style: TextStyle(color: Colors.grey, fontSize: 12),),
                              Text(e.review),
                            ],
                          ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
