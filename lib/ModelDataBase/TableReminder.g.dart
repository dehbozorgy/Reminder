// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TableReminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TableReminderAdapter extends TypeAdapter<TableReminder> {
  @override
  final int typeId = 0;

  @override
  TableReminder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TableReminder(
      title: fields[0] as String,
      dateTime: fields[1] as DateTime,
      Active: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TableReminder obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.Active);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TableReminderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
