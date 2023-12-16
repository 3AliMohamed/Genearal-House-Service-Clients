import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../reusable/app_bar.dart';
import '../reusable/bottom_navigation_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late int selectedTab=1;
  List<String> orders=['1','2','3','3','3','3','3','3','3','3',];
  String order_id='Order#3';
  List<String> options = [
    'ironing',
    'laundry',
    'ironing',
    'laundry',
    'ironing',
    'laundry',
  ];
  String product='t-shirt Gray';
  String order_price='520';
  String company_name='General House Service';
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
            child: SizedBox(
              height: 250.h,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: orders.length, // Adjust the number of items as needed
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    // margin: EdgeInsets.all(10.sp) ,
                    color: Colors.black,
                    child: Row(
                      children: [
                        Image.asset('assets/images/order_logo.png',width: 160.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order_id,
                            style: TextStyle(color: Colors.white),
                            ),
                              Text("$order_price Aud" ,
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(company_name,
                                style: TextStyle(color: Color(0xff318098)),
                              ),

                            ],
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 110.sp),
                          child: InkWell(
                              onTap: (){ 
                                Navigator.of(context).pushNamed('/loading_screen');
                              },
                              child: Text('Check Out',
                                style: TextStyle(color: Color(0xff00E5FF),
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xff00E5FF),
                                ),
                              )),
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
            )
        )
    );
  }
}
