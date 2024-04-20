import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommunityDiscussionPage extends StatefulWidget {
  final String email;
  final String communityName;

  const CommunityDiscussionPage({
    Key? key,
    required this.email,
    required this.communityName,
  }) : super(key: key);

  @override
  _CommunityDiscussionPageState createState() =>
      _CommunityDiscussionPageState();
}

class _CommunityDiscussionPageState extends State<CommunityDiscussionPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _fetchDiscussionHistory(widget.communityName); // Pass the communityName here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return SizedBox(
                  width: 300,
                   // Set a fixed width
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' ${message['timestamp']}',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color.fromARGB(255, 107, 12, 5), // Text color in red
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            message['content'],
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[300], // Text color in red
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildTextComposer(),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _messageController,
                decoration:
                    InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_messageController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      _messageController.clear();
      _sendMessage(text);
    }
  }

  Future<void> _sendMessage(String text) async {
    final url = 'http://192.168.1.67:9000/create_message/';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': widget.email,
        'community_name': widget.communityName,
        'content': text,
      },
    );

    if (response.statusCode == 201) {
      // Message sent successfully
      print("Message sent successfully");
      // Fetch updated discussion history after sending message
      _fetchDiscussionHistory(widget.communityName); // Pass the communityName here
    } else {
      // Error occurred while sending message
      print("Failed to send message");
    }
  }

  Future<void> _fetchDiscussionHistory(String communityName) async {
    final url = 'http://192.168.1.67:9000/get_messages_in_community/';
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"community_name": communityName}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData.containsKey('messages') &&
          responseData['messages'] is Map<String, dynamic>) {
        setState(() {
          _messages = (responseData['messages'][widget.email] ?? [])
              .cast<Map<String, dynamic>>();
        });
      } else {
        print('Invalid response format');
      }
    } else {
      // Handle error
      print('Failed to fetch discussion history');
    }
  }
}
