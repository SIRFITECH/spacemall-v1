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
      profilePic: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      email: fields[3] as String,
      gender: fields[4] as String,
      contactNumber: fields[5] as String,
      whatsappNumber: fields[6] as String,
      homeAddress: fields[7] as String,
      zipCode: fields[11] as String,
      state: fields[8] as String,
      city: fields[9] as String,
      country: fields[10] as String,
      bio: fields[12] as String,
      uid: fields[13] as String,
      role: fields[14] as String,
      cart: (fields[15] as List).cast<CheckOutItemModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.profilePic)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.contactNumber)
      ..writeByte(6)
      ..write(obj.whatsappNumber)
      ..writeByte(7)
      ..write(obj.homeAddress)
      ..writeByte(8)
      ..write(obj.state)
      ..writeByte(9)
      ..write(obj.city)
      ..writeByte(10)
      ..write(obj.country)
      ..writeByte(11)
      ..write(obj.zipCode)
      ..writeByte(12)
      ..write(obj.bio)
      ..writeByte(13)
      ..write(obj.uid)
      ..writeByte(14)
      ..write(obj.role)
      ..writeByte(15)
      ..write(obj.cart);
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
