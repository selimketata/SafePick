import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:product/ProductDetailsPage.dart';
import 'dart:convert';
import 'ProductDetailsPage.dart';
import 'Details1.dart';
import 'Details2.dart';
// Define the backend URL constant
const String backendUrl = 'http://192.168.59.1:8000';

class ProductPage extends StatelessWidget {
  Future<Map<String, dynamic>> fetchProductDetails() async {
    final productResponse = await http.get(Uri.parse('$backendUrl/food/26400163909/'));
    if (productResponse.statusCode == 200) {
      // If the request is successful, parse the JSON response
      final productData = jsonDecode(productResponse.body);
      final productName = productData['product_name'];
      final image = productData['background_removed_image'];
      final percentage = productData['nutriscore_score_out_of_100'];
      final energyKcal = productData['energy_kcal_100g'];
      final energy = productData['energy_100g'];
      final fat = productData['fat_100g'];
      final saturatedFat = productData['saturated_fat_100g'];
      final transFat = productData['trans_fat_100g'];
      final cholesterol = productData['cholesterol_100g'];
      final carbohydrates = productData['carbohydrates_100g'];
      final sugars = productData['sugars_100g'];
      final fiber = productData['fiber_100g'];
      final proteins = productData['proteins_100g'];
      final salt = productData['salt_100g'];
      final sodium = productData['sodium_100g'];
      final vitaminA = productData['vitamin_a_100g'];
      final vitaminK = productData['vitamin_k_100g'];
      final vitaminC = productData['vitamin_c_100g'];
      final vitaminB1 = productData['vitamin_b1_100g'];
      final vitaminB2 = productData['vitamin_b2_100g'];
      final vitaminPP = productData['vitamin_pp_100g'];
      final vitaminB6 = productData['vitamin_b6_100g'];
      final vitaminB9 = productData['vitamin_b9_100g'];
      final pantothenicAcid = productData['pantothenic_acid_100g'];
      final potassium = productData['potassium_100g'];
      final calcium = productData['calcium_100g'];
      final phosphorus = productData['phosphorus_100g'];
      final iron = productData['iron_100g'];
      final magnesium = productData['magnesium_100g'];
      final zinc = productData['zinc_100g'];
      final copper = productData['copper_100g'];
      final manganese = productData['manganese_100g'];
      final selenium = productData['selenium_100g'];
      final fruitsVegetablesNutsEstimate = productData['fruits_vegetables_nuts_estimate_from_ingredients_100g'];
      final phylloquinone = productData['phylloquinone_100g'];
      final pnns1 = productData['pnns_groups_1'];
      final pnns2 = productData['pnns_groups_2'];
      final allergens = productData['allergens'];

      return {
        'product_name': productName,
        'background_removed_image': image,
        'percentage': percentage,
        'energy_kcal_100g': energyKcal,
        'energy_100g': energy,
        'fat_100g': fat,
        'saturated_fat_100g': saturatedFat,
        'trans_fat_100g': transFat,
        'cholesterol_100g': cholesterol,
        'carbohydrates_100g': carbohydrates,
        'sugars_100g': sugars,
        'fiber_100g': fiber,
        'proteins_100g': proteins,
        'salt_100g': salt,
        'sodium_100g': sodium,
        'vitamin_a_100g': vitaminA,
        'vitamin_k_100g': vitaminK,
        'vitamin_c_100g': vitaminC,
        'vitamin_b1_100g': vitaminB1,
        'vitamin_b2_100g': vitaminB2,
        'vitamin_pp_100g': vitaminPP,
        'vitamin_b6_100g': vitaminB6,
        'vitamin_b9_100g': vitaminB9,
        'pantothenic_acid_100g': pantothenicAcid,
        'potassium_100g': potassium,
        'calcium_100g': calcium,
        'phosphorus_100g': phosphorus,
        'iron_100g': iron,
        'magnesium_100g': magnesium,
        'zinc_100g': zinc,
        'copper_100g': copper,
        'manganese_100g': manganese,
        'selenium_100g': selenium,
        'fruits_vegetables_nuts_estimate_from_ingredients_100g': fruitsVegetablesNutsEstimate,
        'phylloquinone_100g': phylloquinone,
        'pnns1' : pnns1,
        'pnns2' : pnns2,
        'allergens' :allergens
      };
    } else {
      // If the request fails, throw an exception
      throw Exception('Failed to load product details');
    }

}










