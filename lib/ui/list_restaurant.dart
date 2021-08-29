import 'package:flutter/material.dart';
import 'package:ini_resto/data/api/api_service.dart';
import 'package:ini_resto/provider/restaurant_provider.dart';
import 'package:ini_resto/widgets/card_restaurant.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class RestaurantList extends StatefulWidget {
  static const routeName = '/restaurant_list';

  @override
  _RestaurantList createState() => _RestaurantList();
}

class _RestaurantList extends State<RestaurantList> {
  final TextEditingController _filter = new TextEditingController();
  late RestaurantProvider provider;
  Icon iconBar = Icon(Icons.search);
  Widget tittleApp = new Text('IniResto');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: tittleApp,
        actions: <Widget>[
          IconButton(
            onPressed: _searchRestaurant,
            icon: Icon(Icons.search),
          ),
        ],
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

  Widget _buildRestaurantItem(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) =>
          RestaurantProvider(apiService: ApiService(http.Client()), type: 'list', id: ''),
      child: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          provider = state;
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

  void _searchRestaurant() {
    setState(() {
      if (this.iconBar.icon == Icons.search) {
        this.iconBar = Icon(Icons.close);
        this.tittleApp = TextField(
          controller: _filter,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search), hintText: 'Cari Nama Restaurant'),
          onChanged: (value) => {
            if (value != '')
              {
                provider.fetchSearchRestaurant(value),
              }
          },
        );
      } else {
        this.iconBar = Icon(Icons.search);
        this.tittleApp = Text('IniResto');
        provider.fetchAllRestaurant();
        _filter.clear();
      }
    });
  }
}
