import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:restaurant_app3/common/styles.dart';
import 'list_page.dart';

class RestaurantSplashScreen extends StatelessWidget {
  static const routeName = '/splash_screen';

  const RestaurantSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.bottomToTop,
              duration: const Duration(milliseconds: 700),
              child: RestaurantsListPage(),
            ),
          );
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFA7C7E7), Color(0xff026af1)],
                ),
              ),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 30),
                      Text(
                        'Restaurants',
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .apply(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(60.0),
                        child: SizedBox(
                          height: 50,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: Card(
                              color: primaryColor,
                              child: Center(
                                child: Text(
                                  'Tap anywhere to see the list!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .apply(color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
