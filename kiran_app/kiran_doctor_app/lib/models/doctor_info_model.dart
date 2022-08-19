class DoctorInfoModel {
  final String email;
  final String displayName;
  final String registrationNumber;
  final String locationLat;
  final String locationLng;

  DoctorInfoModel({
    required this.email,
    required this.displayName,
    required this.registrationNumber,
    required this.locationLat,
    required this.locationLng,
  });

  factory DoctorInfoModel.fromMap(Map<String, dynamic> map) {
    return DoctorInfoModel(
      email: map['email'],
      displayName: map['displayName'],
      registrationNumber: map['registrationNumber'],
      locationLat: map['locationLat'],
      locationLng: map['locationLng'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'registrationNumber': registrationNumber,
      'locationLat': locationLat,
      'locationLng': locationLng,
    };
  }
}
