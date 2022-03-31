import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/sign_in/sign_in_page.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(children: [
        Container(
          height: _height * 0.8,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              )),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(-_width * 0.1, -_width * 1.1),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFC3FDFD).withOpacity(0.8),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(
              _width * 0.6,
              -_width * 0.7,
            ),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFC3FDFD).withOpacity(0.8),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: _height / 9,
          left: _width / 8,
          right: _width / 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: _height * 0.5,
                  width: _height * 0.5,
                  child: Image.asset('assets/icons/onboarding-logo.png')),
              SizedBox(height: 32.0),
              Text(
                "KIRAN",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0ACDCF),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                "An app for screening the possible Mental health issues in adolescents and PwDs.",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 40.0,
          right: 10,
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => SignInPage()),
            ),
            child: Material(
              color: Colors.transparent,
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Color(0xFF0ACDCF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
