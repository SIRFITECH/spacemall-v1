// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipts_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReceiptsModelAdapter extends TypeAdapter<ReceiptsModel> {
  @override
  final int typeId = 2;

  @override
  ReceiptsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReceiptsModel(
      logo: fields[0] as File?,
      customerName: fields[1] as String,
      businessEmail: fields[2] as String,
      cartTotal: fields[3] as String,
      date: fields[4] as DateTime,
      receiptNo: fields[5] as String,
      attendant: fields[6] as String,
      receiptId: fields[7] as String,
      cartId: fields[8] as String,
      itemsInCart: fields[9] as String,
      paymentMethod: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ReceiptsModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.logo)
      ..writeByte(1)
      ..write(obj.customerName)
      ..writeByte(2)
      ..write(obj.businessEmail)
      ..writeByte(3)
      ..write(obj.cartTotal)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.receiptNo)
      ..writeByte(6)
      ..write(obj.attendant)
      ..writeByte(7)
      ..write(obj.receiptId)
      ..writeByte(8)
      ..write(obj.cartId)
      ..writeByte(9)
      ..write(obj.itemsInCart)
      ..writeByte(11)
      ..write(obj.paymentMethod);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReceiptsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
