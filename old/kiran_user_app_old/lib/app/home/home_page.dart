import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiran_user_app/app/common_widgets/custom_navigation_drawer.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> navigationDrawerKey = GlobalKey();
  late GoogleMapController _controller;
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);

  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  Future<void> _getLocationData() async {
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
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(l.latitude!, l.longitude!),
            zoom: 15,
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    // update location
    _getLocationData();
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: _initialcameraposition),
                      mapType: MapType.normal,
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                    ),
                  ),
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
              Image.asset("assets/images/wellness_bar_graph.png"),
            ],
          ),
        ),
      ),
    );
  }
}
