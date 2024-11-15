import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/Component/BareReminder.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';


import '../Component/InputText.dart';
import '../ModelDataBase/TableReminder.dart';

class PannelSaver extends StatefulWidget {
  const PannelSaver({super.key, this.data});

  final TableReminder? data;

  @override
  State<PannelSaver> createState() => _PannelSaverState();
}

class _PannelSaverState extends State<PannelSaver> {

  final String PathPng = 'assets/png/subject.png';

  final GlobalKey<FormState> FormKey = GlobalKey<FormState>();

  late Jalali initdate;

  TextEditingController txtTitle = TextEditingController();

  late String showDate,showTime;

  @override
  void initState() {

    if(widget.data!=null){
      initdate = Jalali.fromDateTime(widget.data!.dateTime);
      txtTitle.text = widget.data!.title;
    }
    else {
      initdate = Jalali.now();
    }

    UpdateDateTime();

    // TODO: implement initState
    super.initState();


  }

  SetDate() async {

    FocusManager.instance.primaryFocus!.unfocus();

    Jalali tempPickedDate = initdate;

    await showModalBottomSheet<Jalali>(
        context: context,
        builder: (context)
        {
          return Container(
            height: 250,
            child: Column(
              children: <Widget>[

                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.h
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      textDirection: TextDirection.ltr,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {

                            UpdateDateTime();

                            Navigator.of(context).pop();


                          },
                          child: Text('لغو',style: TextStyle(
                            color: Colors.white,
                          )),
                          style: ButtonStyle(
                              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              )),
                              backgroundColor: WidgetStatePropertyAll(Colors.red)
                          ),
                        ),
                        Image.asset('assets/png/calender.png',width: 30,height: 30),
                        ElevatedButton(
                          onPressed: () {

                            // DateTime j1 = tempPickedDate.toDateTime();

                            // tempPickedDate = Jalali(tempPickedDate.year,tempPickedDate.month,tempPickedDate.day,initdate.hour,initdate.minute);

                            initdate = Jalali(tempPickedDate.year,tempPickedDate.month,tempPickedDate.day,initdate.hour,initdate.minute);

                            UpdateDateTime();

                            Navigator.of(context).pop();
                          },
                          child: Text('تایید',style: TextStyle(
                            color: Colors.white,
                          )),
                          style: ButtonStyle(
                              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              )),
                              backgroundColor: WidgetStatePropertyAll(Color(0xff43c79f))
                          ),

                        ),
                      ],
                    ),
                  ),
                ),

                const Divider(
                  height: 0,
                  thickness: 1,
                ),

                Expanded(
                  child: Container(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: PersianCupertinoDatePicker(
                        mode: PersianCupertinoDatePickerMode.date,
                        initialDateTime: initdate,
                        use24hFormat: true,
                        dateOrder: DatePickerDateOrder.ymd,
                        minimumDate: initdate,
                        onDateTimeChanged: (Jalali dateTime) {
                          tempPickedDate = dateTime;
                        },
                      ),
                    ),
                  ),


                ),

              ],
            ),
          );
        });

  }

  SetTime() async {

    FocusManager.instance.primaryFocus!.unfocus();

    Jalali tempPickedTime = initdate;

    await showModalBottomSheet<Jalali>(
        context: context,
        builder: (context)
        {
          return Container(
            height: 250,
            child: Column(
              children: <Widget>[

                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.h
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      textDirection: TextDirection.ltr,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {

                            UpdateDateTime();

                            Navigator.of(context).pop();

                          },
                          child: Text('لغو',style: TextStyle(
                            color: Colors.white,
                          )),
                          style: ButtonStyle(
                              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              )),
                              backgroundColor: WidgetStatePropertyAll(Colors.red)
                          ),
                        ),
                        Image.asset('assets/png/clock.png',width: 30,height: 30),
                        ElevatedButton(
                          onPressed: () {

                            initdate = tempPickedTime;

                            UpdateDateTime();

                            Navigator.of(context).pop();

                          },
                          child: Text('تایید',style: TextStyle(
                            color: Colors.white,
                          )),
                          style: ButtonStyle(
                              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              )),
                              backgroundColor: WidgetStatePropertyAll(Color(0xff43c79f))
                          ),

                        ),
                      ],
                    ),
                  ),
                ),

                const Divider(
                  height: 0,
                  thickness: 1,
                ),

                Expanded(
                  child: Container(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: PersianCupertinoDatePicker(
                        mode: PersianCupertinoDatePickerMode.time,
                        initialDateTime: initdate,
                        use24hFormat: true,
                        dateOrder: DatePickerDateOrder.ymd,
                        minimumDate: initdate,
                        onDateTimeChanged: (Jalali dateTime) {
                          tempPickedTime = dateTime;
                        },
                      ),
                    ),
                  ),


                ),
              ],
            ),
          );
        });

  }

  UpdateDateTime(){

    showDate = '${initdate.year} / ${initdate.month} / ${initdate.day}';

    showTime = '${initdate.hour} : ${initdate.minute}';

    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.9.sw,
      decoration: BoxDecoration(
          color: Colors.indigoAccent,
          borderRadius: BorderRadius.circular(10)
      ),
      constraints: BoxConstraints(
        maxHeight: 0.8.sh,
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
              width: 80.w,height: 80.w,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.7),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurStyle: BlurStyle.outer,
                        spreadRadius: 0,
                        blurRadius: 5
                    )
                  ]
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                  PathPng,
                  alignment: Alignment.center,fit: BoxFit.fill).animate(
                effects: [
                  ScaleEffect(begin: Offset(0.0, 0.0),end: Offset(1.0, 1.0),duration: 300.ms,delay: 300.ms,alignment: Alignment.center)
                ] ,
              )
          ),

          Form(
            key: FormKey,
            child: Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                children: [

                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.h
                    ),
                    child: InputText(
                      pathPng: PathPng,
                      textDirection: TextDirection.ltr,
                      // textAlign: widget.data==null ? TextAlign.center : TextAlign.start,
                      // hint: widget.data==null ? 'θ-Eo' : null,
                      hint: 'ثبت عنوان',
                      // prefix: widget.data==null ? null : 'θ-Eo : ',
                      // textInputType: TextInputType.numberWithOptions(decimal: true,signed: true),
                      Validator: (String? Input) => Input!.isEmpty ? 'عنوان نمیتواند خالی باشد' : null,
                      controller: txtTitle,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.h
                    ),
                    child: GestureDetector(
                      onTap: (){
                        SetDate();
                      },
                        child: BareReminder(Title: showDate, pathPng: 'assets/png/calender.png',textDirection: TextDirection.ltr)
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.h
                    ),
                    child: GestureDetector(
                        onTap: (){
                          SetTime();
                        },
                        child: BareReminder(Title: showTime, pathPng: 'assets/png/clock.png',textDirection: TextDirection.ltr)),
                  ),

                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 15
            ),
            child: ElevatedButton(
              onPressed: () async {

                if(FormKey.currentState!.validate()){

                  FocusManager.instance.primaryFocus?.unfocus();

                  TableReminder tblReminder = TableReminder(
                      title: txtTitle.text.trim(),
                      dateTime: initdate.toDateTime(),
                    Active: true
                  );

                  Navigator.pop(context,tblReminder);

                }

              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('تایید',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15.sp
                  )),
                  SizedBox(width: 5),
                  Image.asset('assets/png/ok.png',width: 30,height: 30)
                ],
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  fixedSize: MaterialStateProperty.all(Size(double.maxFinite,40))
              ),
            ),
          ),

        ],

      ),
    ).animate(
      effects: [
        ScaleEffect(begin: Offset(0.0, 0.0),end: Offset(1.0, 1.0),duration: 300.ms,alignment: Alignment.center)
      ] ,
    );
  }

}
