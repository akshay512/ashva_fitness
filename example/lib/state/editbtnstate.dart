import 'package:flutter/material.dart';

class EditButtonState extends ChangeNotifier {
  bool _isedit = true;

  bool get isEditValue => _isedit;

  toggle() {
    _isedit = !_isedit;

    notifyListeners();
  }
}
