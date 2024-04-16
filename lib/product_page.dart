import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_application_2/Details1.dart';
import 'package:flutter_application_2/Details2.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductPage extends StatelessWidget {
  final int productId;
  final apiService = ApiService();

  ProductPage({required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDF6EC),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(47), // Adjust the preferred height as needed
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

      body:Padding(
        padding: const EdgeInsets.only(top:0.0,left:16.0,right:16.0,bottom: 16.0),
        child :SingleChildScrollView(
        child:Center(
          child: FutureBuilder<ProductF>(
            future: apiService.fetchProduct(productId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.hasData) {
                final product = snapshot.data!;
                final image = snapshot.data!.backgroundRemovedImage;
                Uint8List byte = base64Decode(image!);
                final nutrientMap = snapshot.data!.nutrientMap;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                    children :[Padding(
                      padding: EdgeInsets.only(left: 30,top:50), // Adjust the right padding as needed
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffECBE5C), // Change color as needed
                        ),
                      ),
                    ),
                  Padding(
                   padding: EdgeInsets.only(left: 270,top:50),
                    child : Container(
                      width: 17,
                      height: 17,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffECBE5C), // Change color as needed
                      ),
                    ),
                    ),
                    ],
                    ),

                    // SizedBox(height: 20),

                    Center(
                    child: Text(
                      product.productName ?? 'No Name',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'SF Pro Text',
                      ),
                    ), ),
              Padding(
              padding: EdgeInsets.only(left: 250,top:5),
                    child :Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff5CB287), // Change color as needed
                      ),
                    ),),
                    SizedBox(height: 8),
                     Center(
                    child :Container(
                      height: 240,
                      width: 240,
                      child: CircularPercentIndicator(
                        animation: true,
                        animationDuration: 1000,
                        radius: 120,
                        lineWidth: 20,
                        percent: (product.nutriscoreScoreOutOf100 ?? 0).toDouble() / 100,
                        center: Image.memory(
                          byte,  // Assuming 'byte' is a Uint8List
                          height: 160,
                          width: 160,
                        ),
                        backgroundColor: Color(0xffD70404),
                        progressColor: Color(0xff5CB287),
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                    )),
                    SizedBox(height: 10,), // Add some space between the circular indicator and the percentage
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${product.nutriscoreScoreOutOf100 ?? 0}%', // Display the percentage
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
                              image: AssetImage('assets/images/approuver.png'), // Replace 'assets/small_image.png' with your image path
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
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
                    // for (int i = 0; i < 20; i++)
                    //   Text('Scrolling Test Text ${i + 1}', style: TextStyle(fontSize: 22)),
                    SizedBox(height :10,),
                    Column(
                    children: [ Container(
                    padding: EdgeInsets.all(5),
                     decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffD9D9D9).withOpacity(0.5),

                     ),
                    child: Row(
                    children:[
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
                             'Value: ${product.energyKcal100g}',
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
                    // Add more widgets as needed
                  ],
                    ),
                    ).animate().fade(duration: 550.ms).slideY(),
              ],
              ),
                    SizedBox(height: 10), // Add space between the containers

                    // Second Container (Copy and paste the first Container code here)
                    Container(
                      padding: EdgeInsets.all(5),
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
                                      'Value: ${product.fiber100g}',
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
                    SizedBox(height: 10),

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
              'Other nutrients',
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
              children: nutrientMap.entries.map((entry) => buildInfoRow(entry.key, entry.value)).toList(),

              ).animate().fade(duration: 550.ms).slideY(),
              ),







              ],



                );
              } else {
                return Text("No product data available");
              }
            },
          ),
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
