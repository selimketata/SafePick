import 'package:flutter/material.dart';
import 'package:flutter_application_2/product_page_forscan.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/productC-.dart'; // Adjust the path as necessary

class SearchResultsPageC extends StatefulWidget {
  final String query;
  final String email;  // Added email property

  SearchResultsPageC({required this.query, required this.email});

  @override
  _SearchResultsPageCState createState() => _SearchResultsPageCState();
}

class _SearchResultsPageCState extends State<SearchResultsPageC> {
  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData(widget.query);
  }

  Future<void> _fetchData(String query) async {
    try {
      final response = await http.get(Uri.parse("http://192.168.1.15:9000/cosmetics/search/?q=$query"));
      if (response.statusCode == 200) {
        List<dynamic> productsJson = json.decode(response.body)['data'];
        setState(() {
          _products = productsJson.map((json) => Product.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _products = [];
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _products = [];
      });
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDF6EC),
      appBar: AppBar(
        title: Text('Search Results for "${widget.query}"',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'SF Pro Text',
          ),),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xffECBE5C)))
          : CustomScrollView(
        slivers: <Widget>[
          buildProductsSliver(products: _products),
        ],
      ),
    );
  }

  Widget buildProductsSliver({required List<Product> products}) {
    return SliverPadding(
      padding: EdgeInsets.all(16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            final product = products[index];
            return Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(  // Changed to Image.network if it's a URL
                        product.backgroundImage,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(product.productName),
                    subtitle: Text('${product.nutriScoreOutOf100}/100'),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductPageforScan(
                                email: widget.email,
                                productId: product.code),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
