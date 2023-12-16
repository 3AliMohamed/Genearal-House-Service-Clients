import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';

import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../reusable/app_bar.dart';
import '../../reusable/bottom_navigation_bar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int selectedTab=3;
  // TextEditingController name_controller = TextEditingController();
  // TextEditingController phone_controller = TextEditingController();
  // TextEditingController email_controller = TextEditingController();
  // TextEditingController age_controller = TextEditingController();
  // TextEditingController country_controller = TextEditingController();
  // TextEditingController address_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController confirm_password_controller = TextEditingController();
  Map<String,TextEditingController> controllers= {
    'name_controller ': TextEditingController(),
    'phone_controller ': TextEditingController(),
    'email_controller ': TextEditingController(),
    'age_controller ': TextEditingController(),
    'country_controller ': TextEditingController(),
    'address_controller ': TextEditingController(),
  };
  List<String> hintTexts=[
    'Full Name',
    'Phone Number',
    'Email',
    'Age',
    'Country',
    'Address',
  ];
  String? gender='female';
  @override
  void initState(){
    super.initState() ;
    // name_controller.text= SharedPreferencesManager.getString('name')!;
    if(SharedPreferencesManager.containKey('token')==true)
    {
      log(" lkasflamlka");
      controllers['name_controller']?.text=SharedPreferencesManager.getString('name')!;
      // controllers['phone_controller']?.text=SharedPreferencesManager.getString('phone')!;
      // controllers['email_controller']?.text=SharedPreferencesManager.getString('email')!;
      // controllers['age_controller']?.text=SharedPreferencesManager.getString('age')!;
      // controllers['country_controller']?.text=SharedPreferencesManager.getString('country')!;
      // controllers['address_controller']?.text=SharedPreferencesManager.getString('address')!;
      // gender=SharedPreferencesManager.getString('gender');

    }
  }
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
              image: AssetImage("            assets/images/background.png"),
              fit: BoxFit.fitWidth,
            ),
          ),
          child:SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 20.h,),
                Text("Your Profile",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 200.sp),
                  width: 40.w,
                  height: 2.h,
                ),
                SizedBox(height: 20.h,),
                Container(
                  height: 440.h,
                  child: ListView.separated(
                      itemBuilder: (context,index)=> buildTextFormFieldProfileScreen(
                          controllers[controllers.entries.elementAt(index).key]!, hintTexts[index]),
                      separatorBuilder: (context,index)=> SizedBox(height: 10.h,),
                      itemCount: controllers.length),
                ),
                SizedBox(height: 20.h,),
                buildGenderCheckBox(gender!, (value) {}),
                Text(
                  textAlign: TextAlign.start,
                  'Your Security Information',style: TextStyle(color: Colors.white,fontSize: 24.sp),),
                Text('Password',style: TextStyle(color: Colors.white),),
                buildTextFormFieldProfileScreen(password_controller, " "),
                Text('Confirm Password',style: TextStyle(color: Colors.white),),
                buildTextFormFieldProfileScreen(confirm_password_controller, " ")

              ],
            ),
          )

      ),
    );
  }
}
