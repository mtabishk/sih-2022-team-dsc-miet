import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiran_doctor_app/app/chat/chat_page.dart';
import 'package:kiran_doctor_app/app/common/custom_alert_dialog.dart';
import 'package:kiran_doctor_app/app/common/custom_exception_alert_dialog.dart';
import 'package:kiran_doctor_app/app/constants.dart';
import 'package:kiran_doctor_app/models/doctor_location_model.dart';
import 'package:kiran_doctor_app/services/auth_service.dart';
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

  bool _isOnline = false;

  @override
  void initState() {
    super.initState();
    // update location
    _getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
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
                child: SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: Image.asset("assets/icons/chat-logo.png"))),
          ),
          SizedBox(width: 10.0),
          IconButton(
              onPressed: () async {
                await _confirmSignOut();
              },
              icon: Icon(Icons.logout)),
          SizedBox(width: 10.0),
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      // drawer: CustomNavigationDrawer(
      //   navigationDrawerKey: navigationDrawerKey,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Opacity(
                  opacity: _isOnline ? 0.0 : 1.0,
                  child: Text(
                    "OFFLINE",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Switch(
                    value: _isOnline,
                    onChanged: (value) async {
                      await database.updateDoctorOnlineStatus(isOnline: value);
                      setState(() {
                        _isOnline = value;
                      });
                    }),
                Opacity(
                  opacity: _isOnline ? 1.0 : 0.0,
                  child: Text(
                    "ONLINE",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.0),
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
          ],
        ),
      ),
    );
  }

  Future<void> _confirmSignOut() async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      final didRequestSignOut = await showAlertDialog(
        context,
        title: 'Logout',
        content: 'Are you sure that you want to logout?',
        defaultActionText: 'Cancel',
        cancelActionText: 'Confirm',
      );

      if (didRequestSignOut == true) {
        // cancel the ride here
        await auth.signOut();
      }
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: e.message.toString(), exception: e);
    } catch (e) {
      print(e.toString());
    }
  }
}
