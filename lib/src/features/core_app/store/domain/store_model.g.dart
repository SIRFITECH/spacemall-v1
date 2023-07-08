// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoreModelAdapter extends TypeAdapter<StoreModel> {
  @override
  final int typeId = 4;

  @override
  StoreModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreModel(
      logo: fields[0] as File?,
      storeName: fields[1] as String,
      bankName: fields[2] as String,
      accountNumber: fields[11] as String,
      contact: fields[3] as String,
      stock: (fields[4] as List).cast<StockModel>(),
      receipts: (fields[5] as List).cast<ReceiptsModel>(),
      debts: (fields[6] as List).cast<DebtsModel>(),
      staff: (fields[7] as List).cast<StaffModel>(),
      sales: (fields[8] as List).cast<SalesModel>(),
      customer: (fields[9] as List).cast<CustomerModel>(),
      storeId: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StoreModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.logo)
      ..writeByte(1)
      ..write(obj.storeName)
      ..writeByte(2)
      ..write(obj.bankName)
      ..writeByte(3)
      ..write(obj.contact)
      ..writeByte(4)
      ..write(obj.stock)
      ..writeByte(5)
      ..write(obj.receipts)
      ..writeByte(6)
      ..write(obj.debts)
      ..writeByte(7)
      ..write(obj.staff)
      ..writeByte(8)
      ..write(obj.sales)
      ..writeByte(9)
      ..write(obj.customer)
      ..writeByte(10)
      ..write(obj.storeId)
      ..writeByte(11)
      ..write(obj.accountNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
