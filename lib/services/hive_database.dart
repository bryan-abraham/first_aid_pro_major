import 'package:first_aid_pro_app/Model/wound_models/wound_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Wound> getDiseases() => Hive.box<Wound>('wounds_box');
}

class HiveService {
  final box = Boxes.getDiseases();

  // Store wound
  Future addDisease(Wound wound) async {
    await box.add(wound);
  }
}
