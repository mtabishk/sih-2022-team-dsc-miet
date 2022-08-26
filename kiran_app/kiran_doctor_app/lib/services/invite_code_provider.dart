import 'package:flutter/material.dart';
import 'package:kiran_doctor_app/services/shared_preferences_service.dart';

class ShowInviteCodeProvider extends ChangeNotifier {
  bool inviteCodeCompleted =
      Constants.prefs?.getBool('inviteCodeCompleted') ?? false;

  void changeInviteCodeCompletedValue() {
    inviteCodeCompleted = !inviteCodeCompleted;
    Constants.prefs?.setBool('inviteCodeCompleted', inviteCodeCompleted);
    notifyListeners();
  }
}
