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
import 'package:http/http.dart' as http;
import 'product_page.dart';

class ProductPageforScan extends StatefulWidget {
  final String email;
  final int productId;

  const ProductPageforScan(
      {Key? key, required this.email, required this.productId})
      : super(key: key);

  @override
  _ProductPageforScanState createState() => _ProductPageforScanState();
}

class _ProductPageforScanState extends State<ProductPageforScan> {
  late String username = "";
  late String photo = "";

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.15:9000/get_user_profile/'),
        body: {'email': widget.email},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          username = responseData['username'];
          photo = responseData['photo_name'];
        });
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDF6EC),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(47), // Adjust the preferred height as needed
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
        padding: const EdgeInsets.only(
            top: 0.0, left: 16.0, right: 16.0, bottom: 16.0),
        child: SingleChildScrollView(
          child: Center(
            child: FutureBuilder<ProductF>(
              future: apiService.fetchProduct(widget.productId),
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
                        builder: (context) =>
                            ProductPageC(productId: widget.productId),
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
                        builder: (context) => ProductPage(
                            email: widget.email, productId: widget.productId),
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
