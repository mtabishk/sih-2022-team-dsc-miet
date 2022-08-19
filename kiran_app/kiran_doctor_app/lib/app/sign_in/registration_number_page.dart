import 'package:flutter/material.dart';
import 'package:kiran_doctor_app/app/constants.dart';
import 'package:kiran_doctor_app/models/doctor_registration_model.dart';
import 'package:kiran_doctor_app/services/firestore_service.dart';
import 'package:kiran_doctor_app/services/registration_number_provider.dart';
import 'package:provider/provider.dart';

class RegistrationNumberPage extends StatefulWidget {
  RegistrationNumberPage({Key? key}) : super(key: key);

  @override
  State<RegistrationNumberPage> createState() => _RegistrationNumberPageState();
}

class _RegistrationNumberPageState extends State<RegistrationNumberPage> {
  final TextEditingController _registrationNumberCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registrationNumberCompleted =
        Provider.of<ShowRegistrationNumberProvider>(context, listen: false);
    final database = Provider.of<Database>(context, listen: false);
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(children: [
        Container(
          height: _height * 0.8,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              )),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(-_width * 0.1, -_width * 1.1),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kPrimaryColor.withOpacity(0.8),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(
              _width * 0.6,
              -_width * 0.7,
            ),
          child: Container(
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          left: 10.0,
          child: SafeArea(
            child: SizedBox(
              height: 50.0,
              child: Image.asset("assets/icons/kiran-logo.png"),
            ),
          ),
        ),
        Positioned(
          top: _height / 2.5,
          left: _width / 8,
          right: _width / 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Enter Registration Number",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 20.0),
                child: TextField(
                  controller: _registrationNumberCtr,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    fillColor: kSecondaryColor,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 40.0,
          right: 10,
          child: InkWell(
            onTap: () async {
              if (_registrationNumberCtr.text.isNotEmpty) {
                print(_registrationNumberCtr.text);
                await database.updateDoctorRegistrationNummber(
                  data: DoctorRegistrationNumberModel(
                      doctorRegistrationNumber: _registrationNumberCtr.text),
                );
                registrationNumberCompleted
                    .changeRegistrationNumberCompletedValue();
              }
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "Version 1.0.0",
            style: TextStyle(color: Colors.white60),
          ),
        ),
      ]),
    );
  }
}
