import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as spinkit;

class WidgetWaiting extends StatefulWidget {

  final Future InputFunction;

  const WidgetWaiting({super.key, required this.InputFunction});


  @override
  State<WidgetWaiting> createState() => _WidgetWaitingState();
}

class _WidgetWaitingState extends State<WidgetWaiting> with TickerProviderStateMixin {

  // AnimationController animationController;
  //
  // TweenSequence<Color> _tweenSequence;
  //
  // Animation<Color> _animation;
  //
  // @override
  // void dispose() {
  //   animationController.dispose();
  //   // TODO: implement dispose
  //   super.dispose();
  // }
  //
  @override
  void initState() {

    // animationController = AnimationController(
    //     duration: Duration(seconds: 2),
    //     vsync: this);
    //
    //
    // _tweenSequence = TweenSequence([
    //   TweenSequenceItem<Color>(
    //       tween: ColorTween(begin: Colors.blueAccent, end: Colors.red).chain(CurveTween(curve: Curves.easeIn)),
    //       weight: 1
    //   ),
    //   TweenSequenceItem<Color>(
    //       tween: ColorTween(begin: Colors.red, end: Colors.green).chain(CurveTween(curve: Curves.easeIn)),
    //       weight: 1
    //   ),
    //   TweenSequenceItem<Color>(
    //       tween: ColorTween(begin: Colors.green, end: Colors.yellow).chain(CurveTween(curve: Curves.easeIn)),
    //       weight: 1
    //   ),
    //   TweenSequenceItem<Color>(
    //       tween: ColorTween(begin: Colors.yellow, end: Colors.pinkAccent).chain(CurveTween(curve: Curves.easeIn)),
    //       weight: 1
    //   ),
    // ]);
    //
    //
    // _animation = animationController.drive(_tweenSequence);


    // TODO: implement initState
    super.initState();


    // _animation.addListener(() {
    //   setState(() {});
    // });



    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // animationController.reset();
      // animationController.forward();
      // animationController.repeat();
      widget.InputFunction.then((value){
        Navigator.pop(context,value);
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ),
        padding: EdgeInsets.all(10),
        child: FittedBox(
          child: spinkit.SpinKitPouringHourGlassRefined(
            color: Color(0xff43c79f)
          ),
        )
      ),
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: Container(
  //         width: 120,
  //         height: 120,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             color: Colors.white
  //         ),
  //         padding: EdgeInsets.all(10),
  //         child: CircularProgressIndicator(
  //           strokeWidth: 10,
  //           valueColor: animationController.drive(_tweenSequence),
  //         ),
  //     ),
  //   );
  // }

}
