import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/app_cubit/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/app_cubit/states.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/home_page/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/home_page/states.dart';
import 'package:general_house_service_clients/data_layer/repository/home_page_repository.dart';
import '../helpers/SharedPrefManager.dart';
import '../reusable/app_bar.dart';
import '../reusable/bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  int  selectedTab=3 ;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<String> imageAssets =
  [
    'assets/images/offer1.png',
    'assets/images/offer2.png',
  ];

  final List<String> imageAssets_2 = [
    'assets/images/ghs.jpg',
    'assets/images/ghs2.jpg',
  ];


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
          if (SharedPreferencesManager.containKey('is_login')==false)
          {
            Navigator.of(context).pushNamed('/login');
          }else
          {
            if(SharedPreferencesManager.getBool('is_login')==true){Navigator.of(context).pushNamed('/profile');}
            else{Navigator.of(context).pushNamed('/login');}
          }
        },
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: ScreenUtil().screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 25.h),
              BlocBuilder<HomePageCubit,HomePageStates>(
                  builder: (context,state)
                  {
                    if(state is HomePageInitialState)
                      {
                        HomePageCubit.get(context).fetchHomePageData();
                        return CircularProgressIndicator();

                      }
                    else
                      {
                        return  CarouselSlider.builder(
                            itemCount: HomePageCubit.get(context).sliderImages.length,
                            itemBuilder: (context, index, realIndex) {
                              final  image= HomePageCubit.get(context).sliderImages[index];
                              return Container(
                                padding: EdgeInsets.all(10.sp),
                                // color: Colors.grey,
                                width: double.infinity,
                                child: Image.network(image,fit: BoxFit.cover,),
                              );
                            },
                            options: CarouselOptions(
                              enlargeCenterPage: true,
                              scrollPhysics: BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast
                              ),

                            )
                        );
                      }
                  }),
              SizedBox(height: 20.h,),
              Text(
                'We care about your house',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h,),
              CarouselSlider(
                options: CarouselOptions(
                  height: 120.h,
                  autoPlay: true,
                ),
                items: imageAssets
                    .map((item) => Container(
                  child: Image.asset(item),
                ))
                    .toList(),
              ),
              Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Path.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(25),
                    child: Text(
                      'Exlcusive Deals',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
              ),

              Container(
                height: 350.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Adjust the number of items as needed
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                        // naviagte to categories screen with companyId
                        Navigator.of(context).pushNamed('/products');
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
                              children: [
                                Image.asset("assets/images/temp2.png"),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset("assets/images/comp_logo.png",height: 50.h,width: 50.w,
                                      alignment:Alignment.topLeft,
                                    ) ,
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("For washing all kinds of clothes",style: TextStyle(fontSize: 7.sp),),
                                        Text("Moataz laundry",style: TextStyle(fontSize: 7.sp),),
                                        Row(
                                          children: [
                                            RatingBar.builder(
                                              itemSize: 10.sp,
                                              initialRating: 3,
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
                                            Text('(5)',style: TextStyle(fontSize: 10.sp),),
                                          ],
                                        )
                                      ],
                                    ),



                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                    // return Container(
                    //   child: Column(
                    //     children: [
                    //       Container(
                    //         margin: EdgeInsets.only(left: 8.sp,right: 8.sp),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                    //           boxShadow: [
                    //             BoxShadow(
                    //                 color: Color(0xff35737D),
                    //                 spreadRadius: 1.sp,
                    //                 blurRadius: 5.sp,
                    //                 offset: Offset(0, 3),
                    //                 blurStyle: BlurStyle.outer
                    //             ),
                    //           ],
                    //         ),
                    //         child: Image.asset('assets/images/pngwing.png',
                    //           height: 150.h,
                    //           width: 120.w,
                    //         ),
                    //       ),
                    //       SizedBox(height: 15.h,),
                    //       Container(
                    //         padding: EdgeInsets.only(left: 2.sp),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(
                    //               10.0), // Adjust the border radius as needed
                    //         ),
                    //         child: InkWell(
                    //           onTap: () {
                    //             log("hello");
                    //             // HomePageCubit.get(context).fetchHomePageData();
                    //           },
                    //           child: Container(
                    //             padding: EdgeInsets.all(8.0),
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(12.sp),
                    //               border: Border.all(
                    //                 color: Color(0xff35737D), // Border color
                    //                 width: 2.sp, // Border width
                    //               ),
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                   color: Color(0xff35737D).withOpacity(0.2),
                    //                   spreadRadius: 5,
                    //                   blurRadius: 5,
                    //                   offset: Offset(0, 1),
                    //                 ),
                    //               ],
                    //             ),
                    //             child: Text(
                    //               'Copy Promo Code ',
                    //               style: TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 12.sp,
                    //               ), // Text color
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}





