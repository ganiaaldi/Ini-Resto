import 'package:flutter/material.dart';
import 'package:ini_resto/data/model/restaurant.dart';
import 'package:ini_resto/provider/database_provider.dart';
import 'package:ini_resto/ui/detail_restaurant.dart';
import 'package:provider/provider.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
        future: provider.isFavorited(restaurant.id),
        builder: (context, snapshot) {
          var isFavorited = snapshot.data ?? false;
          return Material(
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: Hero(
                tag: restaurant.pictureId,
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/medium/" +
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
              trailing: isFavorited
                  ? IconButton(
                icon: Icon(Icons.favorite),
                color: Theme.of(context).accentColor,
                onPressed: () => provider.removeFavorite(restaurant.id),
              )
                  : IconButton(
                icon: Icon(Icons.favorite_border),
                color: Theme.of(context).accentColor,
                onPressed: () => provider.addFavorite(restaurant),
              ),
              onTap: () {
                Navigator.pushNamed(context, RestaurantDetail.routeName,
                    arguments: restaurant);
              },
            ),
          );
        },
      );
    });
  }
}
