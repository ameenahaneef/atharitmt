// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScannedProductAdapter extends TypeAdapter<ScannedProduct> {
  @override
  final int typeId = 0;

  @override
  ScannedProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScannedProduct(
      expiryDate: fields[0] as String,
      status: fields[1] as String,
      imagePath: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ScannedProduct obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.expiryDate)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScannedProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
