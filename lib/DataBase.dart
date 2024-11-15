import 'package:hive_flutter/adapters.dart';
import 'ModelDataBase/TableReminder.dart';

Future<List<TableReminder>> get GetAllReminder async {
  var tbl = await Hive.openBox<TableReminder>('TableReminder');
  List<TableReminder> data = tbl.values.toList();
  await tbl.close();
  return data;
}

Future SaveReminder(TableReminder data) async {
  var tbl = await Hive.openBox<TableReminder>('TableReminder');
  await tbl.add(data);
  await tbl.close();
}

Future UpdateUser(int index,TableReminder value) async {
  var tbl = await Hive.openBox<TableReminder>('TableReminder');
  await tbl.putAt(index, value);
  await tbl.close();
}

Future DeletAll() async {
  var tbl = await Hive.openBox<TableReminder>('TableReminder');
  await tbl.deleteFromDisk();
  await tbl.close();
}

Future<TableReminder> ChangeActivated(int index) async {
  TableReminder TempData = (await GetAllReminder).elementAt(index);
  TableReminder Temp2 = TableReminder(title: TempData.title, dateTime: TempData.dateTime, Active: TempData.Active^true);
  await UpdateUser(index,Temp2);
  return Temp2;
}



Future DeleteRangeReminder(List<int> Rng) async {

  var tbl = await Hive.openBox<TableReminder>('TableReminder');

  print('Befor SelectedItems  =========>>>>>>>>>> ${Rng.toString()}');
  Rng.sort((a,b) => -(a.compareTo(b)));
  print('After SelectedItems  =========>>>>>>>>>> ${Rng.toString()}');

  for(int index in Rng){
    await tbl.deleteAt(index);
  }

  await tbl.close();

}

