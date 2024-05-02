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
    String productName = json['product_name'] as String? ?? 'No Name Available';
    String id = json['id'] as String? ?? 'No Name Available';
    int code = json['code'] as int? ?? 1 ;
    int score = json['nutriscore_score_out_of_100'] as int? ?? 1;




    return Product(
      id: id,
      code: code,
      productName: productName ,
      nutriScoreOutOf100: score,
      backgroundImage: image,
    );
  }


}
