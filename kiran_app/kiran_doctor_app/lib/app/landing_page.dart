import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiran_doctor_app/app/constants.dart';
import 'package:kiran_doctor_app/app/home/home_page.dart';
import 'package:kiran_doctor_app/app/onboarding/introduction_screen.dart';
import 'package:kiran_doctor_app/app/sign_in/registration_number_page.dart';
import 'package:kiran_doctor_app/app/sign_in/sign_in_page.dart';
import 'package:kiran_doctor_app/services/auth_service.dart';
import 'package:kiran_doctor_app/services/firestore_service.dart';
import 'package:kiran_doctor_app/services/onboarding_provider.dart';
import 'package:kiran_doctor_app/services/registration_number_provider.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _showOnBoarding =
        Provider.of<ShowOnboardingProvider>(context, listen: true);
    return _showOnBoarding.questionareCompleted
        ? AuthWrapper()
        : IntroductionScreen();
  }
}

class AuthWrapper extends StatelessWidget {
  AuthWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      //initialData: null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          print("user is ${snapshot.data}");
          final User? user = snapshot.data;
          if (user == null) {
            return SignInPage();
          }
          return Provider<Database>(
            create: (_) => FirestoreDatabase(uid: user.uid),
            child: DatabaseWrapper(),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
            ),
          ),
        );
      },
    );
  }
}

class DatabaseWrapper extends StatelessWidget {
  DatabaseWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _showRegistrationNumber =
        Provider.of<ShowRegistrationNumberProvider>(context, listen: true);
    if (!_showRegistrationNumber.registrationNumberCompleted) {
      return RegistrationNumberPage();
    }
    return HomePage();
  }
}
