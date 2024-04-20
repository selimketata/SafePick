import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ApiService {
  // Singleton instance
  static final ApiService _instance = ApiService._internal();

  // Private constructor
  ApiService._internal();

  // Factory constructor to get the singleton instance
  factory ApiService() {
    return _instance;
  }

  Future<ProductF> fetchProduct(int productCode) async {
    final response =
        await http.get(Uri.parse('http://192.168.1.16:9000/food/$productCode/'));
    if (response.statusCode == 200) {
      return ProductF.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }
}
