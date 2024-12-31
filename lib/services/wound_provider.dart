import 'package:first_aid_pro_app/Model/wound_models/wound_model.dart';
import 'package:flutter/material.dart';

class WoundService with ChangeNotifier {
  late Wound _wound;

  Wound get wound => _wound;

  void setDiseaseValue(Wound wound) {
    _wound = wound;
    notifyListeners();
  }
}
