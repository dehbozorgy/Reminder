import 'package:hive/hive.dart';

part 'TableReminder.g.dart';

@HiveType(typeId: 0)
class TableReminder {

  @HiveField(0)
  final String title;

  @HiveField(1)
  final DateTime dateTime;

  @HiveField(2)
  final bool Active;

  const TableReminder({required this.title, required this.dateTime,required this.Active});

}