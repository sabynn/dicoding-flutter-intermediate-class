import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app2/widgets/restaurant_item.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/provider/restaurants_provider.dart';
import 'package:restaurant_app2/common/styles.dart';
import 'package:restaurant_app2/widgets/state_info.dart';

class RestaurantsListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';
  late final RestaurantsProvider prov;

  RestaurantsListPage({Key? key}) : super(key: key);

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
        body: ChangeNotifierProvider<RestaurantsProvider>(
          create: (_) => RestaurantsProvider(
            apiService: ApiService(),
            type: 'list',
            restaurant: null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
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
                    prefixIcon: const Icon(Icons.search_rounded),
                    hintText: 'Search...',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor, width: 1.0),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor, width: 2.0),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                    ),
                  ),
                ),
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
