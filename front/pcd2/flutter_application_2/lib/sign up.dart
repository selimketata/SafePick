import 'package:flutter/material.dart';
import 'sign in.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFDF6EC), // Set background color
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500, // Medium font weight
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: GestureDetector(
                onTap: () {
                  // Implement image upload logic here
                  // This can open a file picker or camera for image selection
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: Icon(
                    Icons.add_a_photo,
                    size: 50,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(

            child:
            Container(
              width: screenWidth * 0.8, // Adjust width to be bigger
              height: 60, // Adjust height to be bigger
              decoration: BoxDecoration(
                color: Colors.white, // White background
                borderRadius: BorderRadius.circular(30), // Oval shape
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Icon(
                      Icons.person, // Icon for full name
                      // Color of the icon
                    ),
                  ),
                  SizedBox(
                      width: 10), // Add spacing between icon and text field
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText:
                            'Enter your full name', // Label for full name field
                        border: InputBorder.none, // Hide border
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20), // Adjust padding
                      ),
                    ),
                  ),
                ],
              ),
            ),),
            SizedBox(height: 20),
            Center(

            child:Container(
              width: screenWidth * 0.8, // Adjust width to be bigger
              height: 60, // Adjust height to be bigger
              decoration: BoxDecoration(
                color: Colors.white, // White background
                borderRadius: BorderRadius.circular(30), // Oval shape
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Icon(
                      Icons.alternate_email_sharp, // Use your photo asset here
                      // Color of the icon
                    ),
                  ),
                  SizedBox(
                      width: 10), // Add spacing between icon and text field
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter your email',
                        border: InputBorder.none, // Hide border
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20), // Adjust padding
                      ),
                    ),
                  ),
                ],
              ),
            ),),
            SizedBox(height: 20),
           Center(
  child: Container(
    width: screenWidth * 0.8, // Adjust width to be bigger
    height: 60, // Adjust height to be bigger
    decoration: BoxDecoration(
      color: Colors.white, // White background
      borderRadius: BorderRadius.circular(30), // Oval shape
    ),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Icon(
            Icons.lock, // Use your photo asset here
            // Color of the icon
          ),
        ),
        SizedBox(
          width: 10,
        ), // Add spacing between icon and text field
        Expanded(
          child: TextField(
            obscureText: true, // Hide password
            decoration: InputDecoration(
              labelText: 'Enter password',
              border: InputBorder.none, // Hide border
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20), // Adjust padding
            ),
          ),
        ),
      ],
    ),
  ),
),

            SizedBox(height: 20),
            Center(

            child:
            Container(
              width: screenWidth * 0.8, // Adjust width to be bigger
              height: 60, // Adjust height to be bigger
              decoration: BoxDecoration(
                color: Colors.white, // White background
                borderRadius: BorderRadius.circular(30), // Oval shape
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Icon(
                      Icons.lock, // Use your photo asset here
                      // Color of the icon
                    ),
                  ),
                  SizedBox(
                      width: 10), // Add spacing between icon and text field
                  Expanded(
                    child: TextField(
                      obscureText: true, // Hide password
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
                        border: InputBorder.none, // Hide border
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20), // Adjust padding
                      ),
                    ),
                  ),
                ],
              ),
            ),),
            SizedBox(height: 40),
            Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          screenWidth * 0.1), // Adjust horizontal padding
                  child: SizedBox(
                    width: double.infinity, // Full width button
                    height: 60, // Button height
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement login logic here
                        // For demonstration, just pop the current page
                        Navigator.pop(
                            context); // Navigate back to the previous page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF5CB287), // Set button color
                        shape: RoundedRectangleBorder(
                            // Rounded button corners
                            ),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600, // Semi-bold font weight
                          color: Colors.white, // White color
                        ),
                      ),
                    ),
                  ),
                ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black87,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to sign-in page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Signin()), // Replace 'Signin()' with your sign-in page widget
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5CB287),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: screenWidth,
                height: screenWidth / 3.4, // Adjust as needed
                child: Image.asset(
                  'assets/images/bottom-wave.png', // Replace with your photo asset
                  fit: BoxFit.cover, // Ensure the image covers the container
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
