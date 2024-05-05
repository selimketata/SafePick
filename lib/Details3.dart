// ProductDetailsDialog.dart

import 'package:flutter/material.dart';

class Details3 extends StatelessWidget {
  const Details3({super.key});

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
                'Palm Oil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Palm oil is often criticized when used in cosmetics due to environmental concerns surrounding its production. The cultivation of palm oil plantations, particularly in countries like Indonesia and Malaysia, is one of the leading causes of deforestation in tropical regions. This deforestation results in the loss of habitats for endangered species, such as orangutans, tigers, and rhinoceroses, and contributes to significant biodiversity loss. Additionally, the conversion of carbon-rich peatlands to palm oil plantations releases large amounts of greenhouse gases into the atmosphere, exacerbating climate change. Although there are sustainable palm oil certifications aimed at minimizing environmental impact, the effectiveness and enforcement of these standards can vary, leading to continued scrutiny of palm oil use in various industries, including cosmetics.',
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