import 'dart:convert';
import 'dart:typed_data';

class Product {
  final String id;
  final int code;
  final String productName;
  final int nutriScoreOutOf100;
  final Uint8List backgroundImage;

  Product({
    required this.id,
    required this.code,
    required this.productName,
    required this.nutriScoreOutOf100,
    required this.backgroundImage, // Assuming this is the URL initially
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final image = base64Decode(json['background_removed_image']);
    return Product(
      id: json['_id'] as String,
      code: json['code'] as int,
      productName: json['product_name'] as String,
      nutriScoreOutOf100: json['nutriscore_score_out_of_100'] as int,
      backgroundImage: image,
    );
  }


}
