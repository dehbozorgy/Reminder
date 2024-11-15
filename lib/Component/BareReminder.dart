import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BareReminder extends StatelessWidget {

  const BareReminder({super.key,
    required this.Title,
    required this.pathPng,
    this.textDirection,
    this.maxLines});

  final String Title;
  final String pathPng;
  final TextDirection? textDirection;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                blurStyle: BlurStyle.outer,
                spreadRadius: 0,
                blurRadius: 3
            )
          ]
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.ltr,
          children: [
            Image.asset(pathPng,width: 30,height: 30),
            const VerticalDivider(
              color: Colors.black,
              thickness: 1,
              indent: 1,
              endIndent: 1,
            ),
            Expanded(
                child: Text(Title,
                  textAlign: TextAlign.center,
                  maxLines: maxLines,
                  textDirection: textDirection,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