  @override
  Widget build(BuildContext context) {
    bool _isExpanded = false;
    double categoryHeight = MediaQuery.of(context).size.height * 0.07;

    return SafeArea(
      child: Scaffold(
      backgroundColor: Color(0xffFDF6EC),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.only(left :5.0, right:5,top:0),
        // Add 2mm padding to all sides
        child: Stack(
          children: [
            // Circles positioned at the top corners
            Positioned(
              top: 40,
              left: 20,
              child: Container(
                width: 47,
                height: 47,
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFECBE5C),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: Container(
                width: 47,
                height: 47,
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    // Add your favorite functionality here
                  },
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFECBE5C),
                ),
              ),
            ),
            // Display product name and image just below the circles
            Positioned(
              top: 100, // Adjust as needed
              left: 0,
              right: 0,
              child: Center(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: fetchProductDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Display a loading indicator while waiting for the response
                      return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffECBE5C)), );// Adjust the thickness of the progress indicator);
                    } else if (snapshot.hasError) {
                      // Display an error message if an error occurs
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final productName = snapshot.data!['product_name'];
                      final image = snapshot.data!['background_removed_image'];
                      final percentage = snapshot.data!['percentage'];
                      final energyKcal = snapshot.data!['energy_kcal_100g'];
                      final energy = snapshot.data!['energy_100g'];
                      final fat = snapshot.data!['fat_100g'];
                      final saturatedFat = snapshot.data!['saturated_fat_100g'];
                      final transFat = snapshot.data!['trans_fat_100g'];
                      final cholesterol = snapshot.data!['cholesterol_100g'];
                      final carbohydrates = snapshot.data!['carbohydrates_100g'];
                      final sugars = snapshot.data!['sugars_100g'];
                      final fiber = snapshot.data!['fiber_100g'];
                      final proteins = snapshot.data!['proteins_100g'];
                      final salt = snapshot.data!['salt_100g'];
                      final sodium = snapshot.data!['sodium_100g'];
                      final vitaminA = snapshot.data!['vitamin_a_100g'];
                      final vitaminK = snapshot.data!['vitamin_k_100g'];
                      final vitaminC = snapshot.data!['vitamin_c_100g'];
                      final vitaminB1 = snapshot.data!['vitamin_b1_100g'];
                      final vitaminB2 = snapshot.data!['vitamin_b2_100g'];
                      final vitaminPP = snapshot.data!['vitamin_pp_100g'];
                      final vitaminB6 = snapshot.data!['vitamin_b6_100g'];
                      final vitaminB9 = snapshot.data!['vitamin_b9_100g'];
                      final pantothenicAcid = snapshot.data!['pantothenic_acid_100g'];
                      final potassium = snapshot.data!['potassium_100g'];
                      final calcium = snapshot.data!['calcium_100g'];
                      final phosphorus = snapshot.data!['phosphorus_100g'];
                      final iron = snapshot.data!['iron_100g'];
                      final magnesium = snapshot.data!['magnesium_100g'];
                      final zinc = snapshot.data!['zinc_100g'];
                      final copper = snapshot.data!['copper_100g'];
                      final manganese = snapshot.data!['manganese_100g'];
                      final selenium = snapshot.data!['selenium_100g'];
                      final fruitsVegetablesNutsEstimate = snapshot.data!['fruits_vegetables_nuts_estimate_from_ingredients_100g'];
                      final phylloquinone = snapshot.data!['phylloquinone_100g'];
                      final pnns1 = snapshot.data!['pnns1'];
                      final pnns2 = snapshot.data!['pnns2'];
                      final allergens = snapshot.data!['allergens'];
                      Map<String, String> nutrientMap = {
                        'energy_100g': 'energy',
                        'fat_100g': 'fat',
                        'saturated_fat_100g': 'saturatedFat',
                        'trans_fat_100g': 'transFat',
                        'cholesterol_100g': 'cholesterol',
                        'carbohydrates_100g': 'carbohydrates',
                        'sugars_100g': 'sugars',
                        'fiber_100g': 'fiber',
                        'proteins_100g': 'proteins',
                        'salt_100g': 'salt',
                        'sodium_100g': 'sodium',
                        'vitamin_a_100g': 'vitaminA',
                        'vitamin_k_100g': 'vitaminK',
                        'vitamin_c_100g': 'vitaminC',
                        'vitamin_b1_100g': 'vitaminB1',
                        'vitamin_b2_100g': 'vitaminB2',
                        'vitamin_pp_100g': 'vitaminPP',
                        'vitamin_b6_100g': 'vitaminB6',
                        'vitamin_b9_100g': 'vitaminB9',
                        'pantothenic_acid_100g': 'pantothenicAcid',
                        'potassium_100g': 'potassium',
                        'calcium_100g': 'calcium',
                        'phosphorus_100g': 'phosphorus',
                        'iron_100g': 'iron',
                        'magnesium_100g': 'magnesium',
                        'zinc_100g': 'zinc',
                        'copper_100g': 'copper',
                        'manganese_100g': 'manganese',
                        'selenium_100g': 'selenium',
                        'fruits_vegetables_nuts_estimate_from_ingredients_100g': 'fruitsVegetablesNutsEstimate',
                        'phylloquinone_100g': 'phylloquinone',
                        'pnns1': 'pnns1',
                        'pnns2': 'pnns2',
                        'allergens': 'allergens',
                      };






                      Uint8List byte = base64Decode(image);

                      return
                        Stack(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 20),
                              Text(
                                productName,
                                style: TextStyle(
                                  fontSize: 30, // Change font size to 36
                                  fontWeight: FontWeight.w700, // FontWeight.bold is equivalent to FontWeight.w700
                                  fontFamily: 'SF Pro Text', // Use the SF Pro Text font family
                                ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                height: 240,
                                width: 240,
                                child: CircularPercentIndicator(
                                  animation: true,
                                  animationDuration: 1000,
                                  radius: 120, // Adjust the radius as needed
                                  lineWidth: 20,
                                  percent: percentage.toDouble()/100, // Set the percentage value
                                  center: Image.memory(
                                    byte,
                                    height: 160,
                                    width: 160,
                                  ),
                                  backgroundColor: Color(0xffD70404),
                                  progressColor: Color(0xff5CB287),
                                  circularStrokeCap: CircularStrokeCap.round,
                                ),
                              ),
                              SizedBox(height: 10), // Add some space between the circular indicator and the percentage
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$percentage%', // Display the percentage
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10), // Add some space between the percentage and the image
                                  Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage('images/approuver.png'), // Replace 'assets/small_image.png' with your image path
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20), // Add space between the percentage and the text
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // 'Ingredients' text on the left
                                  Text(
                                    'Nutritients:',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'SF Pro Text',
                                    ),
                                  ),
                                  Spacer(),
                                  // Add space between 'Ingredients' and 'Details'
                                  // Container for 'Details' on the right
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ProductDetailsDialog() ; // Show ProductDetailsDialog as a dialog
                                        },
                                      );
                                    },
                                child:  Container(
                                     height: 30, // Adjust height as needed
                                     width: 100, // Adjust width as needed
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                             color: Color(0xffECBE5C), // Specify border color
                                             width: 3, // Adjust border width as needed
                                         ),
                                        borderRadius: BorderRadius.circular(15), // Add border radius for rounded corners
                                      ),

                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: EdgeInsets.all(2), // Adjust padding as needed
                                            child: Text(
                                              'Details', // Add 'Details' text
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'SF Pro Text',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                    ),
                                ],

                              ).animate().fade(duration: 550.ms).slideY(),
                              SizedBox(height :10,),

                              SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                               scrollDirection: Axis.horizontal,
                               child:Container(
                                    width: MediaQuery.of(context).size.width - 20,
                               child :
                               Column(

                             children : <Widget>[
                              Container(
                                padding: EdgeInsets.all(5),
                                 height:categoryHeight,

                                 decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xffD9D9D9).withOpacity(0.5),

                                ),
                                child: Row(
                                  children:<Widget> [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 6),
                                          child: Text(
                                            'energyKcal',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontFamily: 'SF Pro Text',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 6),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 7,
                                                height: 7,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xffF1755B), // Adjust color as needed
                                                ),
                                              ),
                                              SizedBox(width: 4), // Adjust spacing as needed
                                              Text(
                                                'Value: $energyKcal',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )

                                      ],
                                    ),
                                    Spacer(),

                                    Padding(
                                      padding: EdgeInsets.all(15),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Details1() ; // Show ProductDetailsDialog as a dialog
                                            },
                                          );
                                        },
                                      child: Icon(Icons.info, color: Colors.grey),
                                    ),
                                ),
                                  ],
                                ),
                              ).animate().fade(duration: 550.ms).slideY(),
                              SizedBox(height: 10), // Add space between the containers

                              // Second Container (Copy and paste the first Container code here)
                              Container(
                                padding: EdgeInsets.all(5),
                                height:categoryHeight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xffD9D9D9).withOpacity(0.5),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 6),
                                          child: Text(
                                            'Fibers',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontFamily: 'SF Pro Text',

                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 6),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 7,
                                                height: 7,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xff5CB287), // Adjust color as needed
                                                ),
                                              ),
                                              SizedBox(width: 4), // Adjust spacing as needed
                                              Text(
                                                'Value: $fiber',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.all(15),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Details2() ; // Show ProductDetailsDialog as a dialog
                                            },
                                          );
                                        },
                                      child: Icon(Icons.info, color: Colors.grey),
                                    ),
                                    ),
                                  ],
                                ),
                              ).animate().fade(duration: 550.ms).slideY(),
                              SizedBox(height: 10), // Add space between the containers

                              // Third Container (Copy and paste the first Container code here)
                            ClipRRect(
                             borderRadius: BorderRadius.circular(20),


                             child: ExpansionTile(
                                tilePadding: EdgeInsets.only(left :10, right: 17),
                                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                collapsedTextColor: Colors.black,
                                collapsedBackgroundColor: Color(0xffD9D9D9).withOpacity(0.5),
                                backgroundColor: Color(0xffD9D9D9).withOpacity(0.5),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '30 other nutrients',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: 'SF Pro Text',
                                      ),
                                    ),
                                    Text(
                                      'Allergens and more..',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                               children: nutrientMap.entries.map((entry) => buildInfoRow(entry.value, snapshot.data![entry.key])).toList(),

                             ).animate().fade(duration: 550.ms).slideY(),
                            ),
                             ],
                               ),

                              ),
                              ),

                            ],
                          ),



                                  // Add more additional information texts as needed
                          Positioned(
                            top: 10, // Adjust as needed
                            left: 80,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffECBE5C), // Change color as needed
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10, // Adjust as needed
                            left: 250,
                            child: Container(
                              width: 17,
                              height: 17,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffECBE5C), // Change color as needed
                              ),
                            ),
                          ),
                          Positioned(
                            top: 60, // Adjust as needed
                            left: 160,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff5CB287), // Change color as needed
                              ),
                            ),
                          ),




                        ],




                    );

                    }
                  },
                ),
              ),
            ),
            MyDraggableSheet(
                child: Column(
                  children: [
                    BottomSheetDummyUI(),
                    BottomSheetDummyUI(),
                    BottomSheetDummyUI(),
                    BottomSheetDummyUI(),
                    BottomSheetDummyUI(),
                    BottomSheetDummyUI(),
                    BottomSheetDummyUI(),
                  ],
                )).animate().fade(delay: 1000.ms ),
          ],
        ),


    ),


    ),

    );
  }
}

