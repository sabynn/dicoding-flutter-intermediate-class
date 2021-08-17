import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName, Object arguments) {
    print("MASUKKK: " + routeName + " " + arguments.toString());
    navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  static back() => navigatorKey.currentState?.pop();
}
