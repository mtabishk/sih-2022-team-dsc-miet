import 'package:flutter/material.dart';
import 'package:kiran_user_app/services/shared_preferences_service.dart';

class AnimationCharacterProvider extends ChangeNotifier {
  bool showAnimationCharacter =
      Constants.prefs?.getBool('showAnimationCharacter') ?? true;

  void changeShowAnimationCharacterValue() {
    showAnimationCharacter = !showAnimationCharacter;
    Constants.prefs?.setBool('showAnimationCharacter', showAnimationCharacter);
    notifyListeners();
  }
}
