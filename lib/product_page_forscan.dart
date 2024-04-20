import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'Details1.dart';
import 'Details2.dart';
import 'package:flutter_application_2/product_page_c.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import 'product_page.dart';


class ProductPageforScan extends StatelessWidget {
  final int productId;
  final apiService = ApiService();

  ProductPageforScan({required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDF6EC),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(47), // Adjust the preferred height as needed
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Container(
            width: 47,
            height: 47,
            decoration: BoxDecoration(
              color: Color(0xFFECBE5C),
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(left: 10),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          actions: [
            Container(
              width: 47,
              height: 47,
              decoration: BoxDecoration(
                color: Color(0xFFECBE5C),
                shape: BoxShape.circle,
              ),
              margin: EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(Icons.favorite, color: Colors.white),
                onPressed: () {
                  // Add your favorite functionality here
                },
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(top:0.0,left:16.0,right:16.0,bottom: 16.0),
        child: SingleChildScrollView(
          child: Center(
            child: FutureBuilder<ProductF>(
              future: apiService.fetchProduct(productId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show loading spinner when waiting for data
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Handle error by navigating to another page
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPageC(productId: productId),
                      ),
                    );
                  });
                  // Return a placeholder or empty container/widget until the frame callback executes
                  return Center(child: Text('Loading error, redirecting...'));
                } else if (snapshot.hasData) {
                  // When data is received, process it and display your content
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(productId: productId),
                      ),
                    );
                  });

                }
                // Return a default widget if none of the conditions are met
                return SizedBox(); // or any other widget you want to return
              },
            ),
          ),
        ),
      ),
    );
  }
}