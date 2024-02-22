// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 3;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return UserModel(
      profilePicLocalPath: fields[0] as String,
      userName: fields[1] as String,
      email: fields[2] as String,
      contactNumber: fields[3] as String,
      uid: fields[5] as String,
      role: fields[4] as String,
      bio: fields[7] as String,
      cart: (fields[8] as List).cast<CartItemModel>(),
      stores: RxList<StoreModel>.from((fields[9] as List<dynamic>)
          .map((store) => StoreModel.fromMap(store))
          .toList()),
      country: fields[6] as String,
      createdAt: fields[10] as String,
      profilePicRemotePath: fields[11] as String,
      storeUIDs: fields[12] as List<dynamic>,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.profilePicLocalPath)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.contactNumber)
      ..writeByte(4)
      ..write(obj.role)
      ..writeByte(5)
      ..write(obj.uid)
      ..writeByte(6)
      ..write(obj.country)
      ..writeByte(7)
      ..write(obj.bio)
      ..writeByte(8)
      ..write(obj.cart)
      ..writeByte(9)
      ..write(obj.stores)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.profilePicRemotePath)
      ..writeByte(12)
      ..write(obj.storeUIDs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
