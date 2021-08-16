import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/styles.dart';
import '../widgets/custom_scaffold.dart';
import '../model/restaurant.dart';

class RestaurantDetails extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurant;

  const RestaurantDetails({required this.restaurant});

  @override
  State createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetails> {
  int _selectedChoice = 0;
  int? _value = 0;
  String? _title = "All";

  @override
  Widget build(BuildContext context) {
    List<dynamic> cardChoice = widget.restaurant.menus['foods'];
    if (_selectedChoice == 1) {
      cardChoice = widget.restaurant.menus['foods'];
    } else if (_selectedChoice == 2) {
      cardChoice = widget.restaurant.menus['drinks'];
    } else {
      cardChoice =
          widget.restaurant.menus['foods'] + widget.restaurant.menus['drinks'];
    }

    return SafeArea(
      child: CustomScaffold(
        theTitle: widget.restaurant.name,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: widget.restaurant.pictureId,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.network(widget.restaurant.pictureId),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.black26,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'City: ${widget.restaurant.city}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.black26,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Rating: ${widget.restaurant.rating}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.grey),
                    Text(
                      widget.restaurant.description,
                      style: Theme.of(context).textTheme.bodyText1,
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
                                  label: Text('$_title'),
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
                    Container(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cardChoice.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SizedBox(
                              width: 200,
                              height: 50,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Coming Soon!'),
                                        content: const Text(
                                          'The feature to see foods detail will be coming soon!',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Card(
                                  shadowColor: secondaryColor,
                                  elevation: 10,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Center(
                                      child: Text(cardChoice[index]['name']),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
