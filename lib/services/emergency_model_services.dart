import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List<dynamic>> loadWoundsData() async {
  final jsonString =
      await rootBundle.loadString('assets/wound_model/emergency.json');
  final jsonResponse = jsonDecode(jsonString);
  return jsonResponse['emergency'];
}
