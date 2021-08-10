import 'package:flutter/material.dart';
import 'package:ini_resto/model/restaurant.dart';
import 'package:ini_resto/ui/detail_restaurant.dart';

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
