import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/company/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/company/states.dart';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/presentation_layer/screens/products_screen.dart';

import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../reusable/app_bar.dart';
import '../../reusable/bottom_navigation_bar.dart';

class CategoriesCompany extends StatelessWidget{
  CategoriesCompany({Key? key, this.id});
  int? id;

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
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              Container(
                child: Text(
                  id == null
                      ? 'Laundry Clothes Company'
                      : "Dynamic name",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp,fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 93.sp),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: Color(0xff167279),
                        height: 4.h,
                        width: 120.w,
                      )
                    ]),
              ),
             BlocBuilder<CompanyCubit,CompanyStates>
               (builder:(context,state)
             {
               if(state is LoadingState || state is InitialState){
                 CompanyCubit.get(context).getCompany(id);
                 return CircularProgressIndicator();
               }
               else if(state is LoadedSuccessfully){

                 return  SingleChildScrollView(
                   child: SizedBox(
                     height: 750.h,
                     width: 500.w,
                     child: GridView.count(
                       crossAxisCount: 2,
                       mainAxisSpacing: 10.sp,
                       children:
                       List.generate(state.response.length, (index)
                       {
                         return InkWell(
                           onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsScreen(categoryId: state.response[index].categoryId,
                              companyId: state.response[index].companyId,) ));
                           },
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(
                               height: 400.h ,
                               width: 100.w,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15.sp),
                                 color: Colors.grey,
                               ),
                               child: SizedBox(
                                 height: 250.h,
                                 width: 80.w,
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: [
                                     //comp_temp.png
                                     state.response[index].logoPath ==null ? Image.asset('assets/images/comp_temp.png') :
                                     Image.network(ApiUrls().imageApi+state.response[index].logoPath.toString(),width: 130.w,height: 130.h,),
                                     // Text("For washing all kinds of clothes",style: TextStyle(fontSize: 10.sp),),
                                     Text(state.response[index].nameAr.toString(),style: TextStyle(fontSize: 8.sp),),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         RatingBar.builder(
                                           itemSize: 20.sp,
                                           initialRating: state.response[index].avrageRate.toDouble(),
                                           minRating: 1,
                                           direction: Axis.horizontal,
                                           allowHalfRating: true,
                                           itemCount: 5,
                                           // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                           itemBuilder: (context, _) => Icon(
                                             Icons.star,
                                             color: Colors.amber,
                                           ),
                                           onRatingUpdate: (rating) {
                                             print(rating);
                                           },
                                         ),
                                         Text('(${state.response[index].rateCount.toString()})',style: TextStyle(fontSize: 15.sp),),
                                       ],
                                     )
                                   ],
                                 ),
                               ),
                             ),
                           ),
                         );

                       }

                       ),


                     ),
                   ),
                 );
               }
                else if(state is LoadedErrorState){
                  return Text(state.error);
               }
                else{
                  return CircularProgressIndicator();
               }
             }
             ),
            ],
          ),
        ));
  }
}


