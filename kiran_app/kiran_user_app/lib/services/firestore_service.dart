import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiran_user_app/models/feedback_model.dart';
import 'package:kiran_user_app/models/user_animation_character.dart';
import 'package:kiran_user_app/models/user_details_model.dart';
import 'package:kiran_user_app/models/user_info_model.dart';
import 'package:kiran_user_app/models/user_location_model.dart';

abstract class Database {
  Future<void> setUserAccountInfoData(UserInfoModel data);
  Future<UserInfoModel> getUserAccountInfoData();
  Future<void> updateUserAnimationCharacter(
      {required UserAnimationCharacterModel data});
  Future<void> updateUsersLocation({required UserLocationModel data});
  Future<void> updateUserDetails({required UserDetailsModel data});
  Future<void> submitFeedbackData(FeedbackModel feedback);
  Future<void> scheduleAppointment(String doctorUid);
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  final String uid;

  @override
  Future<void> setUserAccountInfoData(UserInfoModel data) async {
    String path = 'users/$uid';
    final _reference = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await _reference.set(data.toMap());
  }

  @override
  Future<UserInfoModel> getUserAccountInfoData() async {
    String path = 'users/$uid';
    String displayName = "";
    String age = '';
    String gender = '';
    String emergencyContact = '';
    String emergencyContactName = '';
    String email = "";
    String locationLat = "";
    String locationLng = "";
    String animationCharacter = "";
    await FirebaseFirestore.instance
        .doc(path)
        .get()
        .then((DocumentSnapshot snapshot) {
      displayName = snapshot['displayName'].toString();
      age = snapshot['age'].toString();
      gender = snapshot['gender'].toString();
      email = snapshot['email'].toString();
      locationLat = snapshot['locationLat'].toString();
      locationLng = snapshot['locationLng'].toString();
      animationCharacter = snapshot['animationCharacter'].toString();
    });
    return UserInfoModel(
      displayName: displayName,
      gender: gender,
      age: age,
      emergencyContact: emergencyContact,
      emergencyContactName: emergencyContactName,
      email: email,
      animationCharacter: animationCharacter,
      locationLat: locationLat,
      locationLng: locationLng,
    );
  }

  @override
  Future<void> updateUserAnimationCharacter(
      {required UserAnimationCharacterModel data}) async {
    String path = 'users/$uid';
    final _refrence = FirebaseFirestore.instance.doc(path);
    await _refrence.update({
      'animationCharacter': data.animationCharacter,
    });
  }

  @override
  Future<void> updateUsersLocation({required UserLocationModel data}) async {
    String path = 'users/$uid';
    final _refrence = FirebaseFirestore.instance.doc(path);
    await _refrence.update({
      'locationLat': data.locationLat,
      'locationLng': data.locationLng,
    });
  }

  @override
  Future<void> updateUserDetails({required UserDetailsModel data}) async {
    String path = 'users/$uid';
    final _refrence = FirebaseFirestore.instance.doc(path);
    await _refrence.update({
      'displayName': data.displayName,
      'gender': data.gender,
      'age': data.age,
      'emergencyContact': data.emergencyContact,
    });
  }

  @override
  Future<void> submitFeedbackData(FeedbackModel feedback) async {
    String path = 'feedback/$uid';
    final _reference = FirebaseFirestore.instance.doc(path);
    await _reference.set(feedback.toMap());
  }

  @override
  Future<void> scheduleAppointment(String doctorUid) async {
    String path = 'appointments/$doctorUid';
    final _reference = FirebaseFirestore.instance.doc(path);
    await _reference.set({
      'doctorUid': doctorUid,
      'patientUid': uid,
      'date': DateTime.now(),
    });
  }
}
