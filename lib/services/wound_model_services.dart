import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List<dynamic>> loadWoundsData() async {
  final jsonString =
      await rootBundle.loadString('assets/wound_model/wounds.json');
  final jsonResponse = jsonDecode(jsonString);
  return jsonResponse['wounds']; // Assuming the top-level JSON key is 'wounds'
}
