import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/Component/WidgetWaiting.dart';
import '/ModelDataBase/TableReminder.dart';
import 'PannelSaver.dart';
import '../Component/MessageError.dart';
import '../Notification.dart';
import '/Funcs.dart';
import 'Component/CartReminder.dart';
import '/DataBase.dart';

class PageReminder extends StatefulWidget {
  const PageReminder({super.key});

  @override
  State<PageReminder> createState() => _PageReminderState();
}

class _PageReminderState extends State<PageReminder> {

  int _update = 0;

  List<int> SelectedItems = [];

  bool select_status = false;

  FuncSelect(int index){

    if(SelectedItems.contains(index)){
      SelectedItems.remove(index);
      if(SelectedItems.isEmpty)
        select_status = false;
    }
    else{
      SelectedItems.add(index);
      if(!select_status)
        select_status = true;
    }

    setState(() {});

  }

  openForEdit(TableReminder OldTableReminder,int index) async {

    TableReminder? NewtableCz = await showMessageBoxByShrink(context, PannelSaver(data: OldTableReminder));

    if(NewtableCz!=null && NewtableCz!=OldTableReminder){

      await UpdateUser(index, NewtableCz);

      setState(() {
        _update++;
      });

    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

  }

  Active(TableReminder tblReminder) async {

    DateTime _dt = tblReminder.dateTime;

    String _title = tblReminder.title;

    print('For Active .... ');

    String id = {'title':_title,'date':_dt.toString()}.toString();

    print('Id Map => $id');

    int intId = id.hashCode;

    print('Id Int => $intId');

    await NotificationApi.showScheduledNotification(scheduledDate: _dt,id: intId,payload: id,title: _title,body: id);

  }

  disActive(int index) async {

    TableReminder Temp = await ChangeActivated(index);

    print('For disActive .... ');

    String id = {'title':Temp.title,'date':Temp.dateTime.toString()}.toString();

    print('Id Map => $id');

    int intId = id.hashCode;

    print('Id Int => $intId');

    if(Temp.Active)
      Active(Temp);
    else
      await NotificationApi.Cancel(intId);

  }

  Add() async {

    TableReminder? tblReminder = await showMessageBoxByShrink(context, const PannelSaver());

    if(tblReminder!=null) {

      await SaveReminder(tblReminder);

      await showMessageBox(context, WidgetWaiting(InputFunction: Active(tblReminder)));

      setState(() {
        _update++;
      });

    }

  }

  Delete() async {

    String? res = await showMessageBox(context, MessageError(Message: 'از حذف ردیفهای انتخابی مطمعن هستید ؟'));

    if(res==null || res=='cancel')
      return;

    await DeleteRangeReminder(SelectedItems);

    setState(() {
      SelectedItems.clear();
      select_status = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
            fit: StackFit.expand,

            children: [

              SizedBox.expand(
                child: Opacity(opacity: 0.2,child: FittedBox(child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/png/clock.png'),
                ))),
              ),

              Center(
                child: FutureBuilder<List<TableReminder>>(
                    future: GetAllReminder,
                    builder: (context,snapshot){
                      if(snapshot.hasError){
                        return Text('Error => ${snapshot.error.toString()}');
                      }
                      else if(snapshot.hasData){
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                            itemBuilder: (context,index){
                              return GestureDetector(

                                  onTap: select_status ?
                                      (){

                                    FuncSelect(index);

                                  } :
                                      () async {

                                    openForEdit(snapshot.data!.elementAt(index),index);

                                  },

                                  onLongPress: () {

                                    FuncSelect(index);

                                  },

                                  child: CartReminder(
                                      data: snapshot.data!.elementAt(index),
                                      Selected: SelectedItems.contains(index),
                                      onChange: (value) async {

                                        await showMessageBox(context, WidgetWaiting(InputFunction: disActive(index)));

                                        setState(() {
                                          _update++;
                                        });

                                      })

                              );
                            },
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.only(
                            top: 15,
                            bottom: 70
                          ),
                        );
                      }
                      else{
                        return SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(strokeWidth: 5,color: Colors.indigo)
                        );
                      }
                    }
                ),
              ),

            ],
          )
      ),

      floatingActionButton: FloatingActionButton(

        onPressed: select_status ? Delete : Add,

        child: select_status ?
        FittedBox(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.delete_sweep,size: 100,color: Colors.white),
        )) :
        FittedBox(child: Icon(Icons.add,size: 100)),

        backgroundColor: select_status ? Colors.red : Colors.green,

      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }

}
