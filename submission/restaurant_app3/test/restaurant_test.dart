import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app3/data/api/api_service.dart';
import 'package:restaurant_app3/data/model/detail_restaurant.dart';
import 'package:restaurant_app3/data/model/restaurant.dart';
import 'package:restaurant_app3/data/model/reviews.dart';
import 'package:restaurant_app3/provider/restaurants_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'restaurant_test.mocks.dart';

@GenerateMocks([RestaurantsProvider, ApiService])
void main() {
  group('Restaurant Test', () {
    Restaurant? restaurant;
    ApiService? apiService;

    setUp(() {
      apiService = MockApiService();
      restaurant = Restaurant(
        id: "restaurant_test",
        name: "Restaurant",
        description: "For testing",
        city: "Bangka",
        address: "Sudirman street",
        pictureId: "1",
        categories: ["testing"],
        menus: ["foods1", "drink2"],
        rating: 5.0,
        customerReviews: [
          Review(
            id: "gd18bigbang19",
            name: "Kwon Ji Yong",
            review: "best one",
            date: "18 Agustus 2020",
          ),
        ],
      );
    });

    test('Should success parsing JSON', () {
      var result = Restaurant.fromJson(restaurant!.toJson());
      expect(result.name, restaurant!.name);
    });

    test("Should return detail of restaurant from API", () async {
      when(apiService!.fetchDetails(restaurant!.id)).thenAnswer((_) async {
        return DetailsResult(
          error: false,
          message: 'success',
          restaurant: restaurant!,
        );
      });
      expect(
        await apiService!.fetchDetails(restaurant!.id),
        isA<DetailsResult>(),
      );
    });
  });
}
