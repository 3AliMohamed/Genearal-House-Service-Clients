import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget
{
  @override
  State<SplashScreen> createState()=>_SplashScreen();


}
class _SplashScreen extends State<SplashScreen> {
  var _time;
  start()
  {
    _time=Timer(Duration(seconds: 5), call);
    // LoginController().me(context);


  }
  void call()
  {
   // LoginController().me(context);
    Navigator.of(context).pushNamed('/home');

  }
  @override
  void initState()
  {

    super.initState();
    start();
  }
  @override
  void dispose()
  {
    _time.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset("assets/images/Splash Screen.png",
        width:  ScreenUtil().screenWidth,
        height:  ScreenUtil().screenHeight,
        fit: BoxFit.fill,
      ),
    );
  }
}