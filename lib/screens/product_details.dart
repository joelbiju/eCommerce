import 'package:flutter/material.dart';
import 'package:ecommerce_app/model/product_model.dart'; // Import the Product model

void showProductDetails(BuildContext context, Product product) {
  final discountPrice = product.price -(product.price * product.discountPercentage / 100);
  final formattedDiscountPrice = discountPrice.toStringAsFixed(2);
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFFF5F9FD),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Swipeable image gallery using PageView
                Center(
                  child: SizedBox(
                    height: 200,
                    child: PageView.builder(
                      itemCount: product.images.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          product.images[index],
                          fit: BoxFit.fitHeight,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  product.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Category: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold, 
                        ),
                      ),
                      TextSpan(
                        text: product.category, 
                        style: TextStyle(
                          fontSize: 16, 
                          fontWeight: FontWeight.normal, 
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8),
                
                Text(
                  'Price: \$$formattedDiscountPrice', // Price
                  style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Details:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        product.description,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Reviews:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: product.reviews.length,
                        itemBuilder: (context, index) {
                          final review = product.reviews[index];
                          return ListTile(
                            title: Text(
                              review.reviewerName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold, // Make the title bold
                              ),
                            ),
                            subtitle: Text(review.comment),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
