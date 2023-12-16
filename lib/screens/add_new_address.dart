import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../reusable/app_bar.dart';
import '../reusable/bottom_navigation_bar.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({Key? key}) : super(key: key);

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  TextEditingController phone_controller=TextEditingController();
  TextEditingController land_line_controller=TextEditingController();
  TextEditingController street_name_controller=TextEditingController();
  TextEditingController floor_controller=TextEditingController();
  TextEditingController building_controller=TextEditingController();
  TextEditingController apartment_num_controller=TextEditingController();
  TextEditingController detailed_address_controller=TextEditingController();
  TextEditingController additional_instruction_controller=TextEditingController();


  bool is_appartment_Tapped=false;
  bool is_home_Tapped=false;
  bool is_office_Tapped=false;
  bool is_other_Tapped=false;
  String chosen_delivery_address='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: AppCubit.get(context).buildBottomNavItems(),
          onTap: (index) => AppCubit.get(context).navigateOnTab(context, index),
          currentIndex: AppCubit.get(context).selectedTap,
          selectedFontSize: 10.sp,
          unselectedFontSize: 10.sp,
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: Colors.blueGrey,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0XFF202020),
        ),
        appBar: CustomAppBar(
          onUserIconPressed: () {
            Navigator.of(context).pushNamed('/drawer_screen');
          },
          onLoginPressed: () {
            Navigator.of(context).pushNamed('/login');
          },
        ),
        body: Container(
        height: ScreenUtil().screenHeight,
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/images/background.png"),
        fit: BoxFit.fitWidth,
            ),
          ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h,),
          Padding(
            padding:  EdgeInsets.all(6.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Contact Information :',
                style: TextStyle(color: Colors.white,fontSize: 20.sp),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed('/choose_from_map');
                  },
                  child: Text(
                    'Select Location From Map',
                  style: TextStyle(
                      fontSize: 17.sp,
                      decoration: TextDecoration.underline,
                      color: Color(0xff529DA5),
                      decorationColor: Color(0xff529DA5)
                  ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15.h,),
          Container(
            height: 50.h,
            padding: EdgeInsets.only(left: 5.sp,right: 5.sp),
            child: TextFormField(
              decoration: InputDecoration( 
                contentPadding: EdgeInsets.all(10.sp),
                hintText: 'Phone Number +20',
                fillColor: Colors.white,
                filled: true,
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5),),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide( color: Colors.grey.withOpacity(0.5))
                ),
              ),
              controller: phone_controller,
            ),
          )  ,
          SizedBox(height: 10.h,),
          Container(
            height: 50.h,
            padding: EdgeInsets.only(left: 5.sp,right: 5.sp),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.sp),
                hintText: 'Land Line',
                suffixText: '(optional)',
                fillColor: Colors.white,
                filled: true,
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5),),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.sp),
                    borderSide: BorderSide( color: Colors.grey.withOpacity(0.5))
                ),
              ),
              controller: land_line_controller,
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(15.sp),
            child: Text('Delivery Address',
            style: TextStyle(color: Colors.white,fontSize: 25.sp),
            ),
          ) ,
          Padding(
            padding:  EdgeInsets.all(8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){
                        setState(() {
                            is_appartment_Tapped=true;
                            chosen_delivery_address='appartment';
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 8.sp,top: 2.sp),
                    height: 75.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                        color:  is_appartment_Tapped?Color(0xff16636B): Colors.white.withOpacity(0.0),
                        borderRadius: BorderRadius.circular(10.sp)
                    ),
                    child: Stack(
                      children: [
                        Image.asset('assets/images/apartment_logo.png', width: 60.w,height: 60.h,),
                        Positioned(
                          bottom: 0.sp,
                            top: 52.sp,
                            child: Text('Apartment', style: TextStyle(color: Colors.white,fontSize: 10.sp),))
                      ],
                    ),
                  ),
                ),
      
                InkWell(
                  onTap: (){
                   setState(() {
                     is_home_Tapped=true;
                     chosen_delivery_address='home';
                   });
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 8.sp,top: 2.sp),
                    height: 78.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                        color:  is_home_Tapped?Color(0xff16636B): Colors.white.withOpacity(0.0),
                        borderRadius: BorderRadius.circular(10.sp)
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(right: 5.sp),
                          child: Image.asset('assets/images/home.png', width: 60.w,height: 60.h,),
                        ),
                        Positioned(
                          bottom: 0.sp,
                            top: 50.sp,
                            left: 10.sp,
                            child: Text('Home', style: TextStyle(color: Colors.white,fontSize: 13.sp),))
                      ],
                    ),
                  ),
                ),
      
                InkWell(
                  onTap: (){
                        setState(() {
                          is_office_Tapped=true;
                          chosen_delivery_address='office';
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 8.sp,top: 2.sp),
                    height: 78.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                        color:  is_office_Tapped?Color(0xff16636B): Colors.white.withOpacity(0.0),
                        borderRadius: BorderRadius.circular(10.sp)
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(right: 5.sp),
                          child: Image.asset('assets/images/office_white.png', width: 60.w,height: 60.h,),
                        ),
                        Positioned(
                          bottom: 0.sp,
                            top: 55.sp,
                            left: 10.sp,
                            child: Text('Office', style: TextStyle(color: Colors.white,fontSize: 13.sp),))
                      ],
                    ),
                  ),
                ),
      
                InkWell(
                  onTap: (){
                   setState(() {
                     is_other_Tapped=true;
                     chosen_delivery_address='other';
                   });
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 8.sp,top: 2.sp),
                    height: 78.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                        color:  is_other_Tapped?Color(0xff16636B): Colors.white.withOpacity(0.0),
                        borderRadius: BorderRadius.circular(10.sp)
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            bottom: 0.sp,
                            top: 55.sp,
                            left: 10.sp,
                            child: Text('Other', style: TextStyle(color: Colors.white,fontSize: 13.sp),))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50.h,
            padding: EdgeInsets.only(left: 5.sp,right: 5.sp),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.sp),
                hintText: 'Street Name',
                fillColor: Colors.white,
                filled: true,
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5),),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide( color: Colors.grey.withOpacity(0.5))
                ),
              ),
              controller: street_name_controller,
            ),
          ),
          SizedBox(height: 10.h,),
          Container(
            height: 50.h,
            padding: EdgeInsets.only(left: 5.sp,right: 5.sp),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.sp),
                hintText: 'Floor',
                fillColor: Colors.white,
                filled: true,
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5),),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide( color: Colors.grey.withOpacity(0.5))
                ),
              ),
              controller: floor_controller,
            ),
          ),
          SizedBox(height: 10.h,),
          Container(
            height: 50.h,
            padding: EdgeInsets.only(left: 5.sp,right: 5.sp),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.sp),
                hintText: 'Building',
                fillColor: Colors.white,
                filled: true,
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5),),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide( color: Colors.grey.withOpacity(0.5))
                ),
              ),
              controller: building_controller,
            ),
          ),
          SizedBox(height: 10.h,),
          Container(
            height: 50.h,
            padding: EdgeInsets.only(left: 5.sp,right: 5.sp),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.sp),
                hintText: 'Apartment Number',
                fillColor: Colors.white,
                filled: true,
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5),),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.sp),
                    borderSide: BorderSide( color: Colors.grey.withOpacity(0.5))
                ),
              ),
              controller: apartment_num_controller,
            ),
          ),
          SizedBox(height: 10.h,),
          Container(
            height: 50.h,
            padding: EdgeInsets.only(left: 5.sp,right: 5.sp),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.sp),
                hintText: 'Detailed Address',
                fillColor: Colors.white,
                filled: true,
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5),),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.sp),
                    borderSide: BorderSide( color: Colors.grey.withOpacity(0.5))
                ),
              ),
              controller: detailed_address_controller,
            ),
          ),
          SizedBox(height: 10.h,),
          Container(
            height: 50.h,
            padding: EdgeInsets.only(left: 5.sp,right: 5.sp),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.sp),
                hintText: 'Additional Instruction',
                fillColor: Colors.white,
                filled: true,
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5),),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.sp),
                    borderSide: BorderSide( color: Colors.grey.withOpacity(0.5))
                ),
              ),
              controller: additional_instruction_controller,
            ),
          ),
          InkWell(
            onTap: (){},
            child: Container(
              margin: EdgeInsets.only(top:50.sp,left: 110.sp),
              padding: EdgeInsets.all(1.sp),
              width: 230.w,
              height: 37.h,
              decoration:  BoxDecoration(
                color: Color(0xff157A82),
                borderRadius: BorderRadius.circular(5.sp),
              ),
              child: Text('Save Address',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    ) ,
    )
    );
  }
}
