import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app3/common/styles.dart';

Widget errorNoConnection(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Center(
          child: Icon(
            Icons.wifi_off,
            size: 150,
            color: secondaryColor,
          ),
        ),
        Center(
          child: Text(
            "Connection Failed",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Please check your internet connection and try again",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    ),
  );
}

Widget noData(BuildContext context, var state) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Icon(
          Icons.search_off_rounded,
          size: 100,
          color: secondaryColor,
        ),
        Text(
          state.message,
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    ),
  );
}
