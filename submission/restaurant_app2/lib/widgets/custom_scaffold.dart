import 'package:flutter/material.dart';
import 'package:restaurant_app2/common/styles.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String theTitle;
  const CustomScaffold({required this.body, required this.theTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            body,
            _buildShortAppBar(context, theTitle),
          ],
        ),
      ),
    );
  }
}

Widget _buildShortAppBar(BuildContext context, String theTitle) {
  return Card(
    color: secondaryColor,
    margin: const EdgeInsets.all(0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Text(
            theTitle,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    ),
    shape: const ContinuousRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(16.0),
      ),
    ),
  );
}

