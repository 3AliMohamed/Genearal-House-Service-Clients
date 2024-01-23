import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';
import 'package:get/get.dart';
import '../../business_logic_layer/cubit/authentication/login_cubit/cubit.dart';
import '../../business_logic_layer/cubit/authentication/login_cubit/states.dart';
import '../../component/Colors.dart';
import 'SignUp.dart';


class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _password_controller = TextEditingController();

  TextEditingController _email_controller = TextEditingController();

  @override

  // object from authentication cubit
  // CounterCubit _counterCubit = CounterCubit(); needed with a stateful widget
  // kolo 3la allah
  // cubit
  // stateful and take object from cubit

  // fucntion dispose(name of variable to close it to for )
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: ScreenUtil().screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Artboard 2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo2psd.png',
            ),
            TextFormField(
              controller: _email_controller,
              keyboardType: TextInputType.text,
              style: TextStyle(color: userAndPassword),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorBorder),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorBorder),
                ),
                hintText: Trans('Email').tr,
                hintStyle: TextStyle(
                  color: userAndPassword,
                  fontSize: 30.sp,
                ),
                prefixIcon: Image.asset(
                  'assets/images/user (2).png',
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            BlocBuilder<LogInCubit, LogInStates>(
              builder: (context, state) {
                return TextFormField(
                  controller: _password_controller,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: !LogInCubit.get(context).passwordVisible,
                  style: TextStyle(color: userAndPassword),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        size: 30.sp,
                        LogInCubit.get(context).passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        LogInCubit.get(context)
                            .changePasswordVissibilty();
                      },
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colorBorder),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colorBorder),
                    ),
                    hintText: Trans('Password').tr,
                    hintStyle: TextStyle(
                      color: userAndPassword,
                      fontSize: 30.sp,
                    ),
                    prefixIcon: Image.asset(
                      'assets/images/padlock (2).png',
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/forget_password');
                  },
                  child: Text(
                    Trans('forget your password?').tr,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            BlocListener<LogInCubit,LogInStates>(
              listener: (context,state)
              {
                if (state is LoginErrorState) {
                 showToast(state.error);
                };
                if(state is LoginSuccessState){
                  Navigator.of(context).pushNamed('/home');
                }
              },
              child: SizedBox(
                width: 300.w,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color(0xFF00729D),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: buttonSignIn)),
                    ),
                  ),
                  onPressed: () {

                    LogInCubit.get(context)
                        .login(_email_controller.text, _password_controller.text);
                  },
                  child: Text(
                    Trans('Login').tr,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            // SizedBox(height:MediaQuery.of(context).size.height*0.05,),
            SizedBox(height: 25.h),
            Row(children: [
              SizedBox(
                width: 10.w,
              ),
              Text(Trans('don\'t have an account ?').tr,
                  style: TextStyle(
                    color: userAndPassword,
                  )),
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ),
                  );
                },
                child: Text(Trans('Signup').tr,
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
