import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/bottom_navigation_page.dart';
import 'package:kiran_user_app/app/home/home_page.dart';
import 'package:kiran_user_app/app/screening/choose_character_page.dart';
import 'package:kiran_user_app/app/screening/screening_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

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
          top: _height / 2,
          left: _width / 8,
          right: _width / 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: _width * 0.9,
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF0ACDCF),
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ChooseCharacterPage(),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          height: 28.0,
                          width: 28.0,
                          child: Image.asset("assets/icons/google.png")),
                      Text(
                        "Sign in with Google",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Opacity(
                          opacity: 0.0,
                          child:
                              ImageIcon(AssetImage("assets/icons/email.png"))),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              SizedBox(
                width: _width * 0.9,
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF0ACDCF),
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => HomePage(),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ImageIcon(AssetImage("assets/icons/email.png")),
                      Text(
                        "Sign in with Email",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Opacity(
                          opacity: 0.0,
                          child:
                              ImageIcon(AssetImage("assets/icons/email.png"))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
