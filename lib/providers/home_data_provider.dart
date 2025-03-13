import 'dart:convert';

import 'package:app/models/home_data.dart';
import 'package:app/services/api_service.dart';
import 'package:flutter/material.dart';

class HomeDataProvider with ChangeNotifier {
  HomeData? _homeData;
  bool _isLoading = false;
  String? _errorMessage;

  final ApiService _apiService = ApiService();

  HomeData? get homeData => _homeData;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> fetchHomeData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _errorMessage = null;
      final response = await _apiService.get('home');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        _homeData = HomeData.fromJson(data);
      } else {
        var data = json.decode(response.body);
        _errorMessage = data['message'];
        throw Exception('Failed to load home data');
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
