class Product {
  final int id;
  final String title;
  final String description;
  final List<String> images; // Change from String to List<String>
  final double price;
  final double discountPercentage;
  final double rating;
  final String category; // Add category field
  final List<Review> reviews; // Add reviews field

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.images, // Update the constructor
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.category, // Add category
    required this.reviews, // Add reviews
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      images: List<String>.from(json['images']), // Ensure it is a list
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      rating: json['rating'].toDouble(),
      category: json['category'], // Add category parsing
      reviews: (json['reviews'] as List)
          .map((review) => Review.fromJson(review)) // Parse reviews
          .toList(),
    );
  }
}

class Review {
  final String reviewerName;
  final String comment;

  Review({
    required this.reviewerName,
    required this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewerName: json['reviewerName'],
      comment: json['comment'],
    );
  }
}
