import 'dart:convert';

import 'package:app/models/customer.dart';
import 'package:app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  Customer? _customer;
  bool _isLoading = false;
  String? _errorMessage;

  Customer? get customer => _customer;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  bool get isAuthenticated => _customer != null;

  final ApiService _apiService = ApiService();

  AuthProvider() {
    loadUser();
  }

  Future<void> loadUser() async {
    _isLoading = true;
    notifyListeners();

    String? token = await _getToken();
    if (token == null) {
      _customer = null;
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      final response = await _apiService.get('customer/profile');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _customer = Customer.fromJson(responseData);
      } else {
        await logout();
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch user data';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.post('customer/login', {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final String token = responseData['token'];
        final customerData = responseData['user'];
        await _saveToken(token);
        _customer = Customer.fromJson(customerData);
        notifyListeners();
        return true;
      } else {
        final errorResponse = jsonDecode(response.body);
        _errorMessage = errorResponse['message'] ?? 'Login failed';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.post('customer/register', {
        'name': name,
        'email': email,
        'password': password,
      });

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final String token = responseData['token'];
        final customerData = responseData['user'];

        await _saveToken(token);
        _customer = Customer.fromJson(customerData);
        notifyListeners();
        return true;
      } else {
        final errorResponse = jsonDecode(response.body);
        _errorMessage = errorResponse['message'] ?? 'Registration failed';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    _customer = null;
    notifyListeners();
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
