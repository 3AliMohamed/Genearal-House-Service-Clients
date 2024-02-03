import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 10,
    backgroundColor: Color(0xff157A82),
    textColor: Colors.black,
    fontSize: 16.0,
  );
}



Widget buildTextFormFieldProfileScreen(TextEditingController controller,String hintText,String icon )
{
 return Container(
   decoration: BoxDecoration(
       boxShadow: [
         BoxShadow(
           color: Colors.white,
         ),
         BoxShadow(
           color: Color.fromRGBO(0,0, 0, 0.9),
           spreadRadius: -1,
           blurRadius: 5,
           offset: Offset(0,0),
           // blurStyle: BlurStyle.solid
         )
       ],
     // border: Border.all(color: Colors.white,width: 2.sp,),
     borderRadius: BorderRadius.circular(5.sp),

   ),
   child: TextFormField(
     decoration: InputDecoration(
         prefixIcon: new Padding(
           padding: const EdgeInsets.only( top: 15, left: 5, right: 0, bottom: 15),
           child: new SizedBox(
             height: 4,
             child: Image.asset(icon),
           ),
         ),
       contentPadding: EdgeInsets.only(left: 10.sp,top: 10.sp),
       hintText: Trans(hintText).tr,
       hintStyle: TextStyle(color: Colors.grey),
     ),
     // textAlign: TextAlign.center,
     controller: controller,
     style: TextStyle(color: Colors.white),
     // onChanged: (value) => ,

   ),
 );

}

Widget buildGenderCheckBox(String gender, ValueSetter<String?> onChange)
{
  return Row(
    children: [
      SizedBox(width: 15.w,),
      Text(Trans('Gender').tr, style: TextStyle(color: Colors.white,fontSize: 20.sp,)),
      SizedBox(width: 60.w,),
      Radio(
        activeColor: Color(0xff14676D),
        value: Trans('male').tr,
        groupValue: gender,
        onChanged: onChange
      ),
      Text(Trans('Male').tr,style: TextStyle(color: Colors.white),),
      SizedBox(width: 70.w,),
      Radio(
        activeColor: Color(0xff14676D),
        value: Trans('female').tr,
        groupValue: gender,
        onChanged: onChange
      ),
      Text(Trans('Female').tr,style: TextStyle(color: Colors.white),),

    ],
  );
}

Widget buildCategoryItem(String imgPath ,String label,void Function() onTapp)
{
  String imageApi="https://dev.generalhouseservices.com/";
  imageApi= imageApi + imgPath;
  return InkWell(
    onTap: onTapp,
    child: Padding(
      padding: EdgeInsets.all(8.sp),
      child: Container(
          height: 200.h,
          width: 200.w,
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(
                30.sp),
            // color: Colors.white,
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              imageApi != null?
                Container(

                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff0083F7),
                      ),
                      BoxShadow(
                        color: Color.fromRGBO(0,0, 0, 0.9),
                        spreadRadius: -1,
                        blurRadius: 20,
                        offset: Offset(0,0),
                        // blurStyle: BlurStyle.solid
                      )
                    ],
                    borderRadius: BorderRadius.circular(30.sp),
                  ),
                  child: Image.network(

                    imageApi,
                    width: double.infinity, // Image takes full width
                    fit: BoxFit.cover, // Adjusts the image content mode
                    height: 195.h,
                  ),
                )
              :
                Image.asset(
                  'assets/images/temp.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 150.h,
                ),
              Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.sp),
                  // color: Color(0xff06083D), // Background color for text
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff0083F7),
                    ),
                    BoxShadow(
                      color: Color(0xff06083D),
                      spreadRadius: -3,
                      blurRadius: 20,
                      offset: Offset(0,5),
                      // blurStyle: BlurStyle.solid
                    )
                  ],
                ),
                padding: EdgeInsets.all(8.sp),
                child: Text(
                  textAlign: TextAlign.center,
                  Trans(label).tr,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23.sp,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),

        // Second Image

      ),
    ),
  );
}
