import 'dart:convert';

import 'package:app/models/address.dart';
import 'package:app/services/api_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Address> _addresses = [];
  bool _isLoading = false;
  String? _message;

  List<Address> get addresses => _addresses;

  bool get isLoading => _isLoading;

  String? get message => _message;

  Address? get defaultAddress =>
      _addresses.firstWhereOrNull((address) => address.defaultAddress);

  Future<void> loadSavedAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedAddressId = prefs.getInt('default_address_id');
    if (savedAddressId != null) {
      setDefaultAddress(savedAddressId);
    }
  }

  Future<void> fetchAddresses() async {
    _isLoading = true;
    _message = '';
    notifyListeners();
    try {
      final response = await _apiService.get('customer/addresses');
      if (response.statusCode == 200) {
        _message = 'تم تحميل العناوين بنجاح';
        List<dynamic> data = jsonDecode(response.body);
        _addresses = data
            .whereType<Map<String, dynamic>>()
            .map((json) => Address.fromJson(json))
            .toList();
        notifyListeners();
        loadSavedAddress();
      } else {
        _message = 'حدث خطأ اثناء تحميل العناوين';
      }
    } catch (e) {
      _message = 'حدث خطأ اثناء تحميل العناوين: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addAddress({
    required String address,
    required String city,
    required String phone,
    required String street,
    required String landmark,
    double? latitude,
    double? longitude,
    required bool defaultAddress,
  }) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      final response = await _apiService.post('customer/addresses', {
        'address': address,
        'city': city,
        'phone': phone,
        'street': street,
        'landmark': landmark,
        'latitude': latitude,
        'longitude': longitude,
        'default': defaultAddress
      });

      if (response.statusCode == 201) {
        _message = 'تم اضافة العنوان بنجاح';
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _message = 'حدث خطأ اثناء اضافة العنوان';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _message = 'حدث خطأ اثناء اضافة العنوان: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> editAddress({
    required int id,
    required String address,
    required String city,
    required String phone,
    required String street,
    required String landmark,
    double? latitude,
    double? longitude,
    required bool defaultAddress,
  }) async {
    try {
      _isLoading = true;
      _message = '';

      Map<String, dynamic> data = {
        "address": address,
        "city": city,
        "street": street,
        "landmark": landmark,
        "phone": phone,
        "latitude": latitude,
        "longitude": longitude,
        "default": defaultAddress,
      };

      final response = await _apiService.put('customer/addresses/$id', data);
      if (response.statusCode == 200) {
        _message = 'تم تعديل العنوان بنجاح';
        notifyListeners();
        _isLoading = false;
        return true;
      } else {
        _isLoading = false;
        _message = 'حدث خطأ اثناء تعديل العنوان';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _message = 'حدث خطأ أثناء تعديل العنوان: $e';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> deleteAddress(int addressId) async {
    _isLoading = true;
    _message = '';
    try {
      final response =
          await _apiService.delete('customer/addresses/$addressId');
      if (response.statusCode == 200) {
        _addresses.removeWhere((address) => address.id == addressId);
        _message = 'تم حذف العنوان بنجاح';
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      _message = 'حدث خطأ اثناء حذف العنوان: $e';
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }

  Future<void> setDefaultAddress(int newDefaultId) async {
    for (var i = 0; i < _addresses.length; i++) {
      _addresses[i] = _addresses[i]
          .copyWith(defaultAddress: _addresses[i].id == newDefaultId);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('default_address_id', newDefaultId);

    notifyListeners();
  }
}
