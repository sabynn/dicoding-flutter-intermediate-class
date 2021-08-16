import 'ui/splash_screen.dart';
import 'model/restaurant.dart';
import 'ui/detail_page.dart';
import 'ui/list_page.dart';
import 'common/styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: myTextTheme,

        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: secondaryColor,
          titleTextStyle: myTextTheme.headline6,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: secondaryColor,
          ),
        ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: secondaryColor),
      ),
      initialRoute: RestaurantSplashScreen.routeName,
      routes: {
        RestaurantSplashScreen.routeName: (context) => const RestaurantSplashScreen(),
        RestaurantsListPage.routeName: (context) => RestaurantsListPage(),
        RestaurantDetails.routeName: (context) => RestaurantDetails(
          restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
        ),
      },
    );
  }
}