import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  runApp(const ScanApp());
}

class ScanApp extends StatelessWidget {
  const ScanApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ScanPage(),
    );
  }
}

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  Future<void> scan() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );

    print("Barcode: $barcodeScanRes");
    // Do whatever you want with the scanned barcode
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: scan,
          child: const Text('Scan'),
        ),
      ),
    );
  }
}
