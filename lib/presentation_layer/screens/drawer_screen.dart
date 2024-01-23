
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/logout/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/logout/states.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';
import 'package:get/get.dart';

import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../reusable/app_bar.dart';
import 'address.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String? client_name=SharedPreferencesManager.getString('name');
  String? client_email=SharedPreferencesManager.getString('email');

  String? selectedValue = SharedPreferencesManager.getString('lang') =='en'? 'English':'Arabic';

  // List of items for the dropdown menu
  List<String> items = ['English', 'Arabic',];
  final List<Map<String, dynamic>> locale = [
    {'name': 'English', 'locale': Locale('en')},
    {'name': 'Arabic', 'locale': Locale('ar')},
  ];

  _updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xff0083F7).withOpacity(0.8),
              // spreadRadius: -20,
            ),
            BoxShadow(
              color: Color(0xff06083D),
              // Color(0xff06083D).withOpacity(0.9),
              spreadRadius: -20,
              blurRadius: 20,
              offset: Offset(20, 10),
              // blurStyle: BlurStyle.solid
            )
          ],
        ),
        child: PhysicalModel(
          color: Color(0xff06083D).withOpacity(0.6),
          elevation: 5.0, // Adjust the elevation as needed
          // borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
          child: BottomNavigationBar(
            items: AppCubit.get(context).buildBottomNavItems(),
            onTap: (index) => AppCubit.get(context).navigateOnTab(context, index),
            currentIndex: AppCubit.get(context).selectedTap,
            selectedFontSize: 10.sp,
            unselectedFontSize: 10.sp,
            unselectedItemColor: Colors.blueGrey,
            selectedItemColor: Colors.blueGrey,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent, // Set background color to transparent
          ),
        ),
      ),
      appBar: CustomAppBar(),
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
                child: Text(Trans("Hello ").tr+ client_name! !="" ? client_name! : Trans('Client').tr,
                style: TextStyle(color: Colors.white, fontSize: 30.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 8.sp),
                child: Text(client_email !=null ? client_email! : "Client@gmail.com",
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
                      child: Text(Trans("Profile").tr,
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold), )
                  )
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Image.asset("assets/images/myAddresses.png",  width: 50.w,height: 50.h,),
                  SizedBox(width: 10.w,),
                  InkWell(
                    onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Address(isShowed: false,)));
                      },
                      child: Text(Trans("My Addresses").tr,
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
                      child: Text(Trans("My Orders").tr,
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold), ))
                ],
              ),
              SizedBox(height: 20.h),
              Row(
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/change_lang_icon.png",width: 50.w,height: 50.h),
                  SizedBox(width: 10.w,),
                  Text(Trans("Change Language").tr, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  SizedBox(width: SharedPreferencesManager.getString('lang')=='en'? 125.w :180.w,),
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
                          if (selectedValue == 'English') {
                            SharedPreferencesManager.setString('lang', 'en');
                            _updateLanguage(Locale('en'));
                          } else {
                            SharedPreferencesManager.setString('lang', 'ar');
                            _updateLanguage(Locale('ar'));
                          }
                        });
                      },
                      items: items.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Padding(
                            padding: EdgeInsets.only(left:5.sp),
                            child: Text(
                              Trans(item).tr,
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
              BlocListener<LogoutCubit,LogOutStates>(
                  listener: (context,state){
                    if(state is SuccessState)
                      {showToast("logOut Successfully");}
                  },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/logout_icon.png",width: 50.w,height: 50.h),
                    // SizedBox(width: 10.w,),
                    TextButton(
                        onPressed: (){
                          // LogoutCubit.get(context).logOut();
                          SharedPreferencesManager.clearUserSession();
                          Navigator.of(context).pushNamed('/home');
                        },
                        child: Text(Trans("Logout").tr, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold) )
                    )
                  ],
                ),

              )

            ],
          )

      ),
    );
  }
}
