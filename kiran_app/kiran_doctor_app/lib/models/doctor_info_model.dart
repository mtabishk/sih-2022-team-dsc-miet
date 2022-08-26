class DoctorInfoModel {
  final String email;
  final String displayName;
  final String inviteCode;
  final String locationLat;
  final String locationLng;
  final bool isOnline;
  final String phoneNumber;
  final String specialization;

  DoctorInfoModel({
    required this.email,
    required this.displayName,
    required this.inviteCode,
    required this.locationLat,
    required this.locationLng,
    required this.isOnline,
    required this.phoneNumber,
    required this.specialization,
  });

  factory DoctorInfoModel.fromMap(Map<String, dynamic> map) {
    return DoctorInfoModel(
      email: map['email'],
      displayName: map['displayName'],
      inviteCode: map['inviteCode'],
      locationLat: map['locationLat'],
      locationLng: map['locationLng'],
      isOnline: map['isOnline'],
      phoneNumber: map['phoneNumber'],
      specialization: map['specialization'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'inviteCode': inviteCode,
      'locationLat': locationLat,
      'locationLng': locationLng,
      'isOnline': isOnline,
      'phoneNumber': phoneNumber,
      'specialization': specialization,
    };
  }
}
