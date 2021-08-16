import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/model/detail_restaurant.dart';
import 'package:restaurant_app2/provider/restaurants_provider.dart';
import 'package:restaurant_app2/common/styles.dart';
import 'package:restaurant_app2/widgets/custom_scaffold.dart';
import 'package:restaurant_app2/data/model/restaurant.dart';
import 'package:restaurant_app2/widgets/detail_item.dart';
import 'package:restaurant_app2/widgets/add_review.dart';
import 'package:restaurant_app2/widgets/state_info.dart';

class RestaurantDetails extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant? restaurant;

  const RestaurantDetails({required this.restaurant});

  @override
  State createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetails> {
  int _selectedChoice = 0;
  int? _value = 0;
  String? _title = "All";
  late DetailOfRestaurant resDetail;
  late RestaurantsProvider prov;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantsProvider>(
      create: (_) => RestaurantsProvider(
        apiService: ApiService(),
        type: 'detail',
        restaurant: widget.restaurant,
      ),
      child: SafeArea(
        child: Consumer<RestaurantsProvider>(
          builder: (context, state, _) {
            prov = state;
            if (state.state == ResultState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.HasData) {
              resDetail = state.detailResult.restaurant;
              return _detailOfRestaurant();
            } else if (state.state == ResultState.NoData) {
              return CustomScaffold(
                theTitle: "No restaurant found",
                body: Center(
                  child: noData(context, state),
                ),
              );
            } else if (state.state == ResultState.Error) {
              return CustomScaffold(
                theTitle: "No connection",
                body: Center(
                  child: errorNoConnection(context),
                ),
              );
            } else {
              return Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }

  Widget _detailOfRestaurant() {
    List<dynamic> menuChoice = resDetail.menus['foods'];
    if (_selectedChoice == 1) {
      menuChoice = resDetail.menus['foods'];
    } else if (_selectedChoice == 2) {
      menuChoice = resDetail.menus['drinks'];
    } else {
      menuChoice = resDetail.menus['foods'] + resDetail.menus['drinks'];
    }

    return CustomScaffold(
      theTitle: resDetail.name,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: resDetail.pictureId,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.network(
                  resDetail.pictureId,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_city_rounded,
                        color: secondaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Address: ${resDetail.address}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: secondaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'City: ${resDetail.city}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: secondaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Rating: ${resDetail.rating}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  Row(
                    children: [
                      Text(
                        "Categories",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const Icon(
                        Icons.category_rounded,
                        size: 20,
                      ),
                    ],
                  ),
                  Center(
                    child: Wrap(
                      children: [
                        for (int i = 0; i < resDetail.categories.length; i++)
                          buildCategoryCard(resDetail.categories[i]["name"])
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Row(
                    children: [
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const Icon(
                        Icons.description_rounded,
                        size: 20,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      resDetail.description,
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.grey),
                  Row(
                    children: [
                      Text(
                        "Menus",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const Icon(
                        Icons.fastfood_sharp,
                        size: 20,
                      ),
                    ],
                  ),
                  Center(
                    child: Wrap(
                      children: List<Widget>.generate(
                        3,
                        (int index) {
                          if (index == 0) {
                            _title = "All";
                          } else if (index == 1) {
                            _title = "Foods";
                          } else if (index == 2) {
                            _title = "Drinks";
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ChipTheme(
                              data: ChipTheme.of(context)
                                  .copyWith(backgroundColor: secondaryColor),
                              child: ChoiceChip(
                                label: Text(_title!),
                                selected: _value == index,
                                selectedColor: Color(0xff026af1),
                                onSelected: (bool selected) {
                                  setState(
                                    () {
                                      _value = selected ? index : 0;
                                      _selectedChoice =
                                          _value == index ? index : 0;
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  buildMenusCard(context, menuChoice),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Divider(color: Colors.grey),
                  ),
                  Row(
                    children: [
                      Text(
                        "Review",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const Icon(
                        Icons.reviews_rounded,
                        size: 20,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AddReview(
                              provider: prov,
                              id: widget.restaurant!.id,
                            ),
                          );
                        },
                        child: const Text(
                          'Add your review',
                        ),
                      ),
                    ),
                  ),
                  buildReviewsCard(
                    context,
                    resDetail.customerReviews,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
