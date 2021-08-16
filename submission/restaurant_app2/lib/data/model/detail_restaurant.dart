class DetailsResult {
  DetailsResult({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  DetailOfRestaurant restaurant;

  factory DetailsResult.fromJson(Map<String, dynamic> json) => DetailsResult(
    error: json["error"],
    message: json["message"],
    restaurant: DetailOfRestaurant.fromJson(json["restaurant"]),
  );

}

class DetailOfRestaurant {
  DetailOfRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<dynamic> categories;
  var menus;
  double rating;
  List<dynamic> customerReviews;


  factory DetailOfRestaurant.fromJson(Map<String, dynamic> json) => DetailOfRestaurant(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      city: json["city"],
      address: json["address"],
      pictureId: "https://restaurant-api.dicoding.dev/images/large/" + json["pictureId"],
      categories: json["categories"],
      menus: json["menus"],
      rating: json["rating"].toDouble(),
      customerReviews: json["customerReviews"]
  );
}