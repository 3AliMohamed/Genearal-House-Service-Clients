import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../reusable/app_bar.dart';
import '../reusable/bottom_navigation_bar.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  List<String> address_list=['1','2','2','2','2','2','2',];
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
          padding: EdgeInsets.only(top: 30.sp),
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
                height: 570.h,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: address_list.length ,
                  itemBuilder: (context, index)
                  {
                    return InkWell(
                      onTap: (){},
                      hoverColor: Colors.red,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5.sp,top: 10.sp,right: 5.sp,left: 5.sp),
                        padding: EdgeInsets.all(5.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.sp),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.house,
                                    ),
                                    Text("House")
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Edite"),
                                    Icon(
                                      Icons.edit
                                    )
                                  ],
                                )
                              ],
                            ) ,
                            Divider(color: Colors.black,),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Address"),
                                  Text("12 Omranya Street , 5Th Floor,Dokki,Giza , Egypt",
                                  style: TextStyle(fontSize: 15.sp),
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  } ,
                ),
              ),
              InkWell(
                onTap: (){ 
                  Navigator.of(context).pushNamed('/add_new_address');
                },
                child: Container(
                  margin: EdgeInsets.only(top:20.sp),
                  padding: EdgeInsets.all(1.sp),
                  width: 400.w,
                  height: 37.h,
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Text('Add Address',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ),
               InkWell(
                onTap: (){},
                child: Container(
                  margin: EdgeInsets.only(top:80.sp),
                  padding: EdgeInsets.all(1.sp),
                  width: 300.w,
                  height: 37.h,
                  decoration:  BoxDecoration(
                    color: Color(0xff157A82),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Text('Confirm',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ));
  }
}
