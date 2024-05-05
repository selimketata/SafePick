import 'package:flutter/material.dart';
import 'second_page.dart';

class SerpentCurve extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double curveHeight;
  final double padding;

  const SerpentCurve({
    super.key,
    required this.color,
    required this.strokeWidth,
    required this.curveHeight,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, curveHeight),
      painter: SerpentPainter(
        color: color,
        strokeWidth: strokeWidth,
        curveHeight: curveHeight,
        padding: padding,
      ),
    );
  }
}

class SerpentPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double curveHeight;
  final double padding;

  SerpentPainter({
    required this.color,
    required this.strokeWidth,
    required this.curveHeight,
    required this.padding,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    final Path path = Path()
      ..moveTo(padding, centerY)
      ..quadraticBezierTo(
          centerX / 1.5, centerY + curveHeight / 1.5, centerX, centerY)
      ..quadraticBezierTo(centerX * 1.5, centerY - curveHeight / 1.5,
          size.width - padding, centerY);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class HomePage extends StatelessWidget {
   final String email;

  const HomePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFFDF6EC), // Set background color for the whole screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 150),
            const Text(
              'SafePick',
              style: TextStyle(
                fontSize: 54,
                fontFamily: 'Harmonia',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 90), // Add space between title and image
            Image.asset(
              'assets/images/logo.png', // Replace 'your_image.png' with your image file path
              width: 230, // Set width of the image
              height: 230, // Set height of the image
              fit: BoxFit.cover, // Adjust how the image fits into the container
            ),
            const SizedBox(height: 50), // Add space between logo and button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage( email: email),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFFECBE5C)), // Set the background color here
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(
                      horizontal: 50.0,
                      vertical: 13.0), // Adjust the padding as needed
                ),
              ),
              child: const Text(
                'Start Now  \u2192',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Harmonia',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'DECODE THE BLEND',
              style: TextStyle(
                fontSize: 23,
                fontFamily: 'Harmonia',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 1),
            const Text(
              'Where Consumption Meets Evaluation',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Harmonia',
              ),
            ),
            const SizedBox(height: 10), // Add some space before the Divider
            const SerpentCurve(
              color: Color(0xFFECBE5C), // Set the color of the serpent curve
              strokeWidth: 2.5, // Set the thickness of the serpent curve
              curveHeight: 50,
              padding: 30, // Set the height of the curve
            ),
          ],
        ),
      ),

      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            top: 140,
            left: 50,
            child: _buildCircle(const Color(0xFFECBE5C), 40),
          ),
          Positioned(
            top: 50,
            right: 10,
            child: _buildCircle(const Color(0xFFECBE5C), 100),
          ),
          Positioned(
            top: 250,
            right: 230,
            child: _buildCircle(const Color(0xFFECBE5C), 15),
          ),
          Positioned(
            top: 250,
            left: 60,
            child: _buildCircle(const Color(0xFF5CB287), 70),
          ),
          Positioned(
            top: 240,
            right: 50,
            child: _buildCircle(const Color(0xFF5CB287), 30),
          ),
          Positioned(
            top: 130,
            right: 150,
            child: _buildCircle(const Color(0xFF5CB287), 15),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
