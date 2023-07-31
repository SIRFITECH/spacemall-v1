// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debts_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DebtsModelAdapter extends TypeAdapter<DebtsModel> {
  @override
  final int typeId = 7;

  @override
  DebtsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DebtsModel(
      debtId: fields[0] as String,
      customerName: fields[1] as String,
      payDate: fields[2] as DateTime,
      phone: fields[3] as String,
      isPaid: fields[4] as bool,
      cart: fields[5] as CartItemModel,
      amountPayable: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, DebtsModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.debtId)
      ..writeByte(1)
      ..write(obj.customerName)
      ..writeByte(2)
      ..write(obj.payDate)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.isPaid)
      ..writeByte(5)
      ..write(obj.cart)
      ..writeByte(6)
      ..write(obj.amountPayable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebtsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
