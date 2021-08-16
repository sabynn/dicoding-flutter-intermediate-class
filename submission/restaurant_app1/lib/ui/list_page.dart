import 'detail_page.dart';
import 'package:flutter/material.dart';

import '../common/styles.dart';
import '../model/restaurant.dart';

class RestaurantsListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Restaurant',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: FutureBuilder<String>(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/local_restaurants.json'),
          builder: (context, snapshot) {
            final List<Restaurant> restaurants =
                parseRestaurants(snapshot.data);
            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return _buildRestaurantItem(context, restaurants[index]);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shadowColor: secondaryColor,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          leading: Hero(
            tag: restaurant.pictureId,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: Image.network(
                restaurant.pictureId,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            restaurant.name,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      Icons.location_on,
                      size: 20,
                      color: Colors.black26,
                    ),
                  ),
                  Text(restaurant.city),
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.black26,
                    ),
                  ),
                  Text(
                    restaurant.rating.toString(),
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, RestaurantDetails.routeName,
                arguments: restaurant);
          },
        ),
      ),
    );
  }
}
