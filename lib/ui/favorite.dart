import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ini_resto/provider/database_provider.dart';
import 'package:ini_resto/provider/restaurant_provider.dart';
import 'package:ini_resto/widgets/card_restaurant.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
  static const String favoriteTitle = 'Favorite';
  static const routeName = '/favorite';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: FutureBuilder<String>(
                builder: (context, snapshot) {
                  return _buildFavoriteItem(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteItem(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.HasData) {
          return ListView.builder(
            itemCount: provider.favorite.length,
            itemBuilder: (context, index) {
              return CardRestaurant(restaurant: provider.favorite[index]);
            },
          );
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
    );
  }
}
