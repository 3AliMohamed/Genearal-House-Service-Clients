import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../reusable/app_bar.dart';
import '../reusable/bottom_navigation_bar.dart';

class ProductOption extends StatefulWidget {
  const ProductOption({Key? key}) : super(key: key);

  @override
  State<ProductOption> createState() => _ProductOptionState();
}

class _ProductOptionState extends State<ProductOption> {
  int selectedTab = 2;
  String product_name = 'T-shirt black Size (M)';
  int quantity = 0;
  List<String> options = [
    'ironing',
    'laundry',
    'ironing',
    'laundry',
    'ironing',
    'laundry',
  ];

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
          child:
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                        SizedBox(
                          height: 70.h,
                        ),
                        Text(
                          product_name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children:
                          [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/Isolated_black_t-shirt_front.png",
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 250.w,
                                  child: Text(
                                    "The distinctive ironing allows you to get the best shape for your appearance",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //
                                    FloatingActionButton.small(
                                      heroTag: 'btn1',
                                      backgroundColor: Colors.black.withOpacity(0.1),
                                      foregroundColor: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          quantity+=1;
                                        });
                                      },
                                      child: Icon(
                                        Icons.add,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      width: 30.w,
                                      child: Center(
                                        child: Text(
                                          quantity.toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    FloatingActionButton.small(
                                      heroTag: 'btn2',
                                      backgroundColor: Colors.black.withOpacity(0.1),
                                      foregroundColor: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                            if(quantity>0){quantity-=1;}
                                            else{quantity=0;}
                                        });
                                      },
                                      child: Icon(
                                        Icons.remove,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                         SizedBox(
                           height: 60.h,
                         ),
                         Container(
                           height: 60.h,
                           child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: options.length, // Adjust the number of items as needed
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 75.w,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffD6E3EC),

                              ),
                              child: Text(options[index]),
                            ),
                          );
                        },
                      ),
                    ),
                          SizedBox(
                            height: 220.h,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 80.h),
                            width: 280.w,
                            child: ElevatedButton
                              (
                                onPressed: (){
                                  Navigator.of(context).pushNamed("/cart");
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff16747C),
                                  onPrimary: Colors.white,
                                  elevation: 10,
                                  shadowColor:Color(0xff16747C),
                                ),
                                child: Container(
                                  child: Text('Add',
                                  style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                  ),
                                  ),
                                )
                            ),
                          ),
                  ]),
        ));
  }
}
