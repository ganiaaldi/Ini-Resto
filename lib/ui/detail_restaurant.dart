import 'package:flutter/material.dart';
import 'package:ini_resto/data/api/api_service.dart';
import 'package:ini_resto/provider/restaurant_provider.dart';
import 'package:ini_resto/widgets/custom_scaffold.dart';
import 'package:ini_resto/widgets/widget_detail.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../data/model/restaurant.dart';

class RestaurantDetail extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;


  const RestaurantDetail({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body:
      _buildRestaurantDetails(context)
    );
  }
  
  Widget _buildRestaurantDetails(BuildContext context) {
    RestaurantProvider _provider;

    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiService(http.Client()), type: 'detail', id: restaurant.id),
      child: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          _provider = state;
          if (state.state == ResultState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.HasData) {
            var restaurant = state.result.restaurant;
            return RestaurantDetailWidgets(restaurant: restaurant, provider: _provider, id: '',);
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

}