import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/widgets/product_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/products'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        setState(() {
          products = jsonData['products'];
        });
      } else {
        throw Exception('Failed to load products: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F9FD),
      appBar: AppBar(
        title: const Text(
          'e-Shop',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0C54BE),
      ),
      body: SafeArea(
        child: products.isEmpty 
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.65, 
                ),
                itemCount: products.length, 
                itemBuilder: (context, index) {
                  final product = products[index];
                  final originalPrice = product['price'].toDouble();
                  final discountPercentage = product['discountPercentage'];
                  final discountPrice = discountPercentage != null
                      ? originalPrice - (originalPrice * discountPercentage / 100)
                      : originalPrice; 

                  return ProductCard(
                    imageUrl: product['images'][0], 
                    title: product['title'],
                    description: product['description'],
                    rating: product['rating'].toDouble(), 
                    originalPrice: originalPrice, 
                    discountPrice: discountPrice, 
                  );
                },
              ),
      ),
    );
  }
}
