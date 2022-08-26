import 'package:firebase_auth/firebase_auth.dart';

class UserDetailsModel {
  final String displayName;
  final String gender;
  final String age;
  final String emergencyContact;
  final String emergencyContactName;

  UserDetailsModel({
    required this.displayName,
    required this.gender,
    required this.age,
    required this.emergencyContact,
    required this.emergencyContactName,
  });
}
