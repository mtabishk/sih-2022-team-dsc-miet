import 'package:flutter/material.dart';
import 'package:kiran_doctor_app/services/shared_preferences_service.dart';

class ShowRegistrationNumberProvider extends ChangeNotifier {
  bool registrationNumberCompleted =
      Constants.prefs?.getBool('registrationNumberCompleted') ?? false;

  void changeRegistrationNumberCompletedValue() {
    registrationNumberCompleted = !registrationNumberCompleted;
    Constants.prefs
        ?.setBool('registrationNumberCompleted', registrationNumberCompleted);
    notifyListeners();
  }
}
