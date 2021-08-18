import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app3/ui/settings_page.dart';
import 'package:restaurant_app3/widgets/restaurant_item.dart';
import 'package:restaurant_app3/data/api/api_service.dart';
import 'package:restaurant_app3/provider/restaurants_provider.dart';
import 'package:restaurant_app3/common/styles.dart';
import 'package:restaurant_app3/widgets/state_info.dart';
import 'favorite_page.dart';

class RestaurantsListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late RestaurantsProvider prov;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          centerTitle: true,
          title: Text(
            'Restaurant',
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.settings,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsPage()));
                // do something
              },
            )
          ],
        ),
        body: ChangeNotifierProvider<RestaurantsProvider>(
          create: (_) => RestaurantsProvider(
            apiService: ApiService(),
            type: 'list',
            restaurant: null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150),
                      ),
                      elevation: 3,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: TextField(
                          onChanged: (value) => {
                            if (value != '')
                              {
                                prov.fetchSearchRestaurant(value),
                              }
                            else
                              {
                                prov.fetchAllRestaurant(),
                              }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            hintText: 'Search...',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: secondaryColor, width: 1.0),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: secondaryColor, width: 2.0),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(150),
                    ),
                    elevation: 3,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: IconButton(
                        icon: const Icon(Icons.favorite),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const FavoritesPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Consumer<RestaurantsProvider>(
                  builder: (context, state, _) {
                    prov = state;
                    if (state.state == ResultState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: secondaryColor,
                        ),
                      );
                    } else if (state.state == ResultState.HasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.resResult.restaurants.length,
                        itemBuilder: (context, index) {
                          var restaurant = state.resResult.restaurants[index];
                          return buildRestaurantItem(context, restaurant);
                        },
                      );
                    } else if (state.state == ResultState.NoData) {
                      return Center(
                        child: noData(context, state),
                      );
                    } else if (state.state == ResultState.Error) {
                      return Center(
                        child: errorNoConnection(context),
                      );
                    } else {
                      return const Center(
                        child: Text(''),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
