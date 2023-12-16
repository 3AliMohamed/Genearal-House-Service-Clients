import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../reusable/app_bar.dart';
import '../reusable/bottom_navigation_bar.dart'; 

class RateOrder extends StatefulWidget {
  const RateOrder({Key? key}) : super(key: key);

  @override
  State<RateOrder> createState() => _RateOrderState();
}

class _RateOrderState extends State<RateOrder> { 
  int selectedTab=0;
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
            SizedBox(height: 35.h,),
            Image.asset('assets/images/succeessss.png',height: 200.h,),
            SizedBox(height: 10.h,),
            Text('Thanks for using General House Service',
              style: TextStyle(color: Color(0xff19CFF5) ,
                fontSize: 20.sp,
              ) ,
            ),
            SizedBox(height: 50.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Delivery',
                style: TextStyle(color: Colors.white,
                fontSize: 30.sp,
                ),

                ),
                RatingBar.builder(
                  itemSize: 45.sp,
                  initialRating: 5,
                  minRating: 5,
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
              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Delivery',
                style: TextStyle(color: Colors.white,
                fontSize: 30.sp,
                ),

                ),
                RatingBar.builder(
                  itemSize: 45.sp,
                  initialRating: 5,
                  minRating: 5,
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
              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Delivery',
                style: TextStyle(color: Colors.white,
                fontSize: 30.sp,
                ),

                ),
                RatingBar.builder(
                  itemSize: 45.sp,
                  initialRating: 5,
                  minRating: 5,
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
              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Delivery',
                style: TextStyle(color: Colors.white,
                fontSize: 30.sp,
                ),

                ),
                RatingBar.builder(
                  itemSize: 45.sp,
                  initialRating: 5,
                  minRating: 5,
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
              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Delivery',
                style: TextStyle(color: Colors.white,
                fontSize: 30.sp,
                ),

                ),
                RatingBar.builder(
                  itemSize: 45.sp,
                  initialRating: 5,
                  minRating: 5,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Container(

                    child: Icon(
                      Icons.star,
                      color: Colors.amber,

                    ),

                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ],
            ),
            InkWell(
              onTap: (){},
              child: Container(
                margin: EdgeInsets.only(top: 65.sp,left: 20.sp),
                padding: EdgeInsets.all(1.sp),
                width: 230.w,
                height: 37.h,
                decoration:  BoxDecoration(
                  color: Color(0xff13AE89),
                  borderRadius: BorderRadius.circular(5.sp),
                ),
                child: Text('Send',
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
    );
  }
}
