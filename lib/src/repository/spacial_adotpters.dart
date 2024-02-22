import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';

class RxIntAdapter extends TypeAdapter<RxInt> {
  @override
  final int typeId = 6;

  @override
  RxInt read(BinaryReader reader) {
    return RxInt(reader.readInt());
  }

  @override
  void write(BinaryWriter writer, RxInt obj) {
    writer.writeInt(obj.value);
  }
}

class RxDoubleAdapter extends TypeAdapter<RxDouble> {
  @override
  final int typeId = 12;

  @override
  RxDouble read(BinaryReader reader) {
    return RxDouble(reader.readDouble());
  }

  @override
  void write(BinaryWriter writer, RxDouble obj) {
    writer.writeDouble(obj.value);
  }
}

class ItemListDataAdapter extends TypeAdapter<List<Map<String, dynamic>>> {
  @override
  final typeId = 1;

  @override
  List<Map<String, dynamic>> read(BinaryReader reader) {
    final length = reader.readByte();
    return List.generate(
        length, (_) => reader.readMap().cast<String, dynamic>());
  }

  @override
  void write(BinaryWriter writer, List<Map<String, dynamic>> obj) {
    writer.writeByte(obj.length);
    for (final map in obj) {
      writer.writeMap(map);
    }
  }
}

class FileAdapter extends TypeAdapter<File> {
  @override
  final typeId = 0;

  @override
  File read(BinaryReader reader) {
    final filePath = reader.readString();
    return File(filePath);
  }

  @override
  void write(BinaryWriter writer, File obj) {
    writer.writeString(obj.path);
  }
}
