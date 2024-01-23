import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';
import 'package:general_house_service_clients/presentation_layer/screens/checkout_screen.dart';

import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../business_logic_layer/cubit/get_address/cubit.dart';
import '../../business_logic_layer/cubit/get_address/states.dart';
import '../../reusable/app_bar.dart';
import '../../reusable/bottom_navigation_bar.dart';

class Address extends StatefulWidget {
   Address({Key? key,this.orderDetails,this.dataIndex,this.isShowed=true}) : super(key: key);
  dynamic orderDetails;
  int? dataIndex;
  bool isShowed=true;
  @override
  State<Address> createState() => _AddressState();
}
class _AddressState extends State<Address> {
  Map<String,String> locationType={
    'apartment': 'assets/images/apartment_logo.png',
    'home' : 'assets/images/home.png',
    'office':'assets/images/office_white.png',
    'other':''
  };
Map<String,dynamic> chosenAddress={
  'id':'',
  'locationType':'',
  'detailedAddress':''
};
  List<bool> checkedItems=[];
bool isTaped=false;
void initState(){
  super.initState();
  log("jhsdjashfjdh");

}
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (context)=> GetAddressCubit(),
    child: BlocConsumer<GetAddressCubit,GetAddressStates>(
      listener: (context,state){},
      builder: (context,state){
        if(state is InitialState || state is Loading){
          GetAddressCubit.get(context).getAddress();
          return  SpinKitFadingCube(
            color: Color(0xffB4AFAF),
            size: 50.0,
          );        }
        else
          {
            checkedItems = List.generate(GetAddressCubit.get(context).addressResponse!.length, (index) => false);
            return  Scaffold(
                bottomNavigationBar: Container(
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
                  // padding: EdgeInsets.only(top: 30.sp),
                  height: ScreenUtil().screenHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h,),
                        Container(
                          padding: EdgeInsets.only(right: 380.sp),
                          child: IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: Icon(
                            Icons.arrow_back_rounded,color: Colors.white,
                          )),
                        ),
                        Center(
                          child: Text(
                            'Locations',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25.sp),
                          ),
                        ),
                        SizedBox(
                          height: 550.h,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: GetAddressCubit.get(context).addressResponse?.length ,
                            itemBuilder: (context, index)
                            {
                              return InkWell(
                                onTap: (){
                                setState(() {
                                  isTaped=!isTaped;
                                  chosenAddress={'id':'${GetAddressCubit.get(context).addressResponse![index].id.toString()}' ,
                                    'locationType':'${GetAddressCubit.get(context).addressResponse![index].locationType!}',
                                    'detailedAddress':'${GetAddressCubit.get(context).addressResponse![index].detailedAddress!}'
                                  };
                                });
                                },
                                // hoverColor: Colors.red,
                                child: Container(
                                  height: 180.h,
                                  margin: EdgeInsets.only(bottom: 5.sp,top: 10.sp,right: 5.sp,left: 5.sp),
                                  padding: EdgeInsets.all(5.sp),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff0083F7),
                                      ),
                                      BoxShadow(
                                        color: Color.fromRGBO(0,0, 0, 0.9),
                                        spreadRadius: -1,
                                        blurRadius: 15,
                                        offset: Offset(0,0),
                                        // blurStyle: BlurStyle.solid
                                      )
                                    ],
                                    // color: isTaped ?Colors.white60 :Colors.grey ,
                                    borderRadius: BorderRadius.circular(5.sp),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [

                                              if(widget.isShowed)
                                                Checkbox(
                                                  key: UniqueKey(),
                                                  value:checkedItems[2],
                                                  activeColor: Colors.green,
                                                  onChanged: (value) {
                                                    log("checked: $value");
                                                    // GetAddressCubit.get(context).checked(
                                                    //   value,index);
                                                    setState(() {
                                                      checkedItems[index]=value!;
                                                      isTaped=value;
                                                    });
                                                    log("index"+index.toString());
                                                    log(checkedItems[index].toString());
                                                    // log(GetAddressCubit.get(context).checkedItems[index].toString());
                                                    //
                                                    //
                                                    //   widget.options![index].name.toString(),
                                                    // );
                                                  },
                                                ),
                                              locationType[GetAddressCubit.get(context).addressResponse![index].locationType].toString()==''?
                                              Container():Image.asset(locationType[GetAddressCubit.get(context).addressResponse![index].locationType.toString()]!,width: 50.w,height: 50.h,),
                                              Text(GetAddressCubit.get(context).addressResponse![index].locationType!,style: TextStyle(color: Colors.white),)
                                            ],
                                          ),
                                          Container(
                                          padding: EdgeInsets.only(right:6.sp),
                                            child: Row(
                                              children: [

                                                Text("Edit",style: TextStyle(color: Colors.white),),
                                                IconButton(
                                                    onPressed: (){
                                                      GetAddressCubit.get(context).deleteAddress(GetAddressCubit.get(context).addressResponse![index].id.toString());
                                                    },
                                                    icon: Icon(
                                                      Icons.highlight_remove_outlined,color: Colors.white,)
                                                ),
                                                // Icon(
                                                //     Icons.edit,
                                                //   color: Colors.white,
                                                // )
                                              ],
                                            ),
                                          )
                                        ],
                                      ) ,
                                       SizedBox(height: 10.h,),
                                       Container(
                                         padding: EdgeInsets.only(left: 15.sp),
                                         child: Row(
                                           // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text("Address",style: TextStyle(color: Colors.white),),
                                              SizedBox(width: 20.w,),
                                              Text(GetAddressCubit.get(context).addressResponse![index].detailedAddress!,
                                                style: TextStyle(fontSize: 15.sp,color: Colors.white),
                                              )
                                            ],
                                          ),
                                       ),
                                      SizedBox(height: 20.h,),
                                      Container(
                                         padding: EdgeInsets.only(left: 15.sp),
                                         child: Row(
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text("Phone",style: TextStyle(color: Colors.white),),
                                              SizedBox(width: 33.w,),
                                              Text(GetAddressCubit.get(context).addressResponse![index].phoneNumber!,
                                                style: TextStyle(fontSize: 15.sp,color: Colors.white),
                                              )
                                            ],
                                          ),
                                       ),

                    
                                    ],
                                  ),
                                ),
                              );
                            } ,
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed('/add_new_address');
                          },
                          child: Container(
                            margin: EdgeInsets.only(top:widget.isShowed?20.sp:60.sp),
                            padding: EdgeInsets.all(5.sp),
                            width: 400.w,
                            height: 43.h,
                            decoration:  BoxDecoration(
                              boxShadow: [
                                BoxShadow(color: Colors.white),
                                BoxShadow(color: Colors.black.withOpacity(0.7,),
                                  blurRadius: 5,
                                  spreadRadius: -1,

                                )
                              ],
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: Text('Add Address',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        ),
                        if(widget.isShowed)
                          InkWell(
                            onTap: (){
                              // log(chosenAddress.toString());
                              if(chosenAddress.values.isEmpty){
                                showToast('Please Choose Your Address');
                              }
                              else{
                                log(chosenAddress.toString());
                                Navigator.push(context,MaterialPageRoute(builder: (context)=> CheckOut(chosenAddress: chosenAddress,orderDetails: widget.orderDetails,dataIndex: widget.dataIndex,)));
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(top:25.sp),
                              padding: EdgeInsets.all(5.sp),
                              width: 340.w,
                              height: 43.h,
                              decoration:  BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff0083F7),
                                  ),
                                  BoxShadow(
                                    color: Color.fromRGBO(0,0, 0, 0.9),
                                    spreadRadius: -3,
                                    blurRadius: 15,
                                    offset: Offset(5,5),
                                    // blurStyle: BlurStyle.solid
                                  )
                                ],
                                // color: Color(0xff157A82),
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: Text('Confirm',
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
                ));
          }
      },
    ),
    );
  }
}
