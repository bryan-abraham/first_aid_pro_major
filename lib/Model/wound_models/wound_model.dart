import 'package:hive/hive.dart';
part 'wound_model.g.dart';

@HiveType(typeId: 0)
class Wound extends HiveObject {
  @HiveField(0)
  final String predictedWoundType;

  @HiveField(1)
  late String predictedClass;

  @HiveField(2)
  late String treatmentSteps;

  @HiveField(3)
  late String imagePath;

  @HiveField(4)
  late DateTime dateTime;
  Wound(
      {
      required this.predictedWoundType,
      required this.predictedClass,
      required this.treatmentSteps,
      DateTime? dateTime}) {
    dateTime = DateTime.now();
  }
}
