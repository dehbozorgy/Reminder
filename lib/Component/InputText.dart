import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputText extends StatefulWidget {

  String? Function(String?)? Validator;

  String? hint;

  String? label;

   String? pathPng;

   TextDirection? textDirection;

   TextAlign? textAlign;

   TextInputType? textInputType;

   TextEditingController? controller;

   int? length;

   String? prefix;

   List<TextInputFormatter>? Formatteres;

  InputText({super.key, this.Validator,  this.hint, this.label ,this.pathPng,  this.textDirection,  this.textAlign,  this.textInputType,  this.controller,  this.length, this.prefix,this.Formatteres});


  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {

  late FocusNode _focusNode;

  late TextEditingController _controller;

  @override
  void initState() {
    _focusNode = FocusNode();
    _controller = widget.controller ?? TextEditingController();
    // TODO: implement initState
    super.initState();

    _focusNode.addListener(() {
      if(_focusNode.hasFocus){
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
      }
    });


  }

  @override
  void dispose() {
    if(widget.controller==null){
      _controller.dispose();
    }
    _focusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.textDirection ?? TextDirection.rtl,
      child: TextFormField(
        style: TextStyle(
            color: Colors.black,
            fontSize: 17.sp,
            fontFamily: 'SansFaNum'
        ),
        validator: widget.Validator,
        focusNode: _focusNode,
        controller: _controller,
        maxLines: 3,
        autovalidateMode: AutovalidateMode.disabled,
        textAlign: widget.textAlign ?? TextAlign.right,
        keyboardType: widget.textInputType ?? TextInputType.name,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.length),
          ...?widget.Formatteres
        ],
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,

          hintText: widget.hint,
          labelText: widget.label,

          prefixText: widget.prefix,

          floatingLabelAlignment: FloatingLabelAlignment.center,
          floatingLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),

          prefixIcon : (widget.pathPng != null) ?
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            clipBehavior: Clip.hardEdge,
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                textDirection: widget.textDirection,
                children: [
                  Image.asset(widget.pathPng!,width: 25,height: 25),
                  VerticalDivider(
                    color: Colors.black,
                    thickness: 1,
                  )
                ],
              ),
            ),
          ) :
          null,

          // suffixIcon: (widget.textDirection==null || (widget.textDirection==TextDirection.rtl)) ?
          // Container(
          //   padding: EdgeInsets.all(8),
          //   decoration: BoxDecoration(
          //     color: Colors.transparent,
          //   ),
          //   clipBehavior: Clip.hardEdge,
          //   child: IntrinsicHeight(
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       textDirection: TextDirection.rtl,
          //       children: [
          //         Image.asset(widget.pathPng!,width: 25,height: 25),
          //         VerticalDivider(
          //           color: Colors.black,
          //           thickness: 1,
          //         )
          //       ],
          //     ),
          //   ),
          // ) :
          // null,

          contentPadding: EdgeInsets.symmetric(horizontal: 7,vertical: 5),
          border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none
          ),
        ),
      ),
    );
  }

}


