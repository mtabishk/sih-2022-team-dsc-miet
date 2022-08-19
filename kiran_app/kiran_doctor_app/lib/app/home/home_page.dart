import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiran_doctor_app/app/chat/chat_page.dart';
import 'package:kiran_doctor_app/app/constants.dart';
import 'package:kiran_doctor_app/models/doctor_location_model.dart';
import 'package:kiran_doctor_app/services/firestore_service.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> navigationDrawerKey = GlobalKey();

  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  Future<void> _getLocationData() async {
    final database = Provider.of<Database>(context, listen: false);
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    await database.updateDoctorLocation(
        data: DoctorLocationModel(
            locationLat: _locationData.latitude.toString(),
            locationLng: _locationData.longitude.toString()));
  }

  @override
  void initState() {
    super.initState();
    // update location
    _getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: navigationDrawerKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kSecondaryColor,
        leading: Image.asset("assets/icons/kiran-logo.png"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ChatPage(),
                      ));
                },
                child: Image.asset("assets/icons/chat-logo.png")),
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
