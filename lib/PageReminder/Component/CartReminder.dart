import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/ModelDataBase/TableReminder.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '/Component/BareReminder.dart';

import 'CustomSwitch.dart';

class CartReminder extends StatelessWidget {
  const CartReminder({super.key, required this.data, required this.Selected,required this.onChange});

  final TableReminder data;

  final bool Selected;

  final ValueChanged<bool> onChange;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.symmetric(vertical: 15),
        width: 0.9.sw,
        decoration: BoxDecoration(
          color: data.Active ? Colors.green.withOpacity(0.3) : Colors.pink.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              blurRadius: 5
            )
          ]
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [

            Padding(
              padding: EdgeInsets.all(10),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  textDirection: TextDirection.rtl,
                  children: [

                    Center(
                      child: RotatedBox(
                        quarterTurns: -1,
                        child: CustomSwitch(
                          activeColor: Colors.lightGreen,
                          inactiveColor: Colors.pinkAccent,
                          value: data.Active,
                          onChanged: onChange
                        ),
                      ),
                    ),

                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    ),

                    const SizedBox(width: 5),

                    Expanded(
                        child: Builder(builder: (context){

                          Jalali tempJalali = Jalali.fromDateTime(data.dateTime);
                          String showDate = '${tempJalali.year} / ${tempJalali.month} / ${tempJalali.day}';
                          String showTime = '${tempJalali.hour} : ${tempJalali.minute}';

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [

                              BareReminder(Title: data.title, pathPng: 'assets/png/subject.png',textDirection: TextDirection.rtl,maxLines: 3),
                              SizedBox(height: 10),

                              BareReminder(Title: showDate, pathPng: 'assets/png/calender.png',textDirection: TextDirection.ltr),
                              SizedBox(height: 10),

                              BareReminder(Title: showTime, pathPng: 'assets/png/clock.png',textDirection: TextDirection.ltr),

                            ],
                          );
                        })
                    )

                  ],
                ),
              ),
            ),

            Selected ?
            Positioned.fill(
              child: ColoredBox(
                color: Colors.white.withOpacity(0.7),
                child: SizedBox.expand(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 70.w,
                      height: 70.w,
                      margin: EdgeInsets.only(
                          top: 10,
                          right: 10
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black,width: 1)
                      ),
                      child: FittedBox(child: Icon(Icons.check_circle,color: Colors.green)).animate(
                        effects: [
                          ScaleEffect(begin: Offset(0.0, 0.0),end: Offset(1.0, 1.0),duration: 200.ms,delay: 100.ms,alignment: Alignment.center,curve: Curves.fastOutSlowIn)
                        ] ,
                      ),
                    ),
                  ),
                ),
              ),
            ) :
            SizedBox.shrink()


          ],
        ),
      ),
    );
  }

}
