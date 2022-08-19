import 'package:flutter/material.dart';
import 'package:kiran_doctor_app/app/constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> navigationDrawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final _showOnBoarding =
    //     Provider.of<ShowOnboardingProvider>(context, listen: false);
    return Scaffold(
      key: navigationDrawerKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kSecondaryColor,
        leading: Image.asset("assets/icons/kiran-logo.png"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.asset("assets/icons/chat-logo.png"),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      // drawer: CustomNavigationDrawer(
      //   navigationDrawerKey: navigationDrawerKey,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 300.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey[300],
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFEBEBF4),
                      Color(0xFFF4F4F4),
                      Color(0xFFEBEBF4),
                    ],
                    stops: [
                      0.1,
                      0.3,
                      0.4,
                    ],
                    begin: Alignment(-1.0, -0.3),
                    end: Alignment(1.0, 0.3),
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: Center(child: Text("Your Appointments"))),
          ],
        ),
      ),
    );
  }
}
