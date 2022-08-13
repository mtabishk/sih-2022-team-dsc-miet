import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/home/home_page.dart';
import 'package:kiran_user_app/app/onboarding/introduction_screen.dart';
import 'package:kiran_user_app/services/show_onboarding_provider.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _showOnBoarding =
        Provider.of<ShowOnboardingProvider>(context, listen: true);
    print(_showOnBoarding.questionareCompleted);
    return _showOnBoarding.questionareCompleted
        ? HomePage()
        : IntroductionScreen();
  }
}
