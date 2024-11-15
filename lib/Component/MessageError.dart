import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageError extends StatelessWidget {

  final String Message;

  const MessageError({super.key,required this.Message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10)
      ),
      constraints: BoxConstraints(
        maxWidth: 0.8.sw,
        maxHeight: 0.8.sh
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(

          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Container(
                width: 80.w,height: 80.w,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.7)
                ),
                child: Image.asset(
                    'assets/png/warning1.png',
                    alignment: Alignment.center,fit: BoxFit.contain)),

            Flexible(
              fit: FlexFit.loose,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 10),
                physics: BouncingScrollPhysics(),
                child: Text(
                    Message,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).pop('return');
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('تایید',style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )),
                        SizedBox(width: 5),
                        Image.asset('assets/emoji/ok.png',width: 30,height: 30)
                      ],
                    ),
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size.fromWidth(100.w)),
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).pop('cancel');
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('انصراف',style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )),
                        SizedBox(width: 5),
                        Image.asset('assets/emoji/cancel.png',width: 30,height: 30)
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      fixedSize: MaterialStateProperty.all(Size.fromWidth(100.w)),
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    ).animate(
      effects: [
        ScaleEffect(begin: Offset(0.0, 0.0),end: Offset(1.0, 1.0),duration: 300.ms,alignment: Alignment.center)
      ] ,
    );
  }

}
