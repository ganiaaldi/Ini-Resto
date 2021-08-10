import 'package:flutter/material.dart';
import 'package:ini_resto/resources/custom_scaffold.dart';

import '../model/restaurant.dart';

class RestaurantDetail extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetail({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: restaurant.pictureId,
                child: Image.network(restaurant.pictureId)),
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
                          Text('Location: ${restaurant.city}'),
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
                  Divider(color: Colors.grey),
                  Text('${restaurant.description}'),
                  SizedBox(height: 10),
                  Divider(color: Colors.grey),
                  SizedBox(height: 10),
                  Text('Foods'),
                  Divider(color: Colors.grey),
                  Container(
                    height: 200,
                    child: ListView(
                      children: restaurant.menus.foods.map((e) {
                        return new Card(
                          elevation: 6.0,
                          child: new Container(
                            child: new Row(
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
                  Text('Drinks'),
                  Divider(color: Colors.grey),
                  Container(
                    height: 200,
                    child: ListView(
                      children: restaurant.menus.drinks.map((e) {
                        return new Card(
                          elevation: 6.0,
                          child: new Container(
                            child: new Row(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}