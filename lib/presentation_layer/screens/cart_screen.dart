import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/cart/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/cart/states.dart';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/data_layer/repository/cart_repository.dart';
import 'package:general_house_service_clients/data_layer/web_services/cart_web_services.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:general_house_service_clients/presentation_layer/screens/cart_details.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';
import 'package:get/get.dart';

import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../reusable/app_bar.dart';
import '../../reusable/bottom_navigation_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override

  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  late int orderId;
  String? currentLang= SharedPreferencesManager.getString('lang');
  String order_price='520';
  late String companyNameEn;
  late String companyNameAr;

  @override
  // @override
  // void didPop() {
  //   // super.didPop();
  //   // Refresh the cart when you navigate back to this screen
  //   CartCubit.get(context).getCart();
  // }
  Widget build(BuildContext context) {

    return BlocConsumer<CartCubit,CartStates>(
                  listener: (context,state){
                    if (state is FetchDataErrorState){
                      // showToast(state.error.toString());
                      // log(state.error.toString());
                    }
                  },
                builder: (context,state){
                  if(state is InitialState )
                    {CartCubit.get(context).getCart();
                    return  SpinKitFadingCube(
                      color: Color(0xffB4AFAF),
                      size: 50.0,
                    );
                   }
                  else if(state is LoadingState)
                    {
                      return  SpinKitFadingCube(
                        color: Color(0xffB4AFAF),
                        size: 50.0,
                      );
                    }
                  else
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
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }, icon: Icon(Icons.arrow_back_sharp,
                                      color: Colors.white,
                                )
                                ),
                                Center(
                                  child: Text('Companies Cart',
                                  style: TextStyle(color: Colors.white,
                                  fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                ),
                                SizedBox(height: 10.h,),
                                SizedBox(
                                  height: 770.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: CartCubit.get(context).responseData?.length,
                                    // state.response.data?.length, // Adjust the number of items as needed
                                    itemBuilder: (BuildContext context, int index) {
                                      companyNameEn=CartCubit.get(context).responseData?[index].company?.nameEn??'';
                                      companyNameAr=CartCubit.get(context).responseData?[index].company?.nameAr??'';
                                      orderId=CartCubit.get(context).responseData![index].orderId!;
                                      // :state.response.data?[index].company.nameAr!;
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context, MaterialPageRoute(builder: (context) => CartDetails(dataIndex: index)),
                                          );
                                        },

                                        child: Container(
                                          // margin: EdgeInsets.all(10.sp) ,
                                          // elevation: 10.sp,
                                          // shadowColor: Color(0xff318098),
                                          // color: Colors.black, 
                                          margin: EdgeInsets.all(10.sp),
                                          width: 400.w,
                                          height: 175.h,
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
                                          child: Column(
                                            children: [
                                              SizedBox(height: 10.h,),
                                              Container(
                                                width: 380.w,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    // String? img=state.response.data?[index].company?.logoPath;
                                                    // logoPath ==''?
                                                    CartCubit.get(context).responseData?[index].company?.logoPath==''?
                                                    Container(
                                                      color: Colors.green,
                                                        width: 150.w,
                                                        // padding: EdgeInsets.all(5.sp),
                                                        child: Image.asset('assets/images/order_logo.png',)):
                                                    Container(
                                                        width: 120.w,
                                                        height: 120.h,
                                                        child: Image.network(ApiUrls().imageApi+CartCubit.get(context).responseData![index].company!.logoPath.toString())),
                                                    // SizedBox(width: 10.w,),
                                                    SizedBox(width: 5.w,),
                                                    Container(
                                                      width: 150.w,
                                                      padding: EdgeInsets.only(top: 30.h),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(currentLang=='en'? companyNameEn: companyNameAr,
                                                            style: TextStyle(color: Colors.white),
                                                          ),
                                                          Text(orderId.toString(),
                                                            style: TextStyle(color: Colors.white),
                                                          ),
                                                          Text("$order_price Aud" ,
                                                            style: TextStyle(color: Colors.white),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(bottom: 60.sp,),
                                                      child: InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(builder: (context) => CartDetails(dataIndex: index)),
                                                            );
                                                          },

                                                          child: Text('View Details',
                                                            style: TextStyle(color: Colors.white,
                                                              decoration: TextDecoration.underline,
                                                              fontSize: 15.sp,
                                                              decorationColor: Colors.white,
                                                            ),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 130.w,
                                                    height: 25.h,
                                                    padding: EdgeInsets.all(5.sp),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(7.sp),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Color(0xff0083F7),
                                                          ),
                                                          BoxShadow(
                                                            color: Color.fromRGBO(0,0, 0, 0.9),
                                                            spreadRadius: -1,
                                                            blurRadius: 10,
                                                            offset: Offset(0,0),
                                                            // blurStyle: BlurStyle.solid
                                                          )
                                                        ]
                                                    ),
                                                    child: InkWell(
                                                      onTap: (){},
                                                      child: Text('CheckOut',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                      )
                  );}
                  // else if(state is FetchDataErrorState){
                  //   return Scaffold(
                  //       bottomNavigationBar: BottomNavigationBar(
                  //         items: AppCubit.get(context).buildBottomNavItems(),
                  //         onTap: (index) => AppCubit.get(context).navigateOnTab(context, index),
                  //         currentIndex: AppCubit.get(context).selectedTap,
                  //         selectedFontSize: 10.sp,
                  //         unselectedFontSize: 10.sp,
                  //         unselectedItemColor: Colors.blueGrey,
                  //         selectedItemColor: Colors.blueGrey,
                  //         type: BottomNavigationBarType.fixed,
                  //         backgroundColor: Color(0XFF202020),
                  //       ),
                  //       appBar: CustomAppBar(),
                  //       body: Container(
                  //         height: ScreenUtil().screenHeight,
                  //         decoration: BoxDecoration(
                  //           image: DecorationImage(
                  //             image: AssetImage("assets/images/background.png"),
                  //             fit: BoxFit.fitWidth,
                  //           ),
                  //         ),
                  //      child: Center(
                  //        child: Text(state.error.toString(),
                  //          style: TextStyle(color: Colors.white, fontSize: 25),
                  //        ),
                  //      ),)
                  //   );
                  // }
                  // else{
                  //   return  Scaffold(
                  //       bottomNavigationBar: BottomNavigationBar(
                  //       items: AppCubit.get(context).buildBottomNavItems(),
                  //       onTap: (index) => AppCubit.get(context).navigateOnTab(context, index),
                  //       currentIndex: AppCubit.get(context).selectedTap,
                  //       selectedFontSize: 10.sp,
                  //       unselectedFontSize: 10.sp,
                  //       unselectedItemColor: Colors.blueGrey,
                  //       selectedItemColor: Colors.blueGrey,
                  //       type: BottomNavigationBarType.fixed,
                  //       backgroundColor: Color(0XFF202020),
                  // ),
                  // appBar: CustomAppBar(),
                  // body: Container(
                  //   height: ScreenUtil().screenHeight,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage("assets/images/background.png"),
                  //       fit: BoxFit.fitWidth,
                  //     ),
                  //   ),
                  // )
                  //   );
                  // }
                  },
              );
  }
}
