// ProductDetailsDialog.dart

import 'package:flutter/material.dart';

class Details2 extends StatelessWidget {
  const Details2({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xffFDF6EC),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Fibers',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Fiber is an essential component of a healthy diet, often referred to as nature\'s broom for its role in digestive health. Found in fruits, vegetables, whole grains, legumes, nuts, and seeds, fiber offers numerous health benefits. It promotes regular bowel movements, aids in blood sugar control by slowing down the absorption of sugar, helps lower LDL cholesterol levels, supports weight management by promoting feelings of fullness, and facilitates the absorption of nutrients from other foods. Due to its crucial role in promoting overall health and well-being, fiber is assigned positive points in nutrition scoring systems like the Nutri-Score. This encourages individuals to consume fiber-rich foods as part of a balanced diet, contributing to better health outcomes and disease prevention.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
