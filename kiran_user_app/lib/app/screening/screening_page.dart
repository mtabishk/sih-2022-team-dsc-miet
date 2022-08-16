import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/common_widgets/circle_button.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:kiran_user_app/app/screening/audio_screening_page.dart';
import 'package:kiran_user_app/app/screening/chat_screening_page.dart';
import 'package:kiran_user_app/app/screening/video_screening_page.dart';
import 'package:rive/rive.dart';

class ScreeningPage extends StatelessWidget {
  const ScreeningPage({Key? key, required this.animationCharacter})
      : super(key: key);
  final String animationCharacter;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TODO: show Doctor animation here
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: RiveAnimation.asset(animationCharacter)),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  //TODO: show video or audio or chat widget here
                  Container(
                    height: _width * 0.8,
                    width: _width,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomCircleButtton(
                            color: kPrimaryColor,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoScreeningPage(
                                          animationCharacter:
                                              animationCharacter,
                                        )),
                              );
                            },
                            child: ImageIcon(
                              AssetImage("assets/icons/video-camera.png"),
                              color: Colors.white,
                            ),
                          ),
                          CustomCircleButtton(
                            color: kPrimaryColor,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AudioScreeningPage(
                                          animationCharacter:
                                              animationCharacter,
                                        )),
                              );
                            },
                            child: ImageIcon(
                              AssetImage("assets/icons/mic.png"),
                              color: Colors.white,
                            ),
                          ),
                          CustomCircleButtton(
                            color: kPrimaryColor,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatScreeningPage()),
                              );
                            },
                            child: ImageIcon(
                              AssetImage("assets/icons/chat.png"),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 48),
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 18.0,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        child: AnimatedTextKit(
                          pause: Duration(seconds: 2),
                          repeatForever: true,
                          animatedTexts: [
                            TypewriterAnimatedText(
                                'Choose an option to start the screening'),
                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
