import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 5,
    backgroundColor: Color(0xff157A82),
    textColor: Colors.black,
    fontSize: 16.0,
  );
}



Widget buildTextFormFieldProfileScreen(TextEditingController controller,String hintText )
{
 return Container(
   decoration: BoxDecoration(
     border: Border.all(color: Colors.white,width: 2.sp,),
     borderRadius: BorderRadius.circular(25.sp),

   ),
   child: TextFormField(
     decoration: InputDecoration(
       contentPadding: EdgeInsets.only(left: 10.sp),
       hintText: hintText,
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
      Text('Gender', style: TextStyle(color: Colors.white,fontSize: 20.sp,)),
      SizedBox(width: 60.w,),
      Radio(
        activeColor: Color(0xff14676D),
        value: 'male',
        groupValue: gender,
        onChanged: onChange
      ),
      Text('Male',style: TextStyle(color: Colors.white),),
      SizedBox(width: 70.w,),
      Radio(
        activeColor: Color(0xff14676D),
        value: 'female',
        groupValue: gender,
        onChanged: onChange
      ),
      Text('Female',style: TextStyle(color: Colors.white),),

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
          height: 150.h,
          width: 150.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                10.sp),
            color: Colors.grey,
          ),
          child: Column(
            children: [
              imageApi== null?Image.asset('assets/images/temp.png'): Image.network(
                imageApi,
                // Replace with the path to your second image
                width: 200.0.w,
                // Adjust the width as needed
                height: 170.h, // Adjust the height as needed
              ),
              Container(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      color: Color(0xff3A78A4),
                      fontSize: 20.sp
                  ),
                ),
              )
            ],
          )

        // Second Image

      ),
    ),
  );
}
