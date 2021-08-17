import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app3/common/styles.dart';

Widget buildMenusCard(BuildContext context, List<dynamic> menuChoice) {
  return Container(
    height: 100,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: menuChoice.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: 200,
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
                    child: Text(menuChoice[index]['name']),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget buildCategoryCard(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 40,
      width: 150,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(32.0)),
        child: Card(
          color: secondaryColor,
          shadowColor: Colors.blueAccent,
          elevation: 5,
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    ),
  );
}

Widget buildReviewsCard(BuildContext context, List<dynamic> custReviews) {
  return Padding(
    padding: const EdgeInsets.only(top: 15.0),
    child: Container(
      height: 215,
      child: ListView.builder(
        itemCount: custReviews.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
              width: 200,
              child: Card(
                shadowColor: secondaryColor,
                elevation: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      // direction: Axis.vertical,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Center(
                            child: Text(
                              custReviews[index]["name"],
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Center(
                            child: Text(
                              "\"" + custReviews[index]["review"] + "\"",
                              style: Theme.of(context).textTheme.subtitle2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Center(
                            child: Text(
                              custReviews[index]["date"],
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
