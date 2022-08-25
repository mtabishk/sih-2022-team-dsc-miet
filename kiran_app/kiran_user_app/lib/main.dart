import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:kiran_user_app/app/landing_page.dart';
import 'package:kiran_user_app/services/animation_character_provider.dart';
import 'package:kiran_user_app/services/auth_service.dart';
import 'package:kiran_user_app/services/show_onboarding_provider.dart';
import 'package:kiran_user_app/services/user_details_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/shared_preferences_service.dart';

List<CameraDescription>? cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Constants.prefs = await SharedPreferences.getInstance();
  cameras = await availableCameras();
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
        ChangeNotifierProvider<UserDetailsProvider>(
            create: (_) => UserDetailsProvider()),
        ChangeNotifierProvider<AnimationCharacterProvider>(
            create: (_) => AnimationCharacterProvider()),
        Provider<AuthBase>(create: (context) => Auth()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
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
