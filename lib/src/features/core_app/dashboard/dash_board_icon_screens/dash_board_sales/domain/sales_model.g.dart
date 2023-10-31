// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalesModelAdapter extends TypeAdapter<SalesModel> {
  @override
  final int typeId = 11;

  @override
  SalesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalesModel(
      saleId: fields[0] as String,
      attendant: fields[1] as String,
      date: fields[2] as DateTime,
      cart: fields[3] != null && fields[3] is List
          ? (fields[3] as List).cast<CartItemModel>()
          : <CartItemModel>[],
      customerName: fields[4] as String,
      cartTotal: fields[5] as String,
      storeId: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SalesModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.saleId)
      ..writeByte(1)
      ..write(obj.attendant)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.cart)
      ..writeByte(4)
      ..write(obj.customerName)
      ..writeByte(5)
      ..write(obj.cartTotal)
      ..writeByte(6)
      ..write(obj.storeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
