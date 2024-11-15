import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future showMessageBoxByShrink(context,child) async {

  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.transparent,
    alignment: Alignment.center,
    insetPadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.zero,
    elevation: 0,
    content: child,
  );


  return await showDialog(
      context: context,
      barrierDismissible: true,
      useSafeArea: true,
      builder: (context){
        double _bottom = MediaQuery.of(context).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: (_bottom>0.0) ? 1.h : 0,
          ),
          child: alertDialog,
        );
      }
  );

}

Future showMessageBox(context,child) async {

  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.transparent,
    alignment: Alignment.center,
    insetPadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.zero,
    elevation: 0,
    content: child,
  );

  return await showDialog(
      context: context,
      barrierDismissible: true,
      useSafeArea: false,
      builder: (context){
        return alertDialog;
      }
  );

}