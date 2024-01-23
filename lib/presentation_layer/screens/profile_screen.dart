import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/get_profile/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/get_profile/states.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/update_profile/cubit.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';
import 'package:get/get.dart';

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
    'country_controller': TextEditingController(),
  };

  List<String> hintTexts=[
    'Full Name',
    'Phone Number',
    'Email',
    'Age',
    'Country',
    'Address',
  ];
List<String> prefixIcons=
[
  'assets/images/user.png',
  'assets/images/phone.png',
  'assets/images/email 2.png',
  'assets/images/country.png',
  'assets/images/password.png',
  'assets/images/confirm password.png',


];
  Map<String,String> locationType={
    'apartment': 'assets/images/apartment_logo.png',
    'home' : 'assets/images/home.png',
    'office':'assets/images/office_white.png',
    'other':''
  };
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

      controllers['country_controller']?.text=SharedPreferencesManager.getString('country')!;
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

               else if (SharedPreferencesManager.getString('country')!=state.response.data?[0].countryId.toString())
              {
                SharedPreferencesManager.setString('country', state.response.data?[0].countryId.toString());
                controllers['country_controller']?.text=SharedPreferencesManager.getString('country')!;
              }

            }
          else if(state is GetProfileDataErrorState)
            {
              log(state.error.toString());
              showToast(state.error.toString());
            }
        },
        builder: (context,state){
          if(state is InitialState || state is Loading){
            ProfileCubit.get(context).getProfileData();
            return  SpinKitFadingCube(
              color: Color(0xffB4AFAF),
              size: 50.0,
            );     }
          else
            {
              return  Scaffold(
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
                  child:SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(height: 20.h,),
                        Text(Trans("Your Profile").tr,
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
                          height: 270.h,
                          child: ListView.separated(
                              itemBuilder: (context,index)=> buildTextFormFieldProfileScreen(
                                  controllers[controllers.entries.elementAt(index).key]!, hintTexts[index],prefixIcons[index]),
                              separatorBuilder: (context,index)=> SizedBox(height: 10.h,),
                              itemCount: controllers.length),
                        ),
                        SizedBox(
                          height: 200.h,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: ProfileCubit.get(context).clientLocationsMap[0]?.length,
                            itemBuilder: (context, index)
                            {
                              log(ProfileCubit.get(context).clientLocationsMap[0]![index].locationType.toString());
                              return InkWell(
                                onTap: (){
                                  // setState(() {
                                  //   isTaped=!isTaped;
                                  //   chosenAddress={'id':'${GetAddressCubit.get(context).addressResponse![index].id.toString()}' ,
                                  //     'locationType':'${GetAddressCubit.get(context).addressResponse![index].locationType!}',
                                  //     'detailedAddress':'${GetAddressCubit.get(context).addressResponse![index].detailedAddress!}'
                                  //   };
                                  // });
                                },
                                // hoverColor: Colors.red,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 5.sp,top: 10.sp,right: 5.sp,left: 5.sp),
                                  padding: EdgeInsets.all(5.sp),
                                  decoration: BoxDecoration(
                                    color: Colors.white ,
                                    borderRadius: BorderRadius.circular(5.sp),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [

                                              Image.asset(locationType[ProfileCubit.get(context).clientLocationsMap[0]![index].locationType.toString()]!,width: 50.w,height: 50.h,),
                                              Text(ProfileCubit.get(context).clientLocationsMap[0]![index].locationType!)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Edit"),
                                              Icon(
                                                  Icons.edit
                                              )
                                            ],
                                          )
                                        ],
                                      ) ,
                                      Divider(color: Colors.black,),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Address"),
                                            Text(ProfileCubit.get(context).clientLocationsMap[0]![index].detailedAddress!,
                                              style: TextStyle(fontSize: 15.sp),
                                            )
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              );
                            } ,
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        buildGenderCheckBox(gender!, (value) {}),
                        Text(
                          textAlign: TextAlign.start,
                          Trans('Your Security Information').tr,style: TextStyle(color: Colors.white,fontSize: 24.sp),),
                        Text(Trans('Password').tr,style: TextStyle(color: Colors.white),),
                        buildTextFormFieldProfileScreen(password_controller, " ",prefixIcons[4]),
                        Text(Trans('Confirm Password').tr,style: TextStyle(color: Colors.white),),
                        buildTextFormFieldProfileScreen(confirm_password_controller, " ",prefixIcons[5]),
                        InkWell(
                          onTap: (){

                            if(password_controller.text!=confirm_password_controller.text)
                            {
                              showToast(Trans("Please check password").tr);
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
                            child: Text(Trans('Update').tr,
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
        }
    );
  }
}
