import 'package:restaurant_app3/data/model/restaurant.dart';

class DetailsResult {
  DetailsResult({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  Restaurant restaurant;

  factory DetailsResult.fromJson(Map<String, dynamic> json) => DetailsResult(
    error: json["error"],
    message: json["message"],
    restaurant: Restaurant.fromJson(json["restaurant"]),
  );
}