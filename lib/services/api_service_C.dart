import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/productC.dart';

class ApiService {
  // Singleton instance
  static final ApiService _instance = ApiService._internal();

  // Private constructor
  ApiService._internal();

  // Factory constructor to get the singleton instance
  factory ApiService() {
    return _instance;
  }

  Future<ProductC> fetchProduct(int productCode) async {
    final response = await http
        .get(Uri.parse('http://192.168.1.2:9000/cosmetics/$productCode/'));
    if (response.statusCode == 200) {
      return ProductC.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }
}
