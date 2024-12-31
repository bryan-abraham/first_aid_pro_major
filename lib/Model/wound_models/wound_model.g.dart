// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wound_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WoundAdapter extends TypeAdapter<Wound> {
  @override
  final int typeId = 0;

  @override
  Wound read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Wound(
      predictedWoundType: fields[0] as String,
      predictedClass: fields[1] as String,
      treatmentSteps: fields[2] as String,
      dateTime: fields[4] as DateTime?,
    )..imagePath = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, Wound obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.predictedWoundType)
      ..writeByte(1)
      ..write(obj.predictedClass)
      ..writeByte(2)
      ..write(obj.treatmentSteps)
      ..writeByte(3)
      ..write(obj.imagePath)
      ..writeByte(4)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WoundAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
