import 'package:flutter/material.dart';
import 'package:kiran_user_app/services/shared_preferences_service.dart';

class ShowOnboardingProvider extends ChangeNotifier {
  bool questionareCompleted =
      Constants.prefs?.getBool('questionareCompleted') ?? false;

  void changeQuestionareCompletedValue() {
    questionareCompleted = !questionareCompleted;
    Constants.prefs?.setBool('questionareCompleted', questionareCompleted);
    notifyListeners();
  }
}
