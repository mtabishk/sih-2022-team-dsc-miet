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
                    .collection('doctors')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done ||
                      snapshot.connectionState == ConnectionState.active) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kPrimaryColor.withOpacity(0.5),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final doc = snapshot.data!.docs[index];
                          final doctorUid = snapshot.data!.docs[index].id;
                          final bool isOnline = doc['isOnline'];

                          return ListTile(
                            onTap: !isOnline
                                ? null
                                : () async {
                                    // schedule appointment
                                    await showAppointmentDialog(
                                      context,
                                      title: "Book Appointment",
                                      content:
                                          "Are you sure you want to schedule an appointment with ${doc['displayName']}?",
                                      doctorUid: doctorUid,
                                    );
                                  },
                            title: Text(doc['displayName']),
                            subtitle: Text(doc['specialization']),
                            trailing: Icon(
                              Icons.circle,
                              color: isOnline ? Colors.green : Colors.red,
                            ),
                          );
                        },
                      ),
                    );
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
