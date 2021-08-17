import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_app3/common/styles.dart';
import 'package:restaurant_app3/data/model/reviews.dart';
import 'package:restaurant_app3/provider/restaurants_provider.dart';

class AddReview extends StatelessWidget {
  final RestaurantsProvider provider;
  final String id;

  const AddReview({required this.provider, required this.id});

  @override
  Widget build(BuildContext context) {
    var _name = TextEditingController();
    var _review = TextEditingController();
    var _formKey = GlobalKey<FormState>();

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Add Your Review",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: _name,
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return "Please fill the name field";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      hintText: "Input Your Name...",
                      prefixIcon: const Icon(Icons.person),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                        left: 10,
                        top: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 5,
                    controller: _review,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please fill the review field";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      hintText: "Input Your Review...",
                      prefixIcon: const Icon(Icons.rate_review_rounded),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                        left: 10,
                        top: 5,
                        bottom: 5,
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Sending your review..."),
                              ),
                            );
                            Review review = Review(
                              id: id,
                              name: _name.text,
                              review: _review.text,
                              date: DateFormat('dd MM yyyy').format(
                                DateTime.now(),
                              ),
                            );
                            provider.postReview(review).then((value) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Successfully add your review"),
                                ),
                              );
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: const Text("Save"),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          onPrimary: secondaryColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                    ),
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
