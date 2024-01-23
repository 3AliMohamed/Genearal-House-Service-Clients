import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../component/Colors.dart';
import 'package:get/get.dart';
class Verificationcode extends StatefulWidget {
  @override
  State<Verificationcode> createState() => _VerificationcodeState();
}

class _VerificationcodeState extends State<Verificationcode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //   appBar:  AppBar(
      // systemOverlayStyle: SystemUiOverlayStyle(
      // statusBarBrightness: Brightness.dark,
      //     statusBarColor: Colors.dart.black,
      //     systemNavigationBarColor: Colors.dart.black
      // ),
      // title: Center(child: Text('Login')),
      // shape: RoundedRectangleBorder(
      // borderRadius: BorderRadius.vertical(
      // bottom: Radius.circular(20),
      // ),
      // ),
      // // backgroundColor: homePage,
      //
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
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
            SizedBox(height: MediaQuery.of(context).size.height*0.04),
            Image.asset('assets/images/logo2psd.png',
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.08),
            TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(color: userAndPassword),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color:colorBorder),
                ),
                focusedBorder:UnderlineInputBorder(
                  borderSide: BorderSide(color:colorBorder),
                ) ,
                hintText: Trans('Enter Verification Code').tr,
                hintStyle: TextStyle(color: userAndPassword,fontSize: 30.sp,),
                prefixIcon:Image.asset('assets/images/user (3).png',
                  // height: MediaQuery.of(context).size.height*0.09,
                  // width:MediaQuery.of(context).size.width*0.09,
                ),

              ),
            ),
            SizedBox(height:MediaQuery.of(context).size.height*0.04,),

            SizedBox(
              width: MediaQuery.of(context).size.width*0.8,
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
                onPressed: () {},
                child: Text(Trans('Next Step').tr,style: TextStyle(fontSize: 30,color: Colors.white)),
              ),
            ),
            Spacer(),



          ],
        ),
      ),
    );
  }
}
