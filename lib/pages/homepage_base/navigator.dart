import 'package:flutter/material.dart';

class ActiveButtonState extends ChangeNotifier {
  ActiveButtonState({this.buttonState = false});

  bool buttonState;

  // bool get buttonState => _buttonState;

  void updateButtonState({required bool status}) {
    buttonState = status;
    notifyListeners();
  }
}
