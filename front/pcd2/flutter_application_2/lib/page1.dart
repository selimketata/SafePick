import 'package:flutter/material.dart';
import 'sign in.dart';

const TextStyle goldcoinGreyStyle = TextStyle(
  color: Colors.black,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  fontFamily: "SF Pro Text",
);

const TextStyle goldCoinWhiteStyle = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  fontFamily: "SF Pro Text",
);

const TextStyle greyStyle = TextStyle(
  fontSize: 44.0,
  color: Colors.black,
  fontFamily: "Product Sans",
);

const TextStyle whiteStyle = TextStyle(
  fontSize: 45.0,
  color: Colors.white,
  fontFamily: "SF Pro Text",
  letterSpacing: 2.5,
);
const TextStyle boldStylee = TextStyle(
  fontSize: 55.0,
  color: Colors.black,
  fontFamily: "SF Pro Text",
  fontWeight: FontWeight.bold,
);

const TextStyle boldStyle = TextStyle(
  fontSize: 55.0,
  color: Color(0xFFECBE5C),
  fontFamily: "SF Pro Text",
  fontWeight: FontWeight.bold,
);
const TextStyle boldStyleE = TextStyle(
  fontSize: 50.0,
  color: Color(0xFF5CB287),
  fontFamily: "SF Pro Text",
  fontWeight: FontWeight.bold,
);

const TextStyle descriptionGreyStyle = TextStyle(
  color: Colors.black,
  fontSize: 20.0,
  fontFamily: "Product Sans",
);

const TextStyle descriptionWhiteStyle = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
  fontFamily: "Product Sans",
);

class Rectangle extends StatelessWidget {
  final bool active;

  const Rectangle({Key? key, required this.active}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.0, 
      height: 20.0, 
      margin: EdgeInsets.only(
          bottom: 40.0, left: 10.0, right: 10), 
      decoration: BoxDecoration(
        color: active
            ? Color(0xFF5CB287)
            : Colors.white, 
        borderRadius: BorderRadius.circular(2.0),
        border:
            Border.all(color: Colors.black), 
      ),
    );
  }
}

class Rectangletwo extends StatelessWidget {
  final bool active;

  const Rectangletwo({Key? key, required this.active}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.0, 
      height: 20.0, 
      margin: EdgeInsets.only(
          bottom: 40.0, left: 10.0, right: 10), 
      decoration: BoxDecoration(
        color: active
            ? Color(0xFF5CB287)
            : Colors.white, 
        borderRadius: BorderRadius.circular(2.0),
        border:
            Border.all(color: Colors.black), 
      ),
    );
  }
}

class Rectanglethree extends StatelessWidget {
  final bool active;

  const Rectanglethree({Key? key, required this.active}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.0,
      height: 20.0, 
      margin: EdgeInsets.only(
          bottom: 40.0, left: 10.0, right: 10), 
      decoration: BoxDecoration(
        color: active
            ? Color.fromRGBO(238, 166, 66, 1)
            : Colors.white, 
        borderRadius: BorderRadius.circular(2.0),
        border:
            Border.all(color: Colors.black), 
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFDF6EC),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "SAFEPICK",
                  style: goldcoinGreyStyle,
                ),
                TextButton(
                  onPressed: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  child: Text(
                    "Skip",
                    style: goldcoinGreyStyle,
                  ),
                ),
              ],
            ),
          ),
          Image.asset("assets/images/logo.png"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "SCAN",
                  style: greyStyle,
                ),
                Text(
                  "PRODUCTS",
                  style: boldStylee,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Decode the blend: where composition\n"
                  "meets evaluation.",
                  style: descriptionGreyStyle,
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 20.0), 
              Rectangle(active: true),
              SizedBox(width: 6.0), 
              Rectangle(active: false),
              SizedBox(width: 6.0), 
              Rectangle(active: false),
            ],
          )
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF5CB287),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "SAFEPICK",
                  style: goldCoinWhiteStyle,
                ),
                TextButton(
                  onPressed: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  child: Text(
                    "Skip",
                    style: goldcoinGreyStyle,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 230, 
              height: 300, 
              child: Image.asset("assets/images/img_image_1.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 30.0, top: 10), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "PRODUCT",
                  style: whiteStyle,
                ),
                Text(
                  "EVALUATION",
                  style: boldStyle,
                ),
                SizedBox(
                  height: 10.0, 
                ),
                Text(
                  "Insightful rating based on the quality\n"
                  "of ingredients, empowering users to\n"
                  "make informed and healthier choices.",
                  style: descriptionWhiteStyle,
                ),
              ],
            ),
          ),
          SizedBox(
              height:
                  5.0), 
          Row(
            children: <Widget>[
              SizedBox(width: 20.0), 
              Rectangletwo(active: false),
              SizedBox(width: 6.0), 
              Rectangletwo(active: true),
              SizedBox(width: 6.0), 
              Rectangletwo(active: false),
            ],
          ),
        ],
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFECBE5C),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "SAFEPICK",
                  style: goldCoinWhiteStyle,
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to page2
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  child: Text(
                    "Skip",
                    style: goldcoinGreyStyle,
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 120),
                  child: Image.asset(
                    "assets/images/img_image_2.png",
                    height: 120,
                    width: 120,
                    alignment: Alignment.topRight,
                  ),
                ),
                SizedBox(
                  width: 0,
                ),
                SizedBox(
                  width: 95,
                  height: 190,
                  child: Image.asset(
                    "assets/images/img_image_4.png",
                    height: 30,
                    width: 30,
                    alignment: Alignment.topLeft,
                  ),
                ),
                SizedBox(
                  width: 0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0, top: 120),
                  child: Image.asset(
                    "assets/images/img_image_3.png",
                    height: 120,
                    width: 120,
                    alignment: Alignment.topLeft,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "BETTER",
                    style: whiteStyle,
                  ),
                  Text(
                    "ALTERNATIVE",
                    style: boldStyleE,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Transforming choices with personalized recommendations for healthier living.",
                    style: descriptionWhiteStyle,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              Rectanglethree(active: false),
              SizedBox(width: 6.0),
              Rectanglethree(active: false),
              SizedBox(width: 6.0),
              Rectanglethree(active: true),
            ],
          ),
        ],
      ),
    );
  }
}
