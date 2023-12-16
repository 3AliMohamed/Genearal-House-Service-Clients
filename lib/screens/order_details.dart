import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:general_house_service_clients/reusable/bottom_navigation_bar.dart';

import '../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../reusable/app_bar.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int selectedTab =3;
  String order_id='489726';
  String product_name='T-shirt';
  String chosen_service="Cleaning";
  String total_price='200';
  String company_name='General Service Company';
  String status='Pending';
  String pickup_driver='Ahmed ali';
  String delivery_driver='Sameh Omar';
  String product_option="ironing";
  String quantity="1";
  String product_price='300';
  String total='300';
  String payment_status='Not Paied';
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
      body:Container(
                  height: ScreenUtil().screenHeight,
                  decoration: BoxDecoration(
                  image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fitWidth,
                  ),
                  ),
                  child: Container(
                  height: ScreenUtil().screenHeight,
                  decoration: BoxDecoration(
                  image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fitWidth,
                  ),
                  ),
    child: Column(
      children: [
          SizedBox(height: 30.h,),
          Text("Order ID -$order_id",
          style: TextStyle(color: Colors.white,fontSize: 25.sp),
          ),
          SizedBox(height: 40.h,),
          Container( 
            margin: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Row(
                   // mainAxisAlignment: MainAxisAlignment.space
                   children: [
                     CircleAvatar(

                       radius: 20.0, 
                       child: ClipOval( 
                         child: Image.asset("assets/images/comp_temp.png",
                           fit: BoxFit.cover,
                            // width: 100.w,
                           // height: 100.h,
                         ),
                       ),
                       // backgroundImage: AssetImage("assets/images/comp_temp.png",),

                     ),
                     SizedBox(width: 10.w,),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("$product_name $chosen_service  ($total_price AUD)"),
                         Text(company_name,
                         style: TextStyle(fontSize: 12.sp,color: Colors.black.withOpacity(0.5)),
                         ),
                         Text("Status : $status",
                         style: TextStyle(color: Colors.red,
                           fontSize: 10.sp,
                           decoration: TextDecoration.underline,
                           decorationColor: Colors.red,
                         ),
                         )
                       ],
                     )
                   ],
                 ),
                Divider(color: Colors.black,),
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Text("Delivery Details :"),
                ),
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("3.00Am to 7.00pm 22/2/2023"),
                      Text("Picked By : $pickup_driver",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                        fontSize: 13.sp,
                      ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(8.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("3.00Am to 7.00pm 22/2/2023"),
                      Text("Delivery By : $delivery_driver",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                        fontSize: 13.sp,
                      ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black,),
                  Padding(
                    padding: EdgeInsets.only(left: 8.sp,bottom: 13.sp,top: 3.sp),
                    child: Text("Payment Status :$payment_status",
                    style: TextStyle(color: Colors.green),
                    ),
                  ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF5EFEF),
                    border: Border(
                      top: BorderSide(color: Colors.black),
                      bottom: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Name"),
                      Text("Qty"),
                      Text("Price"),
                      Text("Total"),

                    ],
                  ),
                ),
                Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                    // color: Color(0xffF5EFEF),
                    border: Border(
                      // top: BorderSide(color: Colors.black),
                      bottom: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.
                    children: [
                      Text("$product_name($product_option)",
                        style: TextStyle(fontSize: 13.sp),
                      ),
                      SizedBox(width: 65.sp,),

                      Text(quantity),
                      SizedBox(width: 70.sp,),
                      Text("$product_price Aud"),
                      SizedBox(width: 62.sp,),
                      Text(total.toString()),

                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.sp,bottom: 10.sp,
                      left: 5.sp,right: 5.sp),
                  margin: EdgeInsets.only(bottom: 30.sp),
                  decoration: BoxDecoration(
                      color: Color(0xffCCDBE5),
                      border: Border(
                        bottom: BorderSide(color: Color(0xff707070)),
                        top: BorderSide(color: Color(0xff707070)),
                      )
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sub Total:"),
                          Text("$total Aud"),
                        ],
                      ),
                      SizedBox(height: 5.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Minimum Charge:"),
                          Text("$total Aud"),
                        ],
                      ),
                      SizedBox(height: 5.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Discount:"),
                          Text("$total Aud"),
                        ],
                      ),
                      SizedBox(height: 5.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Vat:"),
                          Text("$total Aud"),
                        ],
                      ),
                      SizedBox(height: 5.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery Fees:"),
                          Text("Free"),
                        ],
                      ),
                      SizedBox(height: 13.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Text("Delivery Fees:"),
                          Container(
                            color: Colors.black,
                            width: 50.w,
                            height: 2.h,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total:"),
                          Text("2000 Aud"),
                        ],
                      ),






                    ],
                  ),
                )

              ],
            ),
          ),
      ],
    )
    ),
      ),
    );
  }
}
