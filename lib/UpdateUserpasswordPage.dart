import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateUserPasswordPage extends StatefulWidget {
  final String email;

  const UpdateUserPasswordPage({super.key, required this.email});

  @override
  _UpdateUserPasswordPageState createState() => _UpdateUserPasswordPageState();
}

class _UpdateUserPasswordPageState extends State<UpdateUserPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;

  void _updatePassword() async {
    if (_passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showDialog('Error', 'All fields are required.');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showDialog('Error', 'Passwords do not match.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://192.168.1.16:9000/update_user_password/');
    try {
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': widget.email,
          'new_password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        _showDialog('Success', 'Password successfully updated.');
      } else {
        _showDialog('Error', 'Failed to update password. Please try again.');
      }
    } catch (e) {
      _showDialog('Error', 'An error occurred: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop(); // Close the dialog
              if (title == 'Success') {
                Navigator.of(context)
                    .pop(); // Return to the previous screen if successful
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm New Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _updatePassword,
                    child: const Text('Update Password'),
                  ),
          ],
        ),
      ),
    );
  }
}
