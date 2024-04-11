// ProductDetailsDialog.dart

import 'package:flutter/material.dart';

class ProductDetailsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xffFDF6EC),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Scoring Method',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Our scoring method, certified and used by the French government, is based on a concept developed by the UK Food Standards Agency, also known as "model WXYfm," which was evaluated in 2005 by Professor Mike Rayner. The basic calculation algorithm consists of three steps and is based on the nutritional contents of the food:\n\n'
                    '1. Negative points (N) are calculated based on the content of various nutrients considered problematic, such as sugar, high energy density per 100 g or per 100 ml, high content of saturated fatty acids, and high salt content.\n\n'
                    '2. Positive points (P) are calculated based on the content of various nutrients considered beneficial, such as the content of fruits, vegetables, nuts, and legumes, fiber content, protein content, and content of rapeseed, walnut, and olive oil.\n\n'
                    '3. The total score is calculated. In simple cases, the formula is just N-P; however, there are some special cases.\n\n'
                    'Finally, the obtained score is scaled to get a score out of 100.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Image.asset('images/nutri.png'),

              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
