import 'package:flutter/material.dart';
import 'package:ini_resto/data/api/api_service.dart';
import 'package:ini_resto/provider/restaurant_provider.dart';
import 'package:ini_resto/widgets/card_restaurant.dart';
import 'package:provider/provider.dart';

class RestaurantList extends StatelessWidget {
  static const routeName = '/restaurant_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ini Resto'),
      ),
      body: Column(
        children: <Widget>[
          Text(
            'Selamat datang di IniResto',
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text('Pilih restaurant yang diinginkan',
              style: Theme.of(context).textTheme.subtitle1),
          Expanded(
            child: Container(
              child: FutureBuilder<String>(
                builder: (context, snapshot) {
                      return _buildRestaurantItem(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildRestaurantItem(BuildContext context) {
  return ChangeNotifierProvider<RestaurantProvider>(
    create: (_) =>
        RestaurantProvider(apiService: ApiService(), type: 'list', id: ''),
    child: Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    ),
  );
}
