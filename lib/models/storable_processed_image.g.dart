// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storable_processed_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StorableProcessedImageAdapter
    extends TypeAdapter<StorableProcessedImage> {
  @override
  final int typeId = 1;

  @override
  StorableProcessedImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StorableProcessedImage(
      fields[0] as String,
      (fields[1] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, StorableProcessedImage obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.palette);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StorableProcessedImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
