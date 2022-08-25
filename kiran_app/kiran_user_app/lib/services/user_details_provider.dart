import 'package:flutter/material.dart';
import 'package:kiran_user_app/services/shared_preferences_service.dart';

class UserDetailsProvider extends ChangeNotifier {
  bool getUserDetails = Constants.prefs?.getBool('getUserDetails') ?? true;

  void changeGetUserDetailsValue() {
    getUserDetails = !getUserDetails;
    Constants.prefs?.setBool('getUserDetails', getUserDetails);
    notifyListeners();
  }
}