Widget buildInfoRow(String title, dynamic value) {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'SF Pro Text',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Text(
                  'Value: $value',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

class BottomSheetDummyUI extends StatelessWidget {
  const BottomSheetDummyUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      color: Colors.black12,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          color: Colors.black12,
                          height: 20,
                          width: 240,
                        ),
                      ),
                      SizedBox(height: 5),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          color: Colors.black12,
                          height: 20,
                          width: 180,
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10),
            ],
          )),
    );
  }
}

class MyDraggableSheet extends StatefulWidget {
  final Widget child;
  const MyDraggableSheet({Key? key, required this.child});

  @override
  State<MyDraggableSheet> createState() => _MyDraggableSheetState();
}

class _MyDraggableSheetState extends State<MyDraggableSheet> {
  final sheet = GlobalKey();
  final controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    controller.addListener(onChanged);
  }

  void onChanged() {
    final currentSize = controller.size;
    if (currentSize <= 0.05) collapse();
  }

  void collapse() => animateSheet(getSheet.snapSizes!.first);

  void anchor() => animateSheet(getSheet.snapSizes!.last);

  void expand() => animateSheet(getSheet.maxChildSize);

  void hide() => animateSheet(getSheet.minChildSize);

  void animateSheet(double size) {
    controller.animateTo(
      size,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  DraggableScrollableSheet get getSheet =>
      (sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return DraggableScrollableSheet(
        key: sheet,
        initialChildSize: 0.07, // Adjust the initial position as needed
        maxChildSize: 0.95,
        minChildSize: 0,
        expand: true,
        snap: true,
        snapSizes: [
          60 / constraints.maxHeight,
          0.5,
        ],
        controller: controller,
        builder: (BuildContext context, ScrollController scrollController) {
          return DecoratedBox(
            decoration: const BoxDecoration(
              color: Color(0xffECBE5C),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffECBE5C),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                topButtonIndicator(),
                SliverToBoxAdapter(
                  child: widget.child,
                ),
              ],
            ),
          );
        },
      );
    });
  }

  SliverToBoxAdapter topButtonIndicator() {
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Swipe up for alternatives',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: 'HarmoniaSans',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(width: 5), // Add some spacing between the text and the icon
                SizedBox(
                  width: 40, // Adjust the width as needed to make the icon bigger
                  child: Icon(
                    Icons.expand_more,
                    color: Colors.black,
                    size: 30, // Adjust the size as needed to make the icon bigger
                  ),
                ),
              ],
            ),

            SizedBox(height: 3,),
            Container(
              child: Center(
                child: Wrap(
                  children: <Widget>[
                    Container(
                      width: 100,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Colors.black45,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
