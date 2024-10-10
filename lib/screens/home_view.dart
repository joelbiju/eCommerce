// ignore: library_private_types_in_public_api
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/screens/product_details.dart';
import 'package:ecommerce_app/view_model/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/widgets/product_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final productViewModel = ProductViewModel();
    try {
      final productData = await productViewModel.fetchProducts();
      setState(() {
        products = productData;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FD),
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
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.65,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final discountPrice = product.price -
                      (product.price * product.discountPercentage / 100);

                  return GestureDetector(
                    child: ProductCard(
                      imageUrl: product.images[0],
                      title: product.title,
                      description: product.description,
                      rating: product.rating,
                      originalPrice: product.price,
                      discountPrice: discountPrice,
                    ),
                    onTap: () {
                      showProductDetails(context, product);
                    },
                  );
                },
              ),
      ),
    );
  }
}