import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app3/common/styles.dart';
import 'package:restaurant_app3/data/model/restaurant.dart';
import 'package:restaurant_app3/provider/database_provider.dart';
import 'package:restaurant_app3/provider/restaurants_provider.dart';
import 'package:restaurant_app3/widgets/custom_scaffold.dart';
import 'package:restaurant_app3/widgets/restaurant_item.dart';
import 'package:restaurant_app3/widgets/state_info.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      theTitle: 'Favorite Restaurants',
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Consumer<DatabaseProvider>(
          builder: (context, state, _) {
            switch (state.state) {
              case ResultState.Loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ResultState.NoData:
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 100,
                          color: secondaryColor,
                        ),
                        Text(
                          "You haven't added favorite restaurant",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  ),
                );
              case ResultState.HasData:
                List<Restaurant> restaurants = state.favorite;
                return ListView.builder(
                  itemCount: restaurants.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildRestaurantItem(context, restaurants[index]);
                  },
                );
              case ResultState.Error:
                return Center(
                  child: errorNoConnection(context),
                );
            }
          },
        ),
      ),
    );
  }
}
