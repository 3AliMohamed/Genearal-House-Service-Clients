import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/my_orders/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/my_orders/states.dart';
import 'package:general_house_service_clients/reusable/bottom_navigation_bar.dart';

import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../reusable/app_bar.dart';

class OrderDetails extends StatefulWidget {
   OrderDetails({Key? key,this.chosenOrder}) : super(key: key);
  int ? chosenOrder;
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
    return BlocConsumer<MyOrdersCubit,MyOrdersStates>(
        listener: (context,state){

        },
        builder: (context,state){
          if(state is InitialState || state is Loading)
            {
              MyOrdersCubit.get(context).getMyOrders();
              return  SpinKitFadingCube(
                color: Color(0xffB4AFAF),
                size: 50.0,
              );            }
          else if(state is FetchedSuccessfully){
            return Scaffold(
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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              }, icon: Icon(
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5), // Shadow color
                                offset: Offset(0, 7), // Specify the offset of the shadow
                                blurRadius: 4, // Specify the blur radius of the shadow
                              ),
                            ],
                            Icons.arrow_back_sharp,
                            color: Colors.white,
                          )
                          ),
                          // SizedBox(height: 30.h,),
                          Center(
                            child: Text("Order ID -${state.response.data![widget.chosenOrder!].id}",
                              style: TextStyle(color: Colors.white,fontSize: 25.sp),
                            ),
                          ),
                          // SizedBox(height: 40.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.electric_rickshaw,size: 30.sp,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text('Thank You!',
                                style: TextStyle(color: Colors.white,fontSize: 20.sp),),
                                Text('Your Order ${state.response.data![widget.chosenOrder!].id} Have Been Placed',
                                style: TextStyle(color: Colors.grey,fontSize: 15.sp),)
                              ],),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(10.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Delivery Details',
                                  style: TextStyle(color: Colors.white,fontSize: 26.sp),),
                                SizedBox(height: 5.h,),
                                Row(
                                  children: [
                                    Text('Pickup Date : ',
                                    style: TextStyle(color: Colors.white),),
                                    Text(state.response.data![widget.chosenOrder!].actualDeliveryStartDateTime.toString(),
                                    style: TextStyle(color: Colors.white),)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Transportation Period : ',
                                    style: TextStyle(color: Colors.white),),
                                    Text(state.response.data![widget.chosenOrder!].deliveryDriverAssignedToTransportationPeriodId.toString(),
                                    style: TextStyle(color: Colors.white),)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Delivery Date : ',
                                    style: TextStyle(color: Colors.white),),
                                    Text(state.response.data![widget.chosenOrder!].deliveryDate.toString(),
                                    style: TextStyle(color: Colors.white),)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Delivery Driver : ',
                                    style: TextStyle(color: Colors.white),),
                                    Text(state.response.data![widget.chosenOrder!].deliveryDriverAssignedToTransportationPeriodId.toString(),
                                    style: TextStyle(color: Colors.white),)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Delivery Type : ',
                                    style: TextStyle(color: Colors.white),),
                                    Text(state.response.data![widget.chosenOrder!].type.toString(),
                                    style: TextStyle(color: Colors.white),)
                                  ],
                                ),
                                Divider(color: Colors.grey,),
                                Container(
                                  padding: EdgeInsets.all(7.sp),
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Order Details',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(0.5), // Shadow color
                                            offset: Offset(0, 5), // Specify the offset of the shadow
                                            blurRadius: 4, // Specify the blur radius of the shadow
                                          ),
                                        ],
                                      ),),
                                      Text(state.response.data![widget.chosenOrder!].clientOrder!.company!.nameEn.toString(),
                                        style: TextStyle(color: Colors.grey),),
                                    ],
                                  )
                                )
                      
                      
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 170.h,
                            width: double.infinity,
                            child: ListView.builder(
                                itemCount: state.response.data![widget.chosenOrder!].items?.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context,index){
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        // width:200.w,
                                        padding:EdgeInsets.only(left:10.sp),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(state.response.data![widget.chosenOrder!].items![index].name.toString(),
                                              style: TextStyle(color: Colors.white,fontSize: 13.sp),),
                                            Text(state.response.data![widget.chosenOrder!].items![index].name.toString(),
                                                style: TextStyle(color: Colors.grey,fontSize: 9.sp)),
                                            Row(
                                                children: [
                                                  Text("\$ "+state.response.data![widget.chosenOrder!].items![index].price.toString(),
                                                      style: TextStyle(color: Colors.white)),
                                                  SizedBox(width: 10.w,),
                                                  Text('Express',style: TextStyle(color: Color(0xff64ACDC)),)

                                                ]
                                            ),
                                            Row(
                                              children: [
                                                Text('Q: ',style: TextStyle(color: Colors.white)),
                                                Text(state.response.data![widget.chosenOrder!].items![index].quantity.toString(),
                                                    style: TextStyle(color: Colors.white)),
                                                Text(' item', style: TextStyle(color: Colors.white),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Container(
                                      //     padding: EdgeInsets.only(right:10.sp),
                                      //     height:100.h,
                                      //     width:100.w,
                                      //     child: Image.network(ApiUrls().imageApi+widget.orderDetails![widget.dataIndex!].order!.items![index].product!.imgPath.toString()
                                      //     )
                                      // )
                                    ],
                                  );
                                }),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5.sp,bottom: 5.sp,
                                left: 10.sp,right: 10.sp),
                            // margin: EdgeInsets.only(bottom: 15.sp),
                            decoration: BoxDecoration(
                              color: Color(0xff1D1D1D),

                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Order :",
                                      style: TextStyle(color: Colors.white,fontSize: 15.sp),
                                    ),
                                    Text("${state.response.data![widget.chosenOrder!].price} Aud",
                                      style: TextStyle(color: Colors.white,fontSize: 15.sp),),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Discount:",
                                      style: TextStyle(color: Colors.white,fontSize: 15.sp),),
                                    Text("0 Aud",
                                      style: TextStyle(color: Colors.white,fontSize: 15.sp),),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("VAT:",
                                      style: TextStyle(color: Colors.white,fontSize: 15.sp),),
                                    Text("0 Aud",
                                      style: TextStyle(color: Colors.white,fontSize: 15.sp),),
                                  ],
                                ),
                                Divider(color: Colors.white,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Summary:",
                                      style: TextStyle(color: Colors.white,fontSize: 15.sp),),
                                    Text("0 Aud",
                                      style: TextStyle(color: Colors.white,fontSize: 15.sp),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Payment Status',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.5), // Shadow color
                                      offset: Offset(0, 5), // Specify the offset of the shadow
                                      blurRadius: 4, // Specify the blur radius of the shadow
                                    ),
                                  ],
                                ),),
                                Text('Pending',style: TextStyle(color: Color(0xff64ACDC)),)
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ),
            );
          }
          else{
            return  SpinKitFadingCube(
              color: Color(0xffB4AFAF),
              size: 50.0,
            );          }
        },
    );
  }
}
