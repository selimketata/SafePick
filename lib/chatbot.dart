import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Chatbot extends StatefulWidget {
  const Chatbot({Key? key}) : super(key: key);

  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        messages.add({
          "type": "bot",
          "message": "Hi, I'm Bebo! I can help you choose the products you want. Type 'exit' to end."
        });
      });
    });
  }

Future<void> sendQuery(String query) async {
  var url = 'http://192.168.1.15:5000/query';
  var response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'query': query}),
  );

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    String responseMessage = formatResponseMessage(responseBody); // Format the message
    setState(() {
      messages.add({"type": "user", "message": query});
      messages.add({"type": "bot", "message": responseMessage});
    });
  } else {
    setState(() {
      messages.add({"type": "user", "message": query});
      messages.add({"type": "bot", "message": "Error occurred while sending query"});
    });
  }

  _messageController.clear();
  _scrollController.animateTo(
    _scrollController.position.maxScrollExtent,
    duration: const Duration(milliseconds: 200),
    curve: Curves.easeOut,
  );
}

String formatResponseMessage(Map<String, dynamic> data) {
  String productName = data['product_name'] ?? "this product";
  String proteinContent = data['proteins_100g'] != null ? "${data['proteins_100g']}g of protein" : "an unknown amount of protein";
  String fatsContent = data['fat_100g'] != null ? "${data['fat_100g']}g of fat" : "an unknown amount of fat";
  String carbsContent = data['carbohydrates_100g'] != null ? "${data['carbohydrates_100g']}g of carbohydrates" : "an unknown amount of carbohydrates";
  List<String> additionalInfo = [];

  // Checking for other interesting nutrients
  if (data['vitamin_c_100g'] != null && data['vitamin_c_100g'] != 'Unknown') {
    additionalInfo.add("rich in Vitamin C");
  }
  if (data['fiber_100g'] != null && data['fiber_100g'] != 'Unknown') {
    additionalInfo.add("high in fiber");
  }

  // Join additional info to make a readable sentence part if not empty
  String additionalInfoText = additionalInfo.isNotEmpty ? ", " + additionalInfo.join(", ") : "";

  return "What about trying $productName? It contains $proteinContent, $fatsContent, $carbsContent$additionalInfoText.";
}







@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFFDF6EC),
    appBar: AppBar(
      title: const Text("Bebo"),
      backgroundColor: const Color(0xFFFDF6EC),
      leading: IconButton(
        icon: const CircleAvatar(
          backgroundColor: Color(0xFF5CB287),
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10), // Adds some padding around the image
          child: Image.asset('assets/images/chtt.png', width: 40), // Specifies the image path and width
        ),
      ],
      elevation: 0, // Remove shadow to make line look cleaner
    ),
    body: Column(
      children: [
        Container(
          height: 4.0,
          color: Color(0xFF5CB287),
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: messages.length + 1, // Add one for the image
            itemBuilder: (context, index) {
              if (index == 0) {
                // Render the image at the first index
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/robo.png', width: 200), // Adjusted width
                  ),
                );
              }
              // Subtract 1 from index because the first item is the image
              return buildMessageBubble(messages[index - 1]);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: "Enter your question",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        sendQuery(value);
                      }
                    },
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Color(0xFF5CB287)),
                onPressed: () {
                  if (_messageController.text.isNotEmpty) {
                    sendQuery(_messageController.text);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}



  Widget buildMessageBubble(Map<String, dynamic> message) {
    bool isUserMessage = message['type'] == 'user';
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: isUserMessage ? Color(0xFFECBE5C) : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message['message'],
          style: TextStyle(
            fontSize: 16,
            color: isUserMessage ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
