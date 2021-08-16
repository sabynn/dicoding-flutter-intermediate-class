import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app2/data/model/detail_restaurant.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/model/restaurant.dart';
import 'package:restaurant_app2/data/model/reviews.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantsProvider extends ChangeNotifier {
   ApiService apiService;
   String type;
   Restaurant? restaurant;

  RestaurantsProvider({required this.apiService, required this.type, required this.restaurant}) {
    if (type == "list") {
      fetchAllRestaurant();
    }else if (type == "detail"){
      fetchDetailofRestaurant(restaurant!.id);
    }
  }

  dynamic _restaurantsResult;
  late DetailsResult _detailResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  dynamic get resResult => _restaurantsResult;
  DetailsResult get detailResult => _detailResult;
  ResultState get state => _state;

  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.fetchRestaurants();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'There is no restaurant available';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> fetchDetailofRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final res = await apiService.fetchDetails(id);
      if (res.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detailResult = res;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }


  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final res = await apiService.fetchSearch(query);
      if (res.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Sorry, no restaurant found';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsResult = res;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

   Future<dynamic> postReview(Review review) async {
     try {
       final response = await apiService.postReview(review);
       if (!response.error) fetchDetailofRestaurant(review.id!);
     } catch (e) {
       _state = ResultState.Error;
       notifyListeners();
       return _message = 'Error --> $e';
     }
   }
}