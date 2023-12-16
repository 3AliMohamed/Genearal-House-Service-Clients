import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';

import '../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../reusable/app_bar.dart';
import '../reusable/bottom_navigation_bar.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String client_name='Sara';
  String client_email='sarayousrei7186231893672186@gmail.com';
  int selectedTab =0;
  String selectedValue = 'English'; // Initial selected value

  // List of items for the dropdown menu
  List<String> items = ['English', 'Arabic',];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      appBar: CustomAppBar(
        onUserIconPressed: () {
          Navigator.of(context).pushNamed('/drawer_screen');
        },
        onLoginPressed: () {
          Navigator.of(context).pushNamed('/login');
        },
      ),
      body: Container(
          height: ScreenUtil().screenHeight,
          decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.fitWidth,
          ),
          ),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h,),
              Padding(
                padding:  EdgeInsets.only(left: 8.sp),
                child: Text("Hello $client_name",
                style: TextStyle(color: Colors.white, fontSize: 30.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 8.sp),
                child: Text(client_email,
                style: TextStyle(color: Colors.white,),
                ),
              ),
              SizedBox(height: 60.h,),
              Row(
                children: [
                  Image.asset("assets/images/profile_icon.png",  width: 50.w,height: 50.h,),
                  SizedBox(width: 10.w,),
                  InkWell(
                    onTap: ()
                      {
                        Navigator.of(context).pushNamed('/profile');
                      },
                      child: Text("Profile",
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold), )
                  )
                ],
              ),
              SizedBox(height: 10.h),
              Row(
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/my_orders_icon.png",width: 50.w,height: 50.h,),
                  SizedBox(width: 10.w,),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed('/my_orders');
                    },
                      child: Text("My Orders",
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold), ))
                ],
              ),
              SizedBox(height: 20.h),
              Row(
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/change_lang_icon.png",width: 50.w,height: 50.h),
                  SizedBox(width: 10.w,),
                  Text("Change Language", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  SizedBox(width: 110.w,),
                  Container(
                    // width: 10.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2.0.sp), // Border
                        borderRadius: BorderRadius.circular(10.sp), // Border radius
                      ),
                    child: DropdownButton(
                      style: TextStyle(
                        color: Colors.blue, // Text color
                        fontSize: 16.0, // Text size
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down, // Dropdown icon
                        color: Colors.white, // Icon color
                      ),
                      dropdownColor: Colors.black,
                      value: selectedValue, // Current selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: items.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Padding(
                            padding: EdgeInsets.only(left:5.sp),
                            child: Text(
                              item,
                            style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset("assets/images/logout_icon.png",width: 50.w,height: 50.h),
                      // SizedBox(width: 10.w,),
                      TextButton(
                        onPressed: (){
                          SharedPreferencesManager.clearUserSession();
                          Navigator.of(context).pushNamed('/home');
                        },
                        child:const Text("Logout", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold) )
                      )
                    ],
              ),

            ],
          )

      ),
    );
  }
}
