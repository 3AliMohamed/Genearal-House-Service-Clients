import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/get_profile/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/get_profile/states.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/update_profile/cubit.dart';
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
  // TextEditingController name_controller = TextEditingController();
  // TextEditingController phone_controller = TextEditingController();
  // TextEditingController email_controller = TextEditingController();
  // TextEditingController age_controller = TextEditingController();
  // TextEditingController country_controller = TextEditingController();
  // TextEditingController address_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController confirm_password_controller = TextEditingController();
  Map<String,TextEditingController> controllers= {
    'name_controller': TextEditingController(),
    'phone_controller': TextEditingController(),
    'email_controller': TextEditingController(),
    'age_controller': TextEditingController(),
    'country_controller': TextEditingController(),
    'address_controller': TextEditingController(),
  };
  List<String> hintTexts=[
    'Full Name',
    'Phone Number',
    'Email',
    'Age',
    'Country',
    'Address',
  ];
  List<String> keys=[
    'name',
    'phone',
    'email',
    'age',
    'country',
    'address',
  ];
  String? gender='female';
  @override
  void initState(){

    super.initState() ;
    ProfileCubit.get(context).getProfileData();
    // name_controller.text= SharedPreferencesManager.getString('name')!;
    if(SharedPreferencesManager.containKey('token')==true)
    {
      controllers['name_controller']?.text=SharedPreferencesManager.getString('name')!;
      controllers['phone_controller']?.text=SharedPreferencesManager.getString('phone')!;
      controllers['email_controller']?.text=SharedPreferencesManager.getString('email')!;
      controllers['age_controller']?.text=SharedPreferencesManager.getString('age')!;
      controllers['country_controller']?.text=SharedPreferencesManager.getString('country')!;
      controllers['address_controller']?.text=SharedPreferencesManager.getString('address')!;
      gender=SharedPreferencesManager.getString('gender');
      log(controllers[controllers.entries.elementAt(0).value].toString());
      log(SharedPreferencesManager.getString('name').toString());
      // log("name :"+controllers['name_controller']!.text.toString());
    }
  }
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit,ProfileStates>(
        listener: (context,state){
          if (state is GetProfileDataSuccessState)
            {
              log("here ");
              if(SharedPreferencesManager.getString('name')!=state.response.data?[0].name)
                {
                  SharedPreferencesManager.setString('name', state.response.data?[0].name.toString());
                  controllers['name_controller']?.text=SharedPreferencesManager.getString('name')!;
                }
              else if (SharedPreferencesManager.getString('phone')!=state.response.data?[0].phone)
              {
                SharedPreferencesManager.setString('phone', state.response.data?[0].phone.toString());
                controllers['phone_controller']?.text=SharedPreferencesManager.getString('phone')!;
              }
              else if (SharedPreferencesManager.getString('email')!=state.response.data?[0].email)
              {
                SharedPreferencesManager.setString('email', state.response.data?[0].email.toString());
                controllers['email_controller']?.text=SharedPreferencesManager.getString('email')!;
              }
              else if (SharedPreferencesManager.getString('age')!=state.response.data?[0].age.toString())
              {
                SharedPreferencesManager.setString('age', state.response.data?[0].age.toString());
                controllers['age_controller']?.text=SharedPreferencesManager.getString('age')!;
              }
               else if (SharedPreferencesManager.getString('country')!=state.response.data?[0].countryId.toString())
              {
                SharedPreferencesManager.setString('country', state.response.data?[0].countryId.toString());
                controllers['country_controller']?.text=SharedPreferencesManager.getString('country')!;
              }
               else if (SharedPreferencesManager.getString('address')!=state.response.data?[0].address.toString())
              {
                SharedPreferencesManager.setString('address', state.response.data?[0].address.toString());
                controllers['address_controller']?.text=SharedPreferencesManager.getString('address')!;
              }

            }
          else if(state is GetProfileDataErrorState)
            {
              log(state.error.toString());
              showToast(state.error.toString());
            }
        },
        builder: (context,state){
          return  Scaffold(
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
                child:SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(height: 20.h,),
                      Text("Your Profile",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ).tr(),
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
                        'Your Security Information',style: TextStyle(color: Colors.white,fontSize: 24.sp),).tr(),
                      Text('Password',style: TextStyle(color: Colors.white),).tr(),
                      buildTextFormFieldProfileScreen(password_controller, " "),
                      Text('Confirm Password',style: TextStyle(color: Colors.white),).tr(),
                      buildTextFormFieldProfileScreen(confirm_password_controller, " "),
                      InkWell(
                        onTap: (){

                          if(password_controller.text!=confirm_password_controller.text)
                          {
                            showToast("Please check password");
                          }
                          else{
                            UpdateProfileCubit.get(context).updateProfile(controllers['name_controller']!.text,
                                controllers['phone_controller']!.text,gender!,
                                controllers['email_controller']!.text,controllers['age_controller']!.text,
                                controllers['country_controller']!.text,controllers['address_controller']!.text,
                                password_controller.text
                            );
                          }

                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10.sp,top: 10.sp),
                          padding: EdgeInsets.all(1.sp),
                          width: 300.w,
                          height: 37.h,
                          decoration:  BoxDecoration(
                            color: Color(0xff157A82),
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Text('Update',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )

            ),
          );
        }
    );
  }
}
