import 'dart:convert';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late num rating;
  late Map<String, dynamic> menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  Restaurant.fromJson(Map<String, dynamic> Restaurant) {
    id = Restaurant['id'];
    name = Restaurant['name'];
    description = Restaurant['description'];
    pictureId = Restaurant['pictureId'];
    city = Restaurant['city'];
    rating = Restaurant['rating'];
    menus = Restaurant['menus'];
  }
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> p = jsonDecode(json);
  final List parsed = p['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
