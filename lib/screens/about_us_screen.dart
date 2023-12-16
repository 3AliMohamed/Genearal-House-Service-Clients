import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../reusable/app_bar.dart';
import '../reusable/bottom_navigation_bar.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          onUserIconPressed: () {
            Navigator.of(context).pushNamed('/drawer_screen');
          },
          onLoginPressed: () {
            Navigator.of(context).pushNamed('/login');
          },
        ),
      bottomNavigationBar: BottomNavigationBar(
        items: AppCubit.get(context).buildBottomNavItems(),
        onTap: (index) => AppCubit.get(context).navigateOnTab(context, index),
        currentIndex: AppCubit.get(context).selectedTap,
        selectedFontSize: 10.sp,
        unselectedFontSize: 10.sp,
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0XFF202020),
      ),
        body: Container( 
          padding: EdgeInsets.all(25.sp),
          height: ScreenUtil().screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [ 
                Text('This Is General House Service ', 
                style: TextStyle(color: Colors.white, 
                fontWeight: FontWeight.bold, 
                ),
                ), 
                
                SizedBox(height: 40.h), 
                
                Text('Service :', 
                style: TextStyle( fontWeight:FontWeight.bold, color: Colors.white, fontSize: 25.sp,),
                ), 
                Text("Welcome to Genral house service . we're glad and grateful"
                    " you're hereWelcome to Genral house service . we're glad and "
                    "grateful you're hereWelcome to Genral house service . we're glad and"
                    " grateful you're hereWelcome to Genral house service . we're"
                    " glad and grateful you're hereWelcome to Genral house"
                    " service . we're glad and grateful you're here Welcome to "
                    "Genral house service . we're glad and ",
                style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 65.h ),
                Text("Payment : ",
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text("Welcome to Genral house service . we're glad and grateful"
                    "you're hereWelcome to Genral house service . we're glad and "
                    "grateful you're hereWelcome to Genral house service . we're"
                    " glad and grateful you're hereWelcome to Genral house service . we're"
                    " glad and grateful you're hereWelcome to Genral house service ."
                    " we're glad and grateful you're here Welcome to "
                    "Genral house service . we're glad and ",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 65.h ),
                Text("Shipping : ",
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text("Welcome to Genral house service . we're glad and grateful "
                    "you're hereWelcome to Genral house service . we're glad and "
                    "grateful you're hereWelcome to Genral house service . "
                    "we're glad and grateful you're hereWelcome to Genral house service . "
                    "we're glad and grateful you're hereWelcome to Genral house service . "
                    "we're glad and grateful you're hereWelcome to Genral house service . "
                    "we're glad and ",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ), );
  }
}
