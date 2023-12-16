import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../reusable/app_bar.dart';
import '../reusable/bottom_navigation_bar.dart';

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h,),
                Padding(
                  padding:  EdgeInsets.only(left: 8.sp),
                  child: Text('My Orders', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 8.sp),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.sp),
                      color: Colors.white,
                    ),
                    width: 30.w,
                    height: 5.h,
                  ),
                ),
                SizedBox(height: 40.h,),
                SizedBox(
                  height: 550.h,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: my_orders.length, // Adjust the number of items as needed
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        // margin: EdgeInsets.all(10.sp) ,
                        color: Colors.black,
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/order_logo.png'),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(order_id,
                                  style: TextStyle(color: Colors.white),
                                ),
                                // ListView.builder(
                                // scrollDirection: Axis.horizontal,
                                // itemCount: product.length, // Adjust the number of items as needed
                                // itemBuilder: (BuildContext context, int index) {
                                //   return Text(product[index]);
                                // },
                                // ),
                                Text("$order_name ($order_price Aud)" ,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(company_name,
                                  style: TextStyle(color: Color(0xff318098)),
                                ),
                                Row(

                                  children: [
                                    Text('Status : ', style: TextStyle(color: Colors.white,)),
                                    Text(status,
                                        style: TextStyle(color: Colors.green,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.green,
                                        )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.of(context).pushNamed('/order_details');
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(5.sp),
                                      padding: EdgeInsets.all(1.sp),
                                      width: 100.w,
                                      height: 20.h,
                                      decoration:  BoxDecoration(
                                          color: Color(0xff157A82),
                                          borderRadius: BorderRadius.circular(5.sp),
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
                                      padding: EdgeInsets.all(1.sp),
                                      width: 100.w,
                                      height: 20.h,
                                      decoration:  BoxDecoration(
                                          color: Colors.orangeAccent,
                                          borderRadius: BorderRadius.circular(5.sp),
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
}
