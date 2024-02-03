import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/app_cubit/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/get_company_relatedOffer/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/home_page/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/home_page/states.dart';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/data_layer/repository/get_company_relatedOffer_repository.dart';
import 'package:general_house_service_clients/data_layer/web_services/get_company_relatedOffer.dart';
import 'package:general_house_service_clients/presentation_layer/screens/categories_screen.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';
import 'package:get/get.dart';
import '../../data_layer/models/responses/home_page_response.dart';
import '../../helpers/SharedPrefManager.dart';
import '../../reusable/app_bar.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   int? chosenOfferIndex;

  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // final List<String> imageAssets =
  final List<String> imageAssets_2 = [
    'assets/images/ghs.jpg',
    'assets/images/ghs2.jpg',
  ];

  @override
  Widget build(BuildContext context) {
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
                        return  SpinKitFadingCube(
                          color: Color(0xffB4AFAF),
                          size: 50.0,
                        );
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
                Trans('We Care About Your House').tr,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h,),
              BlocBuilder<HomePageCubit,HomePageStates>(
                  builder: (context, state)
              {
                if(state is FetchHomePageSuccessState)
                  {
                return CarouselSlider(

                  options: CarouselOptions(

                    height: 120.h,
                    autoPlay: true,
                  ),
                  items: state.response.offers?.asMap().entries.map((entry) {
                      int index = entry.key;
                    final Offers item = entry.value; // Replace Offer with your item type
                    if (item.imgPath != null) {
                      return Container(
                        child: InkWell(
                          onTap: () {
                              setState(() {
                                chosenOfferIndex=index;
                              });
                          },
                          child: Image.network(ApiUrls().imageApi + item.imgPath!),
                        ),
                      );
                    } else {
                      return Image.asset('assets/images/offer1.png'); // You can return an empty container or handle null images differently based on your requirement.
                    }
                  }).toList() ?? [],
                );
                  }
                else{return  SpinKitFadingCube(
                  color: Color(0xffB4AFAF),
                  size: 50.0,
                );}
              }
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
                      Trans('Exlcusive Deals').tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
              ),

              BlocBuilder<HomePageCubit,HomePageStates>(
                  builder: (context,state)
              {
                if(state is FetchHomePageSuccessState && chosenOfferIndex !=null)
                  {
                    return SizedBox(
                      height: 220.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.response.offers?[chosenOfferIndex!].companies?.length, // Adjust the number of items as needed
                        itemBuilder: (BuildContext context, int index) {
                          String? logoPath = state.response.offers![chosenOfferIndex!].companies![index].logoPath;

                          return InkWell(
                            onTap: (){
                              int? companyId=state.response.offers![chosenOfferIndex!].companies![index].userId;
                              GetCompanyCubit.get(context).getCompany(companyId!, context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 220.h ,
                                width: 150.w,
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
                                      logoPath !=null?
                                      Image.network(ApiUrls().imageApi+logoPath,
                                      width: 130.w,height: 130.h,):
                                      Image.asset('assets/images/comp_temp.png',width: 130.w,height: 130.h,),
                                      Text(state.response.offers![chosenOfferIndex!].companies![index].nameEn!,style: TextStyle(fontSize: 12.sp),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );

                        },
                      ),
                    );
                  }
                else
                  {return Container();}
              })
            ],
          ),
        ),
      ),
    );
  }
}





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