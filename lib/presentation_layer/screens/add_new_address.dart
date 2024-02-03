import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/add_address/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/add_address/states.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';
import 'package:get/get.dart';
import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../business_logic_layer/cubit/get_address/cubit.dart';
import '../../reusable/app_bar.dart';
import 'address.dart';
class AddNewAddress extends StatefulWidget {
   AddNewAddress({super.key,this.long,this.lat});
  double? long;
  double? lat;
  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {

  Map<String,TextEditingController> controllers= {
    'phone_controller': TextEditingController(),
    'land_line_controller': TextEditingController(),
    'street_name_controller': TextEditingController(),
    'floor_controller': TextEditingController(),
    'building_controller': TextEditingController(),
    'apartment_num_controller': TextEditingController(),
    'detailed_address_controller': TextEditingController(),
    'additional_instruction_controller': TextEditingController(),

  };
  Map<String,String> checkIsEmpty= {
    'phone_controller': 'Phone Number',
    'land_line_controller': 'LAnd Line',
    'street_name_controller': 'Street Name',
    'floor_controller': 'Floor',
    'building_controller': 'Building',
    'apartment_num_controller': 'Apartment',
    'detailed_address_controller': 'Detailed Address',
    'additional_instruction_controller': 'Additional Instruction',
  };
  List<String> hintTexts=[
    'Phone Number +20',
    'Land Line',
    'Street Name',
    'Floor',
    'Building',
    'Apartment Number',
    'Detailed Address',
    'Additional Instruction'
  ];
  void initState() {
    super.initState();
  }
  bool isTaped=false;

  String chosen_delivery_address='';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>AddAddressCubit(),
    child:BlocConsumer<AddAddressCubit,AddAddressStates>(
      listener: (context,state){
        if(state is AddedSuccessfullyState)
          {
            showToast('The Address Added Successfully');
          }
        else if(state is AddErrorState)
          {
            showToast(state.error);
          }
      },
      builder: (context,state){
        if( state is Loading)
          {return  SpinKitFadingCube(
            color: Color(0xffB4AFAF),
            size: 50.0,
          );}
        else{
               return Scaffold(
              bottomNavigationBar:Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff0083F7).withOpacity(0.8),
                      // spreadRadius: -20,
                    ),
                    BoxShadow(
                      color: Color(0xff06083D),
                      // Color(0xff06083D).withOpacity(0.9),
                      spreadRadius: -20,
                      blurRadius: 20,
                      offset: Offset(20, 10),
                      // blurStyle: BlurStyle.solid
                    )
                  ],
                ),
                child: PhysicalModel(
                  color: Color(0xff06083D).withOpacity(0.6),
                  elevation: 5.0, // Adjust the elevation as needed
                  // borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                  child: BottomNavigationBar(
                    items: AppCubit.get(context).buildBottomNavItems(),
                    onTap: (index) => AppCubit.get(context).navigateOnTab(context, index),
                    currentIndex: AppCubit.get(context).selectedTap,
                    selectedFontSize: 10.sp,
                    unselectedFontSize: 10.sp,
                    unselectedItemColor: Colors.blueGrey,
                    selectedItemColor: Colors.blueGrey,
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.transparent, // Set background color to transparent
                  ),
                ),
              ),
              appBar: CustomAppBar(),
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
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(
                        Icons.arrow_back_sharp,
                        color: Colors.white,
                      )),
                      Center(

                        child: Text('Add Another Location',
                        style: TextStyle(color: Colors.white,fontSize: 30.sp,
                            fontWeight: FontWeight.bold),),
                      ),
                      // SizedBox(height: 20.h,),
                      Padding(
                        padding: EdgeInsets.all(6.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Contact Information :',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.sp),
                            ),

                          ],
                        ),
                      ),

                      Container(
                        height: 135.h,
                        padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                        child: ListView.separated(
                            itemBuilder: (context, index) =>
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(color: Colors.white),
                                      BoxShadow(color: Colors.black.withOpacity(0.7,),
                                        blurRadius: 10,
                                        spreadRadius: -2,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(color: Colors.white),
                                      // Set the border color if needed
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      contentPadding: EdgeInsets.all(10.sp),
                                      hintText: hintTexts[index],
                                      fillColor: Colors.black.withOpacity(0.7),
                                      filled: true,
                                      hintStyle: TextStyle(
                                        color: Colors.grey,),
                                      border: OutlineInputBorder(
                                          // borderRadius: BorderRadius.circular(
                                          //     10.0),

                                      ),
                                    ),
                                    controller: controllers[controllers.entries.elementAt(index).key]!,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 7.h,),
                            itemCount: 2),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.sp),
                        child: Text('Delivery Address',
                          style: TextStyle(
                              color: Colors.white, fontSize: 25.sp),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isTaped = !isTaped;
                                  chosen_delivery_address = 'apartment';
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 8.sp, top: 2.sp),
                                height: 75.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                    color: chosen_delivery_address ==
                                        'apartment' ? Color(0xff06083D) : Colors
                                        .white.withOpacity(0.0),
                                    borderRadius: BorderRadius.circular(10.sp)
                                ),
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'assets/images/apartment_logo.png',
                                      width: 60.w, height: 60.h,),
                                    Positioned(
                                        bottom: 0.sp,
                                        top: 52.sp,
                                        child: Text('Apartment',
                                          style: TextStyle(color: Colors.white,
                                              fontSize: 10.sp),))
                                  ],
                                ),
                              ),
                            ),

                            InkWell(
                              onTap: () {
                                setState(() {
                                  isTaped = !isTaped;
                                  chosen_delivery_address = 'house';
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 8.sp, top: 2.sp),
                                height: 78.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                    color: chosen_delivery_address == 'house'
                                        ? Color(0xff06083D)
                                        : Colors.white.withOpacity(0.0),
                                    borderRadius: BorderRadius.circular(10.sp)
                                ),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 5.sp),
                                      child: Image.asset(
                                        'assets/images/home.png', width: 60.w,
                                        height: 60.h,),
                                    ),
                                    Positioned(
                                        bottom: 0.sp,
                                        top: 50.sp,
                                        left: 10.sp,
                                        child: Text('House', style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.sp),))
                                  ],
                                ),
                              ),
                            ),

                            InkWell(
                              onTap: () {
                                setState(() {
                                  isTaped = !isTaped;
                                  chosen_delivery_address = 'office';
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 8.sp, top: 2.sp),
                                height: 78.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                    color: chosen_delivery_address == 'office'
                                        ? Color(0xff06083D)
                                        : Colors.white.withOpacity(0.0),
                                    borderRadius: BorderRadius.circular(10.sp)
                                ),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 5.sp),
                                      child: Image.asset(
                                        'assets/images/office_white.png',
                                        width: 60.w, height: 60.h,),
                                    ),
                                    Positioned(
                                        bottom: 0.sp,
                                        top: 55.sp,
                                        left: 10.sp,
                                        child: Text('Office', style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.sp),))
                                  ],
                                ),
                              ),
                            ),

                            InkWell(
                              onTap: () {
                                setState(() {
                                  isTaped = !isTaped;
                                  chosen_delivery_address = 'other';
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 8.sp, top: 2.sp),
                                height: 78.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                    color: chosen_delivery_address == 'other'
                                        ? Color(0xff06083D)
                                        : Colors.white.withOpacity(0.0),
                                    borderRadius: BorderRadius.circular(10.sp)
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        bottom: 0.sp,
                                        top: 55.sp,
                                        left: 10.sp,
                                        child: Text('Other', style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.sp),))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 365.h,
                        padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            // Adjusting the index to start after the first two elements
                            int adjustedIndex = index + 2;

                            return Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(color: Colors.white),
                                  BoxShadow(color: Colors.black.withOpacity(0.7,),
                                    blurRadius: 10,
                                    spreadRadius: -2,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.white),
                                  // Set the border color if needed
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  contentPadding: EdgeInsets.all(10.sp),
                                  hintText: hintTexts[adjustedIndex],
                                  fillColor: Colors.black.withOpacity(0.7),
                                  filled: true,
                                  hintStyle: TextStyle(
                                      color: Colors.grey),
                                  border: OutlineInputBorder(
                                    // borderRadius: BorderRadius.circular(10.0),

                                  ),
                                ),
                                controller: controllers[controllers.entries.elementAt(adjustedIndex).key]!,
                                style: TextStyle(color: Colors.white), // Set the text color
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 5.h,),
                          itemCount: controllers.length -
                              2, // Adjusting the itemCount by adding 2
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          log(chosen_delivery_address);

                          controllers.forEach((key, controller) async {
                            if (controller.text.isEmpty) {
                              showToast(
                                  '${checkIsEmpty[key]} has an empty value');
                            }
                            else {
                              if(await AddAddressCubit.get(context).addAddress(
                                  controllers['phone_controller']!.text,
                                  controllers['land_line_controller']!.text,
                                  controllers['street_name_controller']!.text,
                                  controllers['floor_controller']!.text,
                                  controllers['building_controller']!.text,
                                  controllers['apartment_num_controller'] !.text,
                                  controllers['detailed_address_controller']!.text,
                                  controllers['additional_instruction_controller']!.text,
                                  chosen_delivery_address.toString(),
                                    widget.long!,widget.lat!)){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Address()));
                              }
                            }
                          }
                          );

                          // Navigator.pushNamed(context, '/address');
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5.sp,left: 100.sp),
                          padding: EdgeInsets.all(1.sp),
                          width: 230.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff0083F7),
                              ),
                              BoxShadow(
                                color: Color.fromRGBO(0,0, 0, 0.9),
                                spreadRadius: -3,
                                blurRadius: 10,
                                offset: Offset(5,5),
                                // blurStyle: BlurStyle.solid
                              )
                            ],
                            // color: Color(0xff157A82),
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
                ),
              )
          );
          }
      },
    ) ,
    );
  }
}
