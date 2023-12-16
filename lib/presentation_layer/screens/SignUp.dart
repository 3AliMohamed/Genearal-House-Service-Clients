import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/register/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/register/states.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';

import '../../component/Colors.dart';

import 'package:get/get.dart';
class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  String? selectedCountry;

  List<String> countries = [
    'Country A',
    'Country B',
    'Country C',
    // add more country names as needed
  ];


  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerPasswordTwo = TextEditingController();
  TextEditingController _name_controller=TextEditingController();
  TextEditingController _email_controller=TextEditingController();
  TextEditingController _phone_controller=TextEditingController();
  TextEditingController _age_controller=TextEditingController();
  TextEditingController _address_controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: ScreenUtil().screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Artboard 2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo2psd.png',
              ),
              TextFormField(
                controller: _name_controller,
                keyboardType: TextInputType.text,
                style: TextStyle(color: userAndPassword),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:colorBorder),
                  ),
                  focusedBorder:UnderlineInputBorder(
                    borderSide: BorderSide(color:colorBorder),
                  ) ,
                  hintText: tr('user name'),
                  hintStyle: TextStyle(color: userAndPassword,fontSize: 30.sp,),
                  prefixIcon:Image.asset('assets/images/user (2).png',

                  ),
                ),
              ),
              SizedBox(height:10.h,),
              TextFormField(
                controller:_phone_controller ,
                keyboardType: TextInputType.phone,
                style: TextStyle(color: userAndPassword),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:colorBorder),
                  ),
                  focusedBorder:UnderlineInputBorder(
                    borderSide: BorderSide(color:colorBorder),
                  ) ,
                  hintText: tr('Phone'),
                  hintStyle: TextStyle(color: userAndPassword,fontSize: 30.sp,),
                  prefixIcon:Image.asset('assets/images/user (2).png',

                  ),
                ),
              ),
              SizedBox(height:10.h,),
              TextFormField(
                controller: _address_controller ,
                keyboardType: TextInputType.streetAddress,
                style: TextStyle(color: userAndPassword),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:colorBorder),
                  ),
                  focusedBorder:UnderlineInputBorder(
                    borderSide: BorderSide(color:colorBorder),
                  ) ,
                  hintText: tr('Address'),
                  hintStyle: TextStyle(color: userAndPassword,fontSize: 30.sp,),
                  prefixIcon:Image.asset('assets/images/user (2).png',

                  ),
                ),
              ),
              SizedBox(height:10.h,),
              TextFormField(
                controller: _age_controller,
                keyboardType: TextInputType.number,
                style: TextStyle(color: userAndPassword),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:colorBorder),
                  ),
                  focusedBorder:UnderlineInputBorder(
                    borderSide: BorderSide(color:colorBorder),
                  ) ,
                  hintText: tr('Age'),
                  hintStyle: TextStyle(color: userAndPassword,fontSize: 30.sp,),
                  prefixIcon:Image.asset('assets/images/user (2).png',

                  ),
                ),
              ),

              // SizedBox(height:MediaQuery.of(context).size.height*0.03,),
              SizedBox(height:10.h,),
              TextFormField(
                controller: _email_controller,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: userAndPassword),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:colorBorder),
                  ),
                  focusedBorder:UnderlineInputBorder(
                    borderSide: BorderSide(color:colorBorder),
                  ) ,
                  hintText: tr('Email Address'),
                  hintStyle: TextStyle(color: userAndPassword,fontSize: 30.sp,),
                  prefixIcon:Image.asset('assets/images/email.png',
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
             BlocBuilder<RegisterCubit,RegisterStates>(
               builder: (context,state){
                 return  TextFormField(
                   controller: _controllerPassword,
                   keyboardType: TextInputType.text,
                   obscureText: RegisterCubit.get(context).passwordVisible_signup,
                   style: TextStyle(color: userAndPassword),
                   decoration: InputDecoration(
                     suffixIcon: IconButton(
                       icon: Icon(
                         size: 30.sp,
                         RegisterCubit.get(context).passwordVisible_signup
                             ? Icons.visibility_off
                             : Icons.visibility,),
                       onPressed: () {
                         RegisterCubit.get(context).changePasswordVisibilitySingUp();
                       }
                     ),
                     enabledBorder: UnderlineInputBorder(
                       borderSide: BorderSide(color:colorBorder),
                     ),
                     focusedBorder:UnderlineInputBorder(
                       borderSide: BorderSide(color:colorBorder),
                     ) ,
                     hintText: tr('Password'),
                     hintStyle: TextStyle(color: userAndPassword,fontSize:  30.sp,),
                     prefixIcon:Image.asset('assets/images/padlock (2).png',
                       // height: MediaQuery.of(context).size.height*0.09,
                       // width:MediaQuery.of(context).size.width*0.09,
                     ),
                   ),
                 );
               } ,
             ),
              SizedBox(height: 10.h,),
             BlocBuilder<RegisterCubit,RegisterStates>(
               builder: (context,state){
                 return  TextFormField(
                   controller: _controllerPasswordTwo,
                   keyboardType: TextInputType.text,
                   obscureText: RegisterCubit.get(context).passwordVisibleTwo_signup,
                   style: TextStyle(color: userAndPassword),
                   decoration: InputDecoration(
                     suffixIcon: IconButton(
                       icon: Icon(
                         size: 30.sp,
                         RegisterCubit.get(context).passwordVisibleTwo_signup
                             ? Icons.visibility_off
                             : Icons.visibility,),
                       onPressed: () {
                         RegisterCubit.get(context).changeConfirmPasswordVisibilitySingUp();
                       }
                     ),
                     enabledBorder: UnderlineInputBorder(
                       borderSide: BorderSide(color:colorBorder),
                     ),
                     focusedBorder:UnderlineInputBorder(
                       borderSide: BorderSide(color:colorBorder),
                     ) ,
                     hintText: tr('Confirm Password'),
                     hintStyle: TextStyle(color: userAndPassword,fontSize: 30.sp,),
                     prefixIcon:Image.asset('assets/images/Component 1 – 1.png',
                       // height: MediaQuery.of(context).size.height*0.09,
                       // width:MediaQuery.of(context).size.width*0.09,
                     ),
                   ),
                 );
               },
             ),
              SizedBox(height:MediaQuery.of(context).size.height*0.02,),
              DropdownButtonFormField<String>(
                key:GlobalKey<FormFieldState>(),
              isExpanded: true,
                hint:
                SizedBox(
                  width: double.infinity,
                  // height:45.h,
                  // height:MediaQuery.of(context).size.height*0.5 ,
                  child:
                  Text(tr('Select a country'),style:TextStyle(color: userAndPassword,fontSize: 30.sp,),),
                ),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:colorBorder),
                  ),
                  focusedBorder:UnderlineInputBorder(
                    borderSide: BorderSide(color:colorBorder),
                  ) ,
                  prefixIcon:Image.asset('assets/images/country (1).png',
                  ) ,
                ),
              style: TextStyle(fontSize: 30.sp,color: userAndPassword,),
              value: selectedCountry,
              items: countries.map((country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCountry = value;
                });
              },
            ),
              // SizedBox(height:MediaQuery.of(context).size.height*0.02,),
              SizedBox(height:8.h,),
              BlocBuilder<RegisterCubit,RegisterStates>(
                builder: (context,state){
                  return Row(
                    children: [
                      SizedBox(width: 15.w,),
                      Text('Gender', style: TextStyle(color: Colors.white,fontSize: 20.sp,)),
                      SizedBox(width: 20.w,),
                      Radio(
                        activeColor: Color(0xff14676D),
                        value: 'male',
                        groupValue: RegisterCubit.get(context).gender,
                        onChanged: (value) {
                          RegisterCubit.get(context).changeGender(value.toString());
                        },
                      ),
                      Text('Male',style: TextStyle(color: Colors.white),),
                      SizedBox(width: 70.w,),
                      Radio(
                        activeColor: Color(0xff14676D),
                        value: 'female',
                        groupValue: RegisterCubit.get(context).gender,
                        onChanged: (value) {
                         RegisterCubit.get(context).changeGender(value.toString());
                        },
                      ),
                      Text('Female',style: TextStyle(color: Colors.white),),

                    ],
                  );
                },
              ),
              BlocListener<RegisterCubit,RegisterStates>
                (listener: (context,state)
                    {
                      if (state is RegisterErrorState){
                        log(state.error);
                        showToast(state.error);
                      };
                      if(state is RegisterSuccessState){
                        Navigator.of(context).pushNamed('/login');
                      }
                    },
                child:SizedBox(
                  width:300.w, //MediaQuery.of(context).size.width*0.8,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all(Color(0xFF00729D),) ,
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: buttonSignIn)
                            )
                        )
                    ),
                    onPressed: () {
                      RegisterCubit.get(context).register(_email_controller.text,
                          _controllerPassword.text,
                          _name_controller.text,
                          _phone_controller.text,
                          _age_controller.text,
                          _address_controller.text,
                          RegisterCubit.get(context).gender,
                          '19');
                    },
                    child: Text('Signup',style: TextStyle(fontSize: 30.sp, color: Colors.white)).tr(),
                  ),
                ),
                ),
              SizedBox(height:4.h,),
              // SizedBox(height:MediaQuery.of(context).size.height*0.01,),
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    SizedBox(width:22.w),
                    // SizedBox(width:MediaQuery.of(context).size.width*0.07,),
                    Text(
                    // '${ anasHere.counter}',
                        Trans('already have an account ?').tr,
                        style: TextStyle(color: userAndPassword,)

                    ),
                    SizedBox(width:8.w,),
                    // SizedBox(width:MediaQuery.of(context).size.width*0.03,),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed('/login');
                      },
                      child: Text(
                          Trans('Signin').tr,
                          style: TextStyle(color: Colors.white,)

                      ),
                    ),

                    // IconButton(onPressed: (){   // for testing provider between two screens
                    //   anasHere.inc();
                    //
                    // }, icon: Icon(Icons.add,color: Colors.red),),
                    //
                  ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
