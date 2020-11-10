import 'package:flutter/material.dart';

class AgreeCheckboxState extends ChangeNotifier {
  bool _ischecked = false;

  bool get checkboxValue => _ischecked;

  checked(bool val) {
    _ischecked = val;

    notifyListeners();
  }
}