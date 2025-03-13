import 'dart:convert';

import 'package:app/models/product.dart';
import 'package:app/services/api_service.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  bool _isLoading = false;
  final ApiService _apiService = ApiService();
  String? _errorMessage;
  final Map<int, Product> _products = {};

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Map<int, Product> get products => _products;

  Future<void> fetchProductsByIds(List<int> productIds) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await _apiService.get(
        'products/product',
        queryParameters: {
          'product_ids': productIds.join(','),
        },
      );
      if (response.statusCode == 200) {
        final body = response.body;
        if (body.isEmpty) {
          throw Exception("Empty response from server");
        }

        final List<dynamic> productList = json.decode(body);
        _products.clear();

        for (var productJson in productList) {
          if (productJson is Map<String, dynamic>) {
            Product product = Product.fromJson(productJson);
            _products[product.id] = product;
          }
        }
      } else {
        _errorMessage = 'Failed to load products for the given IDs';
      }
    } catch (e) {
      _errorMessage = 'Error: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
  }
}
