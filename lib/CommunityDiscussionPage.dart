import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommunityDiscussionPage extends StatefulWidget {
  final String email;
  final String communityName;

  const CommunityDiscussionPage({
    super.key,
    required this.email,
    required this.communityName,
  });

  @override
  _CommunityDiscussionPageState createState() =>
      _CommunityDiscussionPageState();
}

class _CommunityDiscussionPageState extends State<CommunityDiscussionPage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _fetchDiscussionHistory(widget.communityName);
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: 'Search Messages',
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Check if the search text is empty
              if (_searchController.text.isEmpty) {
                _fetchDiscussionHistory(widget
                    .communityName); // Fetch all messages like on initial load
              } else {
                _searchMessages(_searchController
                    .text); // Otherwise, search with the given term
              }
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EC), // Set the background color here
      appBar: AppBar(
        title: Text(
          widget.communityName,
          style: const TextStyle(
            fontWeight: FontWeight.bold, // Makes the text bold
          ),
        ),
        backgroundColor: const Color(0xFFFDF6EC),
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: Color(0xFF5CB287),
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: const Color(0xFF5CB287),
            height: 4.0,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(), // Place the search bar here
          Expanded(
            child: ListView.builder(
              reverse: true, // Display messages in reverse order
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final reversedIndex = _messages.length - 1 - index;
                final message = _messages[reversedIndex];
                final isCurrentUser = message['email'] == widget.email;
                return SizedBox(
                  width: 300,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: isCurrentUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: isCurrentUser
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (!isCurrentUser)
                              FutureBuilder(
                                future: _fetchUserProfile(message['email']),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else {
                                    return CircleAvatar(
                                      backgroundImage: AssetImage(
                                        snapshot.data.toString(),
                                      ),
                                    );
                                  }
                                },
                              ),
                            if (!isCurrentUser) const SizedBox(width: 8.0),
                            Text(
                              '${DateTime.parse(message['timestamp']).toLocal()}',
                              style:
                                  const TextStyle(fontSize: 12.0, color: Colors.grey),
                            ),
                            if (isCurrentUser) const SizedBox(width: 8.0),
                            if (isCurrentUser)
                              FutureBuilder(
                                future: _fetchUserProfile(widget.email),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else {
                                    return CircleAvatar(
                                      backgroundImage: AssetImage(
                                        snapshot.data.toString(),
                                      ),
                                    );
                                  }
                                },
                              ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Padding(
                          padding: EdgeInsets.only(
                              left: isCurrentUser ? 0.0 : 40.0,
                              right: isCurrentUser ? 40.0 : 0.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              message['content'],
                              style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(21, 20, 20, 1)),
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
        decoration: BoxDecoration(
          color: Colors.white, // Set the background color to white
          borderRadius: BorderRadius.circular(20.0), // Adds rounded corners
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(
            bottom: 20.0), // Adds space at the bottom outside the container
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                    hintText: "Send a message",
                    border: InputBorder
                        .none, // Removes default underline on TextField
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0) // Adds padding inside the TextField
                    ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              color: const Color(0xFF5CB287), // Set the icon color to #5CB287
              onPressed: () => _handleSubmitted(_messageController.text),
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
    const url = 'http://192.168.1.16:9000/create_message/';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': widget.email,
        'community_name': widget.communityName,
        'content': text,
      },
    );

    if (response.statusCode == 201) {
      print("Message sent successfully");
      _fetchDiscussionHistory(widget.communityName);
    } else {
      print("Failed to send message");
    }
  }

  Future<String> _fetchUserProfile(String email) async {
    const url = 'http://192.168.1.16:9000/get_user_profile/';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return 'assets/icons/${responseData['photo_name']}';
    } else {
      print('Failed to fetch user profile');
      return 'assets/icons/default_photo.png'; // or default photo path
    }
  }

  Future<void> _fetchDiscussionHistory(String communityName) async {
    const url = 'http://192.168.1.16:9000/get_messages_in_community/';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'community_name': widget.communityName,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData.containsKey('messages') &&
          responseData['messages'] is List<dynamic>) {
        setState(() {
          _messages = List<Map<String, dynamic>>.from(responseData['messages']);
        });
      } else {
        print('Invalid response format');
      }
    } else {
      print('Failed to fetch discussion history');
    }
  }

  Future<void> _searchMessages(String searchTerm) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.16:9000/search_messages_in_community/'),
      body: {
        'community_name': widget.communityName,
        'search_term': searchTerm,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        _messages = List<Map<String, dynamic>>.from(responseData['messages']);
      });
    } else {
      print('Failed to search messages');
    }
  }
}
