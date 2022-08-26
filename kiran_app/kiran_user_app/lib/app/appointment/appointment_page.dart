import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:kiran_user_app/services/firestore_service.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({
    Key? key,
    required this.database,
  }) : super(key: key);
  final Database database;

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Appointments")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Text("Available Doctors",
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 20),
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

  Future showAppointmentDialog(
    BuildContext context, {
    required String title,
    required String content,
    required String doctorUid,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10.0),
            SizedBox(
                height: 100.0, child: Image.asset("assets/images/doctor.png")),
            SizedBox(height: 20.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(content),
          ],
        ),
        actions: [
          TextButton(
            child: Text("Cancel", style: TextStyle(color: Colors.black)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text("Schedule", style: TextStyle(color: kPrimaryColor)),
            onPressed: () async {
              await widget.database.scheduleAppointment(doctorUid);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
