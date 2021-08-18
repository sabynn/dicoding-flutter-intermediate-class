import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app3/common/styles.dart';
import 'package:restaurant_app3/data/model/restaurant.dart';
import 'package:restaurant_app3/provider/database_provider.dart';
import 'package:restaurant_app3/ui/detail_page.dart';

Widget buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return Consumer<DatabaseProvider>(builder: (context, state, _) {
    return FutureBuilder<bool>(
      future: state.isFavorited(restaurant.id),
      builder: (context, snapshot) {
        var isFavorited = snapshot.data ?? false;
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
                    "https://restaurant-api.dicoding.dev/images/large/" +
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
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(
                          Icons.location_on,
                          size: 20,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Text(restaurant.city),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(
                          Icons.star,
                          size: 20,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Text(
                        restaurant.rating.toString(),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: isFavorited
                  ? IconButton(
                      icon: const Icon(Icons.favorite),
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () => state.removeFavorite(restaurant.id),
                    )
                  : IconButton(
                      icon: const Icon(Icons.favorite_border),
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () => state.addFavorite(restaurant),
                    ),
              onTap: () {
                Navigator.pushNamed(context, RestaurantDetails.routeName,
                    arguments: restaurant);
              },
            ),
          ),
        );
      },
    );
  });
}
