import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiran_doctor_app/models/doctor_info_model.dart';
import 'package:kiran_doctor_app/models/doctor_location_model.dart';
import 'package:kiran_doctor_app/models/doctor_registration_model.dart';

abstract class Database {
  Future<void> setDoctorAccountInfoData(DoctorInfoModel data);
  Future<DoctorInfoModel> getDoctorAccountInfoData();
  Future<void> updateDoctorRegistrationNummber(
      {required DoctorRegistrationNumberModel data});
  Future<void> updateDoctorLocation({required DoctorLocationModel data});
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  final String uid;

  @override
  Future<void> setDoctorAccountInfoData(DoctorInfoModel data) async {
    String path = 'doctors/$uid';
    final _reference = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await _reference.set(data.toMap());
  }

  @override
  Future<DoctorInfoModel> getDoctorAccountInfoData() async {
    String path = 'doctors/$uid';
    String displayName = "";
    String email = "";
    String registrationNumber = "";
    String locationLat = "";
    String locationLng = "";
    await FirebaseFirestore.instance
        .doc(path)
        .get()
        .then((DocumentSnapshot snapshot) {
      displayName = snapshot['displayName'].toString();
      email = snapshot['email'].toString();
      registrationNumber = snapshot['registrationNumber'].toString();
      locationLat = snapshot['locationLat'].toString();
      locationLng = snapshot['locationLng'].toString();
    });
    return DoctorInfoModel(
      displayName: displayName,
      email: email,
      registrationNumber: registrationNumber,
      locationLat: locationLat,
      locationLng: locationLng,
    );
  }

  @override
  Future<void> updateDoctorRegistrationNummber(
      {required DoctorRegistrationNumberModel data}) async {
    String path = 'doctors/$uid';
    final _refrence = FirebaseFirestore.instance.doc(path);
    await _refrence.update({
      'registrationNumber': data.doctorRegistrationNumber,
    });
  }

  @override
  Future<void> updateDoctorLocation({required DoctorLocationModel data}) async {
    String path = 'doctors/$uid';
    final _refrence = FirebaseFirestore.instance.doc(path);
    await _refrence.update({
      'locationLat': data.locationLat,
      'locationLng': data.locationLng,
    });
  }
}
