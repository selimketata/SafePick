import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_2/models/productC.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../services/api_service_C.dart';
import 'Details3.dart';

class ProductPageC extends StatelessWidget {
  final int productId;
  final apiService = ApiService();

  ProductPageC({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFDF6EC),
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(47), // Adjust the preferred height as needed
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Container(
            width: 47,
            height: 47,
            decoration: const BoxDecoration(
              color: Color(0xFFECBE5C),
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          actions: [
            Container(
              width: 47,
              height: 47,
              decoration: const BoxDecoration(
                color: Color(0xFFECBE5C),
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.white),
                onPressed: () {
                  // Add your favorite functionality here
                },
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 0.0, left: 16.0, right: 16.0, bottom: 16.0),
            child: SingleChildScrollView(
              child: Center(
                child: FutureBuilder<ProductC>(
                  future: apiService.fetchProduct(productId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Color(0xffECBE5C),
                      ));
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      final product = snapshot.data!;
                      final image = snapshot.data!.backgroundRemovedImage;
                      Uint8List byte = base64Decode(image!);
                      final ingredientsadditives =
                          snapshot.data!.ingredientsadditives;
                      final problematic = snapshot.data!.problematic;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              // Row containing circles
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30, top: 20),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffECBE5C),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0, top: 0),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff5CB287),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 190,
                                        top: 40), // Adjusted for simplicity
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffECBE5C),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Positioned Text in the center with wrapping
                              Positioned.fill(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            50), // Increase padding to ensure text does not overlap with the circles too much
                                    child: Text(
                                      product.productName ?? 'No Name',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Harmonia Sans W01 Regular',
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow
                                          .fade, // Handles text overflow gracefully
                                    ),
                                  ),
                                ),
                              ),
                              // Additional circle in the row
                            ],
                          ),

                          const SizedBox(height: 8),
                          Center(
                              child: SizedBox(
                            height: 240,
                            width: 240,
                            child: CircularPercentIndicator(
                              animation: true,
                              animationDuration: 1000,
                              radius: 120,
                              lineWidth: 20,
                              percent: (product.score ?? 0).toDouble() / 100,
                              center: Image.memory(
                                byte, // Assuming 'byte' is a Uint8List
                                height: 160,
                                width: 160,
                              ),
                              backgroundColor: const Color(0xffD70404),
                              progressColor: const Color(0xff5CB287),
                              circularStrokeCap: CircularStrokeCap.round,
                            ),
                          )),
                          const SizedBox(
                            height: 10,
                          ), // Add some space between the circular indicator and the percentage
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${product.score ?? 0}%', // Display the percentage
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      10), // Add some space between the percentage and the image
                              Container(
                                width: 38,
                                height: 38,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'images/approuver.png'), // Replace 'assets/small_image.png' with your image path
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 'Ingredients' text on the left
                              const Text(
                                'Ingredients:',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'SF Pro Text',
                                ),
                              ),
                              const Spacer(),
                              // Add space between 'Ingredients' and 'Details'
                              // Container for 'Details' on the right
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 30, // Adjust height as needed
                                  width: 100, // Adjust width as needed
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(
                                          0xffECBE5C), // Specify border color
                                      width: 3, // Adjust border width as needed
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        15), // Add border radius for rounded corners
                                  ),

                                  child: const Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              2), // Adjust padding as needed
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
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xffD9D9D9).withOpacity(0.5),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 6),
                                          child: Text(
                                            'Ingredients from palm oil',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontFamily: 'SF Pro Text',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 6),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 7,
                                                height: 7,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(
                                                      0xffF1755B), // Adjust color as needed
                                                ),
                                              ),
                                              const SizedBox(
                                                  width:
                                                      4), // Adjust spacing as needed
                                              Text(
                                                'Value: ${product.ingredientsFromPalmOilN}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const Details3(); // Show ProductDetailsDialog as a dialog
                                            },
                                          );
                                        },
                                        child: const Icon(Icons.info,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ], // Closing parenthesis for Row widget
                                ), // Closing parenthesis for Container widget
                              ), // Closing parenthesis for Container widget
                            ], // Closing parenthesis for Column widget
                          )
                              .animate()
                              .fade(duration: 550.ms)
                              .slideY(), // Closing parenthesis for Column widget

                          //         Spacer(),
                          //
                          //         Padding(
                          //           padding: EdgeInsets.all(15),
                          //           child: GestureDetector(
                          //             onTap: () {
                          //               showDialog(
                          //                 context: context,
                          //                 builder: (BuildContext context) {
                          //                   return Details1() ; // Show ProductDetailsDialog as a dialog
                          //                 },
                          //               );
                          //             },
                          //             child: Icon(Icons.info, color: Colors.grey),
                          //           ),
                          //         ),
                          //         // Add more widgets as needed
                          //       ],
                          //     ),
                          //   ).animate().fade(duration: 550.ms).slideY(),
                          //   ],
                          // ),
                          // SizedBox(height: 10), // Add space between the containers
                          //
                          // // Second Container (Copy and paste the first Container code here)
                          // Container(
                          //   padding: EdgeInsets.all(5),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(20),
                          //     color: Color(0xffD9D9D9).withOpacity(0.5),
                          //   ),
                          //   child: Row(
                          //     children: <Widget>[
                          //       Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: <Widget>[
                          //           Padding(
                          //             padding: EdgeInsets.only(left: 6),
                          //             child: Text(
                          //               'Fibers',
                          //               style: TextStyle(
                          //                 fontSize: 16,
                          //                 fontWeight: FontWeight.bold,
                          //                 color: Colors.black,
                          //                 fontFamily: 'SF Pro Text',
                          //
                          //               ),
                          //             ),
                          //           ),
                          //           Padding(
                          //             padding: EdgeInsets.only(left: 6),
                          //             child: Row(
                          //               children: [
                          //                 Container(
                          //                   width: 7,
                          //                   height: 7,
                          //                   decoration: BoxDecoration(
                          //                     shape: BoxShape.circle,
                          //                     color: Color(0xff5CB287), // Adjust color as needed
                          //                   ),
                          //                 ),
                          //                 SizedBox(width: 4), // Adjust spacing as needed
                          //                 Text(
                          //                   'Value: ${product.fiber100g}',
                          //                   style: TextStyle(
                          //                     fontSize: 14,
                          //                     color: Colors.black87,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //       Spacer(),
                          //       Padding(
                          //         padding: EdgeInsets.all(15),
                          //         child: GestureDetector(
                          //           onTap: () {
                          //             showDialog(
                          //               context: context,
                          //               builder: (BuildContext context) {
                          //                 return Details2() ; // Show ProductDetailsDialog as a dialog
                          //               },
                          //             );
                          //           },
                          //           child: Icon(Icons.info, color: Colors.grey),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ).animate().fade(duration: 550.ms).slideY(),
                          const SizedBox(height: 10),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: ExpansionTile(
                              tilePadding: const EdgeInsets.only(left: 10, right: 17),
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              collapsedTextColor: Colors.black,
                              collapsedBackgroundColor:
                                  const Color(0xffD9D9D9).withOpacity(0.5),
                              backgroundColor:
                                  const Color(0xffD9D9D9).withOpacity(0.5),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 7,
                                        height: 7,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(
                                              0xffF1755B), // Adjust color as needed
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        'Problemetic Ingredients',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: 'SF Pro Text',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              children: problematic.entries
                                  .map((entry) =>
                                      buildInfoRow(entry.key, entry.value))
                                  .toList(),
                            ).animate().fade(duration: 550.ms).slideY(),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 80.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: ExpansionTile(
                                tilePadding:
                                    const EdgeInsets.only(left: 10, right: 17),
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                collapsedTextColor: Colors.black,
                                collapsedBackgroundColor:
                                    const Color(0xffD9D9D9).withOpacity(0.5),
                                backgroundColor:
                                    const Color(0xffD9D9D9).withOpacity(0.5),
                                title: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Other Ingredients',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: 'SF Pro Text',
                                      ),
                                    ),
                                    Text(
                                      'Additives and more..',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                children: ingredientsadditives.entries
                                    .map((entry) =>
                                        buildInfoRow(entry.key, entry.value))
                                    .toList(),
                              ).animate().fade(duration: 550.ms).slideY(),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Text("No product data available");
                    }
                  },
                ),
              ),
            ),
          ),
          const MyDraggableSheet(
              child: Alternative()), // Ajouter ici le widget Alternative
        ],
      ),
    );
  }
}

