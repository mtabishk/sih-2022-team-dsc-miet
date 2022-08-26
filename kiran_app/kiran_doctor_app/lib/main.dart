import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiran_doctor_app/app/constants.dart';
import 'package:kiran_doctor_app/app/landing_page.dart';
import 'package:kiran_doctor_app/services/auth_service.dart';
import 'package:kiran_doctor_app/services/onboarding_provider.dart';
import 'package:kiran_doctor_app/services/invite_code_provider.dart';
import 'package:kiran_doctor_app/services/shared_preferences_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Constants.prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ShowOnboardingProvider>(
            create: (_) => ShowOnboardingProvider()),
        ChangeNotifierProvider<ShowInviteCodeProvider>(
            create: (_) => ShowInviteCodeProvider()),
        Provider<AuthBase>(create: (context) => Auth()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ).copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: kPrimaryColor,
          ),
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kSecondaryColor,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: kPrimaryColor,
          ),
        ),
        home: LandingPage(),
      ),
    );
  }
}
