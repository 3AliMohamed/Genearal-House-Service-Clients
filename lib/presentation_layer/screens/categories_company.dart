import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/company/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/company/states.dart';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:general_house_service_clients/presentation_layer/screens/products_screen.dart';
import 'package:get/get.dart';
import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../reusable/app_bar.dart';
import '../../reusable/bottom_navigation_bar.dart';

class CategoriesCompany extends StatelessWidget{
  CategoriesCompany({Key? key, this.id});
  int? id;
  String? currentLang=SharedPreferencesManager.getString('lang');
  @override
  Widget build(BuildContext context) {

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
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              Container(
                child: Text(Trans('Companies ').tr,
                  style: TextStyle(color: Colors.white, fontSize: 20.sp,fontWeight: FontWeight.bold),
                ),
              ),
             BlocBuilder<CompanyCubit,CompanyStates>
               (builder:(context,state)
             {
               if(state is LoadingState || state is InitialState){
                 CompanyCubit.get(context).getCompany(id);
                 return  SpinKitFadingCube(
                   color: Color(0xffB4AFAF),
                   size: 50.0,
                 );               }
               else if(state is LoadedSuccessfully){

                 return  SingleChildScrollView(
                   child: SizedBox(
                     height: 750.h,
                     width: 500.w,
                     child: ListView.separated(
                         itemCount:state.response.data!.length,
                         separatorBuilder: (context,index){
                           return SizedBox(height: 30.h,);
                         },
                         itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                           onTap: (){
                             dynamic categories= state.response.data![index].categories;
                             Map<String ,dynamic>company=state.response.data![index].toJson();
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsScreen(categoryId: state.response.data![index].categoryId,
                              companyId: state.response.data![index].companyId,categoriesProduct: categories,company: company,) ));
                           },
                           child: Container(
                             height: 300.h ,
                             width: 200.w,
                             padding: EdgeInsets.only(left: 20.sp,right: 20.sp,top: 13.sp),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(15.sp),
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
                               ]
                             ),
                             child: Column(
                               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 //comp_temp.png
                                 state.response.data![index].logoPath ==null ? Image.asset('assets/images/comp_temp.png') :
                                 Image.network(ApiUrls().imageApi+state.response.data![index].coverPath.toString(),height: 130.h,),
                                 // Text("For washing all kinds of clothes",style: TextStyle(fontSize: 10.sp),),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Column(
                                       children: [
                                         Text(state.response.data![index].nameAr.toString(),style: TextStyle(fontSize: 15.sp,color: Colors.white),),
                                         Text('Delivery By ${state.response.data![index].nameEn}',
                                         style: TextStyle(color: Colors.white,fontSize: 15.sp),
                                         ),
                                         Text('Payment : Cash ',
                                         style: TextStyle(color: Colors.white,fontSize: 15.sp),
                                         ),
                                         Text('24 Hour Delivery',
                                         style: TextStyle(color: Colors.white,fontSize: 15.sp,
                                         fontStyle: FontStyle.italic,
                                         ),
                                         ),

                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: [
                                             GestureDetector(
                                               onTap: () {
                                                 // Ignore taps
                                               },
                                               child: RatingBar.builder(
                                                 unratedColor: Colors.grey,
                                                 itemSize: 20.sp,
                                                 initialRating: state.response.data![index].avrageRate!.toDouble(),
                                                 minRating: 1,
                                                 direction: Axis.horizontal,
                                                 allowHalfRating: true,
                                                 itemCount: 5,
                                                 itemBuilder: (context, index) {
                                                   return Icon(
                                                     Icons.star,
                                                     color: Colors.amber,
                                                   );
                                                 },
                                                 onRatingUpdate: (rating) {
                                                   // This won't be called since GestureDetector ignores taps
                                                   print(rating);
                                                 },
                                               ),
                                             ),
                                             Text('(${state.response.data![index].rateCount.toString()})',style: TextStyle(fontSize: 15.sp),),
                                           ],
                                         ),
                                       ],
                                     ),
                                     state.response.data![index].logoPath ==null ? Image.asset('assets/images/comp_temp.png') :
                                     Image.network(ApiUrls().imageApi+state.response.data![index].logoPath.toString(),width: 100.w,height: 130.h,),
                                   ],
                                 )
                               ],
                             ),
                           ),
                         );
                       }
                       ),
                   ),
                 );
               }
                else if(state is LoadedErrorState){
                  return Text(state.error);
               }
                else{
                 return  SpinKitFadingCube(
                   color: Color(0xffB4AFAF),
                   size: 50.0,
                 );               }
             }
             ),
            ],
          ),
        ));
  }
}


