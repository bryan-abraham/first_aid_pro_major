// To parse this JSON data, do
//
//     final imageUpload = imageUploadFromJson(jsonString);

import 'dart:convert';

ImageUpload imageUploadFromJson(String str) =>
    ImageUpload.fromJson(json.decode(str));

String imageUploadToJson(ImageUpload data) => json.encode(data.toJson());

class ImageUpload {
  String? predictedClass;
  String? predictedWoundType;
  List<String>? treatmentSteps;

  ImageUpload({
    this.predictedClass,
    this.predictedWoundType,
    this.treatmentSteps,
  });

  factory ImageUpload.fromJson(Map<String, dynamic> json) => ImageUpload(
        predictedClass: json["predicted_class"],
        predictedWoundType: json["predicted_wound_type"],
        treatmentSteps: json["treatment_steps"] == null
            ? []
            : List<String>.from(json["treatment_steps"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "predicted_class": predictedClass,
        "predicted_wound_type": predictedWoundType,
        "treatment_steps": treatmentSteps == null
            ? []
            : List<dynamic>.from(treatmentSteps!.map((x) => x)),
      };
}
