// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_out_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartItemModelAdapter extends TypeAdapter<CartItemModel> {
  @override
  final int typeId = 9;

  @override
  CartItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemModel(
      itemId: fields[0] as String,
      itemName: fields[1] as String,
      quantityInCart: fields[2] as RxInt,
      price: fields[3] as String,
      totalItemPrice: fields[4] as String,
      subTotal: fields[5] as RxDouble,
      discount: fields[6] as double,
      tax: fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.itemId)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.quantityInCart)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.totalItemPrice)
      ..writeByte(5)
      ..write(obj.subTotal)
      ..writeByte(6)
      ..write(obj.discount)
      ..writeByte(7)
      ..write(obj.tax);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
