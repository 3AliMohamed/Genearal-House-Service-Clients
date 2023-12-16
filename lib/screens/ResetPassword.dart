import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../component/Colors.dart';

class Resetpassword extends StatefulWidget {
  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            Image.asset('assets/images/logo2psd.png',
            ),
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
                hintText: '        New Password',
                hintStyle: TextStyle(color: userAndPassword,fontSize: 30,),
                prefixIcon:Image.asset('assets/images/padlock (2).png',
                  // height: MediaQuery.of(context).size.height*0.09,
                  // width:MediaQuery.of(context).size.width*0.09,
                ),

              ),
            ),
            SizedBox(height:MediaQuery.of(context).size.height*0.06,),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color:colorBorder),
                ),
                focusedBorder:UnderlineInputBorder(
                  borderSide: BorderSide(color:colorBorder),
                ) ,
                hintText: '        Confirm Password',
                hintStyle: TextStyle(color: userAndPassword,fontSize: 30),
                prefixIcon: Image.asset('assets/images/Component 1 – 1.png',
                  // height: MediaQuery.of(context).size.height*0.09,
                  // width:MediaQuery.of(context).size.width*0.09,
                  ),

              ),
            ),
            SizedBox(height:MediaQuery.of(context).size.height*0.03,),

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
                child: Text('Back To Login',style: TextStyle(fontSize: 30,)),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
