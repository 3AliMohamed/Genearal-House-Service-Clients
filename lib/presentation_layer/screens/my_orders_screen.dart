import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/my_orders/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/my_orders/states.dart';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:general_house_service_clients/presentation_layer/screens/order_details.dart';

import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../reusable/app_bar.dart';
import '../../reusable/bottom_navigation_bar.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  int selectedTab=3;
  String order_id='Order#3';
  List<String> my_orders=['1','2',];
  String order_name=' T-Shirt Gray ';
  String order_price='520';
  String company_name='General House Service';
  String status='Done';
  String? lang=SharedPreferencesManager.getString('lang');
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyOrdersCubit,MyOrdersStates>(
      listener: (context,state){},
      builder: (context,state){
        if(state is InitialState || state is Loading)
          {
            MyOrdersCubit.get(context).getMyOrders();
            return  SpinKitFadingCube(
              color: Color(0xffB4AFAF),
              size: 50.0,
            );          }
        else if (state is FetchedSuccessfully)
          {
            return Scaffold(
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
                    height: ScreenUtil().screenHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            }, icon: Icon(
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5), // Shadow color
                              offset: Offset(0, 7), // Specify the offset of the shadow
                              blurRadius: 4, // Specify the blur radius of the shadow
                            ),
                          ],
                          Icons.arrow_back_sharp,
                          color: Colors.white,
                        )
                        ),
                        // SizedBox(height: 30.h,),
                        Padding(
                          padding:  EdgeInsets.only(left: 50.sp),
                          child: Text('My Orders', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5), // Shadow color
                                offset: Offset(0, 10), // Specify the offset of the shadow
                                blurRadius: 4, // Specify the blur radius of the shadow
                              ),
                            ],
                          ),),
                        ),

                        // SizedBox(height: 40.h,),
                        SizedBox(
                          height: 550.h,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: my_orders.length, // Adjust the number of items as needed
                            itemBuilder: (BuildContext context, int index) {
                              String? imgPath=state.response.data?[index].clientOrder?.company?.logoPath;
                              String? companyNameEn=state.response.data![index].clientOrder!.company!.nameEn.toString();
                              String? companyNameAr=state.response.data![index].clientOrder!.company!.nameAr.toString();


                              return Container(
                                margin: EdgeInsets.all(10.sp),
                                width: 400.w,
                                height: 150.h,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff0083F7),
                                      ),
                                      BoxShadow(
                                        color: Color.fromRGBO(0,0, 0, 0.9),
                                        spreadRadius: -1,
                                        blurRadius: 15,
                                        offset: Offset(2,2),
                                        // blurStyle: BlurStyle.solid
                                      )
                                    ]
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    imgPath == null?
                                    Container(
                                      padding:EdgeInsets.all(5.sp),
                                        child: Image.asset('assets/images/order_logo.png',width: 100.w,height: 120.h,)):
                                        Container(
                                            margin:EdgeInsets.all(7.sp),
                                            child: Image.network(ApiUrls().imageApi+imgPath,width: 100.w,height: 130.h,)),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(lang=='en'? companyNameEn:companyNameAr,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(state.response.data![index].id.toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        // ListView.builder(
                                        // scrollDirection: Axis.horizontal,
                                        // itemCount: product.length, // Adjust the number of items as needed
                                        // itemBuilder: (BuildContext context, int index) {
                                        //   return Text(product[index]);
                                        // },
                                        // ),


                                        Row(
                                          children: [
                                            Text('Status : ', style: TextStyle(color: Colors.white,)),
                                            Text(state.response.data![index].status.toString(),
                                                style: TextStyle(color: Colors.white,
                                                  decoration: TextDecoration.underline,
                                                  decorationColor: Colors.white,
                                                )
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 15.h,),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderDetails(chosenOrder: index))
                                                );
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(5.sp),
                                                padding: EdgeInsets.all(2.sp),
                                                width: 100.w,
                                                height: 22.h,
                                                decoration:  BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0xff0083F7),
                                                    ),
                                                    BoxShadow(
                                                      color: Color.fromRGBO(0,0, 0, 0.9),
                                                      spreadRadius: -2,
                                                      blurRadius: 9,
                                                      offset: Offset(0,0),
                                                      // blurStyle: BlurStyle.solid
                                                    )
                                                  ],
                                                ),
                                                child: Text('Order Details',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(color: Colors.white,
                                                    fontSize: 10.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: (){
                                                Navigator.of(context).pushNamed('/rate_order');
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(5.sp),
                                                padding: EdgeInsets.all(2.sp),
                                                width: 100.w,
                                                height: 22.h,
                                                decoration:  BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0xff0083F7),
                                                    ),
                                                    BoxShadow(
                                                      color: Color.fromRGBO(0,0, 0, 0.9),
                                                      spreadRadius: -2,
                                                      blurRadius: 9,
                                                      offset: Offset(0,0),
                                                      // blurStyle: BlurStyle.solid
                                                    )
                                                  ],
                                                ),
                                                child: Text('Rate Order',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(color: Colors.white,
                                                    fontSize: 10.sp,
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        )


                                      ],
                                    ),

                                    // Container(
                                    //   color: Color( 0xff00E5FF),
                                    //   width: 65.w,
                                    //   height: 2.h,
                                    // ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                )
            );
          }
        else{
          return  SpinKitFadingCube(
            color: Color(0xffB4AFAF),
            size: 50.0,
          );        }
      },
    );
  }
}
