import 'dart:convert';

import 'package:app/services/api_service.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<int> _favoriteProductIds = [];
  String? _message;

  List<int> get favoriteProductIds => _favoriteProductIds;

  String? get message => _message;

  Future<void> loadFavorites() async {
    _message = null;
    try {
      final response =
          await _apiService.get('favorites'); // Fetch favorites from API
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _favoriteProductIds = List<int>.from(data);
        notifyListeners();
      }
    } catch (e) {
      _message = 'Error loading favorites: $e';
    }
  }

  Future<void> addFavorite(int productId) async {
    _message = null;
    try {
      final response =
          await _apiService.post('favorites', {"product_id": productId});
      if (response.statusCode == 201) {
        _favoriteProductIds.add(productId);
        notifyListeners();
      }
    } catch (e) {
      _message = 'Error adding to favorites: $e';
    }
  }

  Future<void> removeFavorite(int productId) async {
    _message = null;
    try {
      final response =
          await _apiService.delete('favorites/$productId'); // Use dynamic route
      if (response.statusCode == 200) {
        _favoriteProductIds.remove(productId);
        notifyListeners();
      }
    } catch (e) {
      _message = 'Error removing from favorites: $e';
    }
  }

  Future<void> toggleFavorite(int productId) async {
    if (_favoriteProductIds.contains(productId)) {
      await removeFavorite(productId);
    } else {
      await addFavorite(productId);
    }
  }

  bool isFavorite(int productId) {
    return _favoriteProductIds.contains(productId);
  }
}
