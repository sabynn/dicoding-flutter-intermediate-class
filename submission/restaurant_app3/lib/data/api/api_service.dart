import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app3/data/model/detail_restaurant.dart';
import 'package:restaurant_app3/data/model/restaurant.dart';
import 'package:restaurant_app3/data/model/reviews.dart';
import 'package:restaurant_app3/data/model/search_restaurant.dart';

class ApiService {
  Future<RestaurantsResult> fetchRestaurants() async {
    final response = await http.get(
      Uri.parse("https://restaurant-api.dicoding.dev/list"),
    );

    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load list restaurants');
    }
  }

  Future<DetailsResult> fetchDetails(String id) async {
    final response = await http.get(
      Uri.parse("https://restaurant-api.dicoding.dev/detail/$id"),
    );

    if (response.statusCode == 200) {
      return DetailsResult.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load detail of restaurant');
    }
  }

  Future<SearchResult> fetchSearch(String query) async {
    final response = await http.get(
      Uri.parse("https://restaurant-api.dicoding.dev/search?q=$query"),
    );

    if (response.statusCode == 200) {
      return SearchResult.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load search');
    }
  }

  Future<ReviewsResult> postReview(Review review) async {
    var _review = jsonEncode(
      review.toJson(),
    );

    final response = await http.post(
      Uri.parse("https://restaurant-api.dicoding.dev/review"),
      body: _review,
      headers: <String, String>{
        "Content-Type": "application/json",
        "X-Auth-Token": "12345",
      },
    );

    if (response.statusCode == 200) {
      return ReviewsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post review');
    }
  }
}
