import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_application_2/product_page_forscan.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/scan': (context) => const ScanApp(),
    },
  ));
}

class ScanApp extends StatelessWidget {
  const ScanApp({Key? key}) : super(key: key);

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
          builder: (context) => ProductPageforScan(productId:  26400163909),
        ),
      );
    }

    // Initiate the scanning process immediately
    scan();

    // Return an empty container since there's no UI needed
    return Container();
  }
}
