import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_application_2/product_page_forscan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScanApp extends StatefulWidget {
  final String email;
  

  const ScanApp({Key? key, required this.email}) : super(key: key);
   
  @override
  _ScanAppState createState() => _ScanAppState();
}


class _ScanAppState extends State<ScanApp> {
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


  @override
  Widget build(BuildContext context) {
    Future<void> scan() async {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );


      // Navigate to the ProductPage with the scanned productId
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProductPageforScan(email:widget.email,productId:  26400163909),
        ),
      );
    }

    // Initiate the scanning process immediately
    scan();

    // Return an empty container since there's no UI needed
    return Container();
  }
}