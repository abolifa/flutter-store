import 'dart:convert';

import 'package:app/models/product.dart';
import 'package:app/services/api_service.dart';
import 'package:flutter/material.dart';

class SectionProductProvider extends ChangeNotifier {
  bool _isLoading = false;
  final ApiService _apiService = ApiService();
  String? _errorMessage;
  final Map<int, List<Product>> _sectionProducts =
      {}; // Store products per section

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Map<int, List<Product>> get sectionProducts => _sectionProducts;

  Future<void> fetchSectionProducts(int sectionId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.get('sections/$sectionId/products');
      if (response.statusCode == 200) {
        final List<dynamic> productList = json.decode(response.body);
        _sectionProducts[sectionId] =
            productList.map((json) => Product.fromJson(json)).toList();
      } else {
        _errorMessage = 'Failed to load products for section $sectionId';
      }
    } catch (e) {
      _errorMessage = 'Error: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
  }
}
