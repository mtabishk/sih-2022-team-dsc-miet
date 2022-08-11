import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiran_user_app/app/common_widgets/custom_navigation_drawer.dart';
import 'package:kiran_user_app/app/constants.dart';

const LatLng SOURCE_LOCATION = LatLng(33.7510336, 75.1960689);
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> navigationDrawerKey = GlobalKey();
  Completer<GoogleMapController> _controller = Completer();

  late LatLng currentLocation;
  late LatLng destinationLocation;

  void _setInitialLocation() {
    currentLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);
  }

  @override
  void initState() {
    super.initState();
    // set up initial location
    _setInitialLocation();
  }

  @override
  Widget build(BuildContext context) {
    // final _showOnBoarding =
    //     Provider.of<ShowOnboardingProvider>(context, listen: false);
    CameraPosition initialCameraPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: SOURCE_LOCATION,
    );
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
                      zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      compassEnabled: false,
                      tiltGesturesEnabled: false,
                      mapType: MapType.normal,
                      initialCameraPosition: initialCameraPosition,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
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
              Image.asset("assets/images/wellness-goals.png"),
            ],
          ),
        ),
      ),
    );
  }
}
