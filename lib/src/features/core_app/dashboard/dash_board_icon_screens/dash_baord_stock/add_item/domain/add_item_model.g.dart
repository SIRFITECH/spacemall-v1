// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddItemModelAdapter extends TypeAdapter<AddItemModel> {
  @override
  final int typeId = 10;

  @override
  AddItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddItemModel(
      itemPic: fields[0] as File?,
      itemName: fields[1] as String,
      itemSellingPrice: fields[3] as String,
      itemCategory: fields[4] as String?,
      itemQuantity: fields[5] as String,
      itemCostPrice: fields[2] as String,
      trackProfit: fields[6] as bool,
      trackLowStock: fields[7] as bool,
      preventItemSalesWhenOutOfStock: fields[8] as bool,
      trackExpiry: fields[9] as String,
      expiryAlert: fields[10] as String,
      itemCount: fields[11] as RxInt,
      itemId: fields[12] as String,
      morePics: RxList.from(fields[13] as List),
      // (fields[13] as List).cast<File>(),
    );
  }

  @override
  void write(BinaryWriter writer, AddItemModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.itemPic)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.itemCostPrice)
      ..writeByte(3)
      ..write(obj.itemSellingPrice)
      ..writeByte(4)
      ..write(obj.itemCategory)
      ..writeByte(5)
      ..write(obj.itemQuantity)
      ..writeByte(6)
      ..write(obj.trackProfit)
      ..writeByte(7)
      ..write(obj.trackLowStock)
      ..writeByte(8)
      ..write(obj.preventItemSalesWhenOutOfStock)
      ..writeByte(9)
      ..write(obj.trackExpiry)
      ..writeByte(10)
      ..write(obj.expiryAlert)
      ..writeByte(11)
      ..write(obj.itemCount)
      ..writeByte(12)
      ..write(obj.itemId)
      ..writeByte(13)
      ..write(obj.morePics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
