import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiran_user_app/app/common_widgets/custom_alert_dialog.dart';
import 'package:kiran_user_app/app/common_widgets/custom_exception_alert_dialog.dart';
import 'package:kiran_user_app/app/common_widgets/custom_navigation_drawer.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:kiran_user_app/models/user_location_model.dart';
import 'package:kiran_user_app/services/firestore_service.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

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
    await database.updateUsersLocation(
        data: UserLocationModel(
            locationLat: _locationData.latitude.toString(),
            locationLng: _locationData.longitude.toString()));
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

  Set<Marker> _markers = Set<Marker>();

  void _addMarkersToMap() async {
    final BitmapDescriptor doctorIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0, size: Size(100, 100)),
        'assets/icons/doctor-pin.png');
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(1234.toString()),
        position: LatLng(10.8273946, 77.0600763),
        infoWindow: InfoWindow(
          title: 'Test Doctor 1 ',
          snippet: 'Psychologist',
        ),
        icon: doctorIcon, //Icon for Marker
      ));
      _markers.add(Marker(
        markerId: MarkerId(1235.toString()),
        position: LatLng(10.828361, 77.066119),
        infoWindow: InfoWindow(
          title: 'Test Doctor 2 ',
          snippet: 'Psychologist',
        ),
        icon: doctorIcon, //Icon for Marker
      ));
      _markers.add(Marker(
        markerId: MarkerId(1236.toString()),
        position: LatLng(10.828994, 77.060626),
        infoWindow: InfoWindow(
          title: 'Test Doctor 3 ',
          snippet: 'Speech Therapist',
        ),
        icon: doctorIcon, //Icon for Marker
      ));
      _markers.add(Marker(
        markerId: MarkerId(1237.toString()),
        position: LatLng(10.828087, 77.056206),
        infoWindow: InfoWindow(
          title: 'Test Doctor 4 ',
          snippet: 'Physician',
        ),
        icon: doctorIcon, //Icon for Marker
      ));
      _markers.add(Marker(
        markerId: MarkerId(1238.toString()),
        position: LatLng(10.832387, 77.071977),
        infoWindow: InfoWindow(
          title: 'Test Doctor 5 ',
          snippet: 'Physician',
        ),
        icon: doctorIcon, //Icon for Marker
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    // update location
    this._getLocationData();
    // add markers to map
    this._addMarkersToMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: navigationDrawerKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kSecondaryColor,
        actions: [
          IconButton(
            onPressed: () async {
              const number = '18005990019';
              await FlutterPhoneDirectCaller.callNumber(number);
            },
            icon: Icon(Icons.phone, size: 36.0),
          ),
          SizedBox(height: 10.0),
          Image.asset("assets/icons/kiran-logo.png"),
          SizedBox(height: 10.0),
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: CustomNavigationDrawer(
        navigationDrawerKey: navigationDrawerKey,
        database: Provider.of<Database>(context, listen: false),
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
                      markers: _markers,
                      myLocationEnabled: true,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
              Text(
                "Upcomming appointment",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('appointments')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done ||
                        snapshot.connectionState == ConnectionState.active) {
                      int length = snapshot.data!.docs.length;
                      if (length == 0) {
                        return Center(
                          child: Text(
                            "No upcoming appointments",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        );
                      } else {
                        final doc = snapshot.data!.docs.first;
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: kPrimaryColor,
                          child: ListTile(
                            isThreeLine: true,
                            leading: Image.asset("assets/images/doctor.png"),
                            title: Text('Dhavni Gupta'),
                            subtitle: Text('Mental Health'),
                          ),
                        );
                      }
                    }

                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: kPrimaryColor,
                      ),
                    );
                  }),
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
