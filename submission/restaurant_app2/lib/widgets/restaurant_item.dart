import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app2/common/styles.dart';
import 'package:restaurant_app2/data/model/restaurant.dart';
import 'package:restaurant_app2/ui/detail_page.dart';

Widget buildRestaurantItem(BuildContext context, Restaurant restaurant) {
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