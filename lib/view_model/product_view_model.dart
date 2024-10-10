import 'dart:convert';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductViewModel {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> productList = jsonData['products'];

      return productList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
