import 'package:hive_flutter/hive_flutter.dart';

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
