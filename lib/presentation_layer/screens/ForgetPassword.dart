import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../component/Colors.dart';
import '../../screens/Verification.dart';
import 'package:get/get.dart';
class Forgetpassword extends StatefulWidget {
  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  @override
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
            SizedBox(height:100  .h,),
            Image.asset('assets/images/logo2psd.png',
            ),
            SizedBox(height: 15.h,),
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
                hintText: Trans('Email Address').tr,
                hintStyle: TextStyle(color: userAndPassword,fontSize: 30.sp,),
                prefixIcon:Image.asset('assets/images/mail.png',
                ),

              ),
            ),
            SizedBox(height:40.h,),
            SizedBox(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Verificationcode(),),
                  );
                },
                child: Text(Trans('Get Verification Code').tr,style: TextStyle(fontSize:30.sp,color: Colors.white)),
              ),
            ),
            Spacer(),

          ],
        ),
      ),
    );
  }
}
