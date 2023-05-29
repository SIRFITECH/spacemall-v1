import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';

class FileAdapter extends TypeAdapter<File> {
  @override
  final typeId = 0; // Assign a unique ID for the adapter

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