Widget buildInfoRow(String title, dynamic value) {
  // Check if value is null or an empty list
  if (value == null || (value is List && value.isEmpty)) {
    return const SizedBox(); // Return an empty SizedBox if value is null or an empty list
  }

  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'SF Pro Text',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Aligns children to the start of the column
              children: [
                SizedBox(
                  width:
                      200, // Specify an appropriate width based on your layout needs
                  child: Text(
                    '$value',
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
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

class Alternative extends StatelessWidget {
  const Alternative({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<Map<String, dynamic>> products = snapshot.data!;
          if (products.isEmpty) {
            return const Center(child: Text('No products found'));
          }
          return Center(
            child: Column(
              children: [
                for (var product in products)
                  BottomSheetDummyUI(
                    content: product['product_name'],
                    img: product['background_removed_image'],
                    score: product['score'], // Add the 'score' parameter here
                  ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.1.16:9000/alternatives/cosmetics//'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['Alternatives'];
        return data
            .map<Map<String, dynamic>>((jsonString) => jsonDecode(jsonString))
            .toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to load data');
    }
  }
}

class BottomSheetDummyUI extends StatelessWidget {
  final String content;
  final String img;
  final int? score;

  const BottomSheetDummyUI({
    required this.content,
    required this.img,
    required this.score, // Add the 'score' parameter here
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: img.isNotEmpty
                    ? Image.memory(
                        base64Decode(img),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Container(), // Display an empty container if image data is empty
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      content,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 15), // Vertical space after content text
                    Row(
                      children: [
                        const SizedBox(
                            width:
                                20), // Horizontal space before score and icon row
                        const Icon(Icons.check,
                            color: Colors.green), // Green check icon
                        const SizedBox(
                            width:
                                5), // Horizontal space between icon and score
                        Text(
                          score
                              .toString(), // Convert score to string before displaying
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                            width:
                                10), // Horizontal space between score and next item
                        // Add here other items next to the score if needed
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyDraggableSheet extends StatefulWidget {
  final Widget child;
  const MyDraggableSheet({super.key, required this.child});

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
        initialChildSize: 0.1,
        maxChildSize: 0.8,
        minChildSize: 0,
        expand: true,
        snap: true,
        snapSizes: [
          60 / constraints.maxHeight,
          0.2,
        ],
        controller: controller,
        builder: (BuildContext context, ScrollController scrollController) {
          return DecoratedBox(
            decoration: const BoxDecoration(
              color: Color(0xFFECBE5C),
              boxShadow: [
                BoxShadow(
                  color: Colors.yellow,
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
            Container(
                child: Center(
                    child: Wrap(children: <Widget>[
              Container(
                  width: 100,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  )),
            ]))),
          ])),
    );
  }
}
