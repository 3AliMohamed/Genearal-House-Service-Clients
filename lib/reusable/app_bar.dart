import 'dart:math';

import 'package:flutter/material.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onUserIconPressed;
  final VoidCallback onLoginPressed;
  bool? is_login=false;

  // String? user_name=SharedPreferencesManager.getString('name') ?? " mhssf";
 var user_name=" ";
  CustomAppBar({
    required this.onUserIconPressed,
    required this.onLoginPressed,
  });
  @override
  Widget build(BuildContext context) {
    if(SharedPreferencesManager.containKey('is_login')==true && SharedPreferencesManager.getBool('is_login')==true)
    {
      is_login=true;
    }
    if(SharedPreferencesManager.containKey('name')==true)
      {
       user_name=SharedPreferencesManager.getString('name')!;
      }
    return AppBar(
      actions: [
        IconButton(
          icon: Image.asset('assets/images/user.png'),
          onPressed: onUserIconPressed,
        ),
        TextButton(
          onPressed: onLoginPressed,
          child: Text(
            is_login != null && is_login! ?"Hello $user_name" : "Login" ,
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/appbar.png"),
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
