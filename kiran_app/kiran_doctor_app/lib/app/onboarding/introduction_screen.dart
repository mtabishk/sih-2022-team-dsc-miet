import 'package:flutter/material.dart';
import 'package:kiran_doctor_app/app/constants.dart';
import 'package:kiran_doctor_app/services/onboarding_provider.dart';
import 'package:provider/provider.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    final _showOnBoarding =
        Provider.of<ShowOnboardingProvider>(context, listen: false);

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
              color: kPrimaryColor.withOpacity(0.8),
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
              color: kPrimaryColor.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          left: _width / 2 - _width * 0.15,
          child: Image.asset(
            'assets/icons/NPIC-logo.png',
            height: _height * 0.3,
            width: _width * 0.3,
          ),
        ),
        Positioned(
          top: _height / 6,
          left: _width / 8,
          right: _width / 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: _height * 0.5,
                  width: _height * 0.5,
                  child: Image.asset('assets/icons/onboarding-logo.png')),
              Text(
                "Kiran Doctor App for helping people with Mental health issues in adolescents and PwDs.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 40.0,
          right: 10,
          child: InkWell(
            onTap: () {
              _showOnBoarding.changeQuestionareCompletedValue();
            },
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
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "Version 1.0.0",
            style: TextStyle(color: Colors.white60),
          ),
        ),
      ]),
    );
  }
}
