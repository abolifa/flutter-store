import 'dart:convert';

import 'package:app/helpers/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  ApiService();

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<Map<String, String>> _getHeaders() async {
    String? token = await getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<http.Response> get(String endpoint,
      {Map<String, String>? queryParameters}) async {
    final url = Uri.parse('${Constant.baseUrl}$endpoint')
        .replace(queryParameters: queryParameters);
    final headers = await _getHeaders();
    return await http.get(url, headers: headers);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('${Constant.baseUrl}$endpoint');
    final headers = await _getHeaders();
    return await http.post(url, headers: headers, body: jsonEncode(data));
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('${Constant.baseUrl}$endpoint');
    final headers = await _getHeaders();
    return await http.put(url, headers: headers, body: jsonEncode(data));
  }

  Future<http.Response> patch(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('${Constant.baseUrl}$endpoint');
    final headers = await _getHeaders();
    return await http.patch(url, headers: headers, body: jsonEncode(data));
  }

  Future<http.Response> delete(String endpoint) async {
    final url = Uri.parse('${Constant.baseUrl}$endpoint');
    final headers = await _getHeaders();
    return await http.delete(url, headers: headers);
  }
}
