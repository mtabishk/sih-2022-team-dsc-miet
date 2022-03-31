import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/common_widgets/custom_navigation_drawer.dart';
import 'package:kiran_user_app/app/constants.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> navigationDrawerKey =
      GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    // final _showOnBoarding =
    //     Provider.of<ShowOnboardingProvider>(context, listen: false);
    return Scaffold(
      key: navigationDrawerKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kSecondaryColor,
        actions: [
          Image.asset("assets/icons/kiran-logo.png"),
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: CustomNavigationDrawer(
        navigationDrawerKey: navigationDrawerKey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  "assets/icons/map.png",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 32),
              Text(
                "Your appoitments",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: kPrimaryColor,
                child: ListTile(
                  isThreeLine: true,
                  leading: Image.asset("assets/images/dr-strange.png"),
                  title: Text("Dr Strange"),
                  subtitle: Text("10:00 AM"),
                ),
              ),
              SizedBox(height: 32),
              Text(
                "Wellness Goals progress",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Image.asset("assets/images/wellness-goals.png"),
            ],
          ),
        ),
      ),
    );
  }
}
