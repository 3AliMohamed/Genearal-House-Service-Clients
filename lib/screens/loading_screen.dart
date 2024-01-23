import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:general_house_service_clients/reusable/app_bar.dart';
import 'package:get/get.dart';

import '../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../reusable/bottom_navigation_bar.dart';

class LoadingScreen extends StatefulWidget
{
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState()=>_LoadingScreen();


}
class _LoadingScreen extends State<LoadingScreen> {
  var _time;
  start()
  {
    _time=Timer(Duration(seconds: 1), call);
    // LoginController().me(context);
  }
  void call()
  {
    // LoginController().me(context);
    Navigator.of(context).pushNamed('/checkout');

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
  int selectedTab =1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: BottomNavigationBar(
        //   items: AppCubit.get(context).buildBottomNavItems(),
        //   onTap: (index) => AppCubit.get(context).navigateOnTab(context, index),
        //   currentIndex: AppCubit.get(context).selectedTap,
        //   selectedFontSize: 10.sp,
        //   unselectedFontSize: 10.sp,
        //   unselectedItemColor: Colors.blueGrey,
        //   selectedItemColor: Colors.blueGrey,
        //   type: BottomNavigationBarType.fixed,
        //   backgroundColor: Color(0XFF202020),
        // ),
        // appBar: CustomAppBar(
        //   onUserIconPressed: () {
        //     Navigator.of(context).pushNamed('/drawer_screen');
        //   },
        //   onLoginPressed: () {
        //     Navigator.of(context).pushNamed('/login');
        //   },
        // ),
        body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png",),
              fit: BoxFit.cover,
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              SpinKitFadingCube(
            color: Color(0xffB4AFAF),
          size: 50.0,
        ),// Loading icon
            SizedBox(height: 10.0),
            Text(
              Trans('Please wait, loading...').tr,
              style: TextStyle(fontSize: 16.0,color: Colors.white),
            ),
          ],
        ),
      )
      // Image.asset("assets/images/Splash Screen.png",
      //   width:  ScreenUtil().screenWidth,
      //   height:  ScreenUtil().screenHeight,
      //   fit: BoxFit.fill,
      // ),
    );
  }
}