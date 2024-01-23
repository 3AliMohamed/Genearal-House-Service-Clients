import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:get/get.dart';

import '../presentation_layer/widgets/reusable_widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // final VoidCallback onUserIconPressed;
  // final VoidCallback onLoginPressed;
  bool? is_login=false;

  // String? user_name=SharedPreferencesManager.getString('name') ?? " mhssf";
 var user_name=" ";
 var firstName=" ";
  @override
  Widget build(BuildContext context) {
    if(SharedPreferencesManager.containKey('is_login')==true && SharedPreferencesManager.getBool('is_login')==true)
    {
      is_login=true;
    }
    if(SharedPreferencesManager.containKey('name')==true)
      {
       user_name=SharedPreferencesManager.getString('name')!;
       firstName = user_name.trim().split(' ')[0].toUpperCase();
      }
    return AppBar(
      actions: [
        IconButton(
          icon: Image.asset('assets/images/userAppBar.png',width: 40.w,height: 40.h,),
          onPressed:  (){
              if(SharedPreferencesManager.containKey('is_login')==true)
              {
                  Navigator.of(context).pushNamed('/drawer_screen');
              }
          else{
                showToast('You Should Log In First');
              }
          },
        ),
        TextButton(
          onPressed: () {
            if (SharedPreferencesManager.containKey('is_login')==false)
            {
              Navigator.of(context).pushNamed('/login');
            }else
            {
              if(SharedPreferencesManager.getBool('is_login')==true){Navigator.of(context).pushNamed('/profile');}
              else{Navigator.of(context).pushNamed('/login');}
            }
          },
          child: Text(
            is_login != null && is_login! ?Trans("Hello  ").tr +" "+firstName : Trans("Login").tr ,
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xff06083D),
              spreadRadius: -20,
              offset: Offset(0,6),
              blurRadius: 20,

            )
          ],
          image: DecorationImage(
            image: AssetImage("assets/images/appBar.png",) ,
            fit: BoxFit.cover,

          ),
        ),
      ),
      leading: Image.asset(
        'assets/images/logo.png',
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
