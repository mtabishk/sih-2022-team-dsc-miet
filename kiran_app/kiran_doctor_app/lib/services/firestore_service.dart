import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiran_doctor_app/models/doctor_info_model.dart';
import 'package:kiran_doctor_app/models/doctor_location_model.dart';
import 'package:kiran_doctor_app/models/doctor_invite_code_model.dart';

abstract class Database {
  Future<void> setDoctorAccountInfoData(DoctorInfoModel data);
  Future<DoctorInfoModel> getDoctorAccountInfoData();
  Future<void> updateDoctorInviteCode({required DoctorInviteCodeModel data});
  Future<void> updateDoctorLocation({required DoctorLocationModel data});
  Future<void> updateDoctorOnlineStatus({required bool isOnline});
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
    String inviteCode = "";
    String locationLat = "";
    String locationLng = "";
    bool isOnline = false;
    String phoneNumber = "";
    String specialization = "";
    await FirebaseFirestore.instance
        .doc(path)
        .get()
        .then((DocumentSnapshot snapshot) {
      displayName = snapshot['displayName'].toString();
      email = snapshot['email'].toString();
      inviteCode = snapshot['inviteCode'].toString();
      locationLat = snapshot['locationLat'].toString();
      locationLng = snapshot['locationLng'].toString();
      isOnline = snapshot['isOnline'];
      phoneNumber = snapshot['phoneNumber'].toString();
      specialization = snapshot['specialization'].toString();
    });
    return DoctorInfoModel(
      displayName: displayName,
      email: email,
      inviteCode: inviteCode,
      locationLat: locationLat,
      locationLng: locationLng,
      isOnline: isOnline,
      phoneNumber: phoneNumber,
      specialization: specialization,
    );
  }

  @override
  Future<void> updateDoctorInviteCode(
      {required DoctorInviteCodeModel data}) async {
    String path = 'doctors/$uid';
    final _refrence = FirebaseFirestore.instance.doc(path);
    await _refrence.update({
      'inviteCode': data.inviteCode,
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

  @override
  Future<void> updateDoctorOnlineStatus({required bool isOnline}) async {
    String path = 'doctors/$uid';
    final _refrence = FirebaseFirestore.instance.doc(path);
    await _refrence.update({
      'isOnline': isOnline,
    });
  }
}
