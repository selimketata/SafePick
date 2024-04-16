// ProductDetailsDialog.dart

import 'package:flutter/material.dart';

class Details1 extends StatelessWidget {
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
                'Energy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'High energy density foods often contain a high amount of fats and/or sugars, which can contribute to their caloric density. The Nutri-Score system aims to encourage the consumption of foods that are lower in energy density and higher in nutritional value, such as fruits, vegetables, and whole grains, by assigning them higher scores or positive points.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),

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
