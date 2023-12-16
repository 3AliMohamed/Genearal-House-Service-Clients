import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../reusable/app_bar.dart';
import '../reusable/bottom_navigation_bar.dart';

class ProductsScreen extends StatefulWidget {
   ProductsScreen({Key? key, this.id}) : super(key: key);
  int? id;
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int selectedTab =2;
  List<String>products_list=['1','2','3','4','4','4','4','4','4','4','4','4','4','4',];
  String product_name='Tshirt';
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
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
                      ? 'Products'
                      : "Dynamic name",
                  style: TextStyle(color: Colors.white, fontSize: 20.sp,fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 173.sp),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: Color(0xff167279),
                        height: 4.h,
                        width: 50.w,
                      )
                    ]),
              ),
              SizedBox(
                height: 10.h,
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: 750.h,
                  width: 500.w,
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.sp,
                    children:
                    List.generate(products_list.length, (index)
                    {
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed('/product_option');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all (8.0),
                          child: Container(
                            height: 400.h ,
                            width: 100.w,
                            child: Column (
                              children: [
                                Image.asset("assets/images/product.png",fit: BoxFit.fill,height: 155.h,),
                                Container(
                                  width: 160.w,
                                  height: 38.h,
                                  // padding: EdgeInsets.all(20)
                                  child: Center(
                                      child: Text(product_name,style: TextStyle(fontSize: 15.sp),
                                      )
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                            color: Color(0xff35737D).withOpacity(0.2),
                                            spreadRadius: 5,
                                            blurRadius: 5,
                                            offset: Offset(0, 1),
                                ),
                              ],
                                  )
                                ),
                              ],
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
