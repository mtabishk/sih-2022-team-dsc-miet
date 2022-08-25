class UserInfoModel {
  final String email;
  final String displayName;
  final String gender;
  final String age;
  final String emergencyContact;
  final String animationCharacter;
  final String locationLat;
  final String locationLng;

  UserInfoModel({
    required this.email,
    required this.displayName,
    required this.gender,
    required this.age,
    required this.emergencyContact,
    required this.animationCharacter,
    required this.locationLat,
    required this.locationLng,
  });

  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      email: map['email'],
      displayName: map['displayName'],
      gender: map['gender'],
      age: map['age'],
      emergencyContact: map['emergencyContact'],
      animationCharacter: map['animationCharacter'],
      locationLat: map['locationLat'],
      locationLng: map['locationLng'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'animationCharacter': animationCharacter,
      'locationLat': locationLat,
      'locationLng': locationLng,
    };
  }
}
