import 'package:flutter/material.dart';
import 'package:product/product_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: ProductPage(productId : 26400163909 ),
      debugShowCheckedModeBanner: false,
    );
  }

}

