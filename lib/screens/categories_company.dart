import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../reusable/app_bar.dart';
import '../reusable/bottom_navigation_bar.dart';

class CategoriesCompany extends StatefulWidget {
  CategoriesCompany({Key? key, this.id});
  int? id;
  @override
  State<CategoriesCompany> createState() => _CategoriesCompanyState();
}

class _CategoriesCompanyState extends State<CategoriesCompany> {
  String rate ='80';
  List<String> companies_list=['1','2','3','4','4','4','4','4','4','4','4','4','4','4',];

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
                  widget.id == null
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
              SingleChildScrollView(
                child: SizedBox(
                  height: 750.h,
                  width: 500.w,
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.sp,
                    children:
                      List.generate(companies_list.length, (index)
                      {
                        return InkWell(
                          onTap: (){
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
                                                Text('($rate)',style: TextStyle(fontSize: 10.sp),),
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

                      }

                      ),



                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
