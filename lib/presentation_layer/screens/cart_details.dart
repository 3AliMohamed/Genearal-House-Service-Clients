import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/cart/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/cart/states.dart';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:general_house_service_clients/presentation_layer/screens/checkout_screen.dart';
import 'package:get/get.dart';

import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../reusable/app_bar.dart';
import 'address.dart';

class CartDetails extends StatelessWidget {
   CartDetails({required this.dataIndex});

  @override
  late int dataIndex;
  List<String> orders=['1','2',];
  String price='3';
  String order_id='Order#3';
  List<String> options = [
    'ironing',
    'laundry',
    'ironing',
    'laundry',
    'ironing',
    'laundry',
  ];
  String? currentLang=SharedPreferencesManager.getString('lang');
  late String productImgPath;
  late int? priceItem;
  late int? totalPriceItem ;
  late int? quantity;
  // int? totalNumOfItems;
  String product='t-shirt Gray';
  String order_price='520';
  late String productNameEn;
  late String productNameAr;
  late String optionNameEn;
  late String optionNameAr;
  // int? comulativeTotalPrice=0;

  Widget build(BuildContext context) {

    return BlocConsumer<CartCubit,CartStates>(
        listener:(context,state)
        {

        },
        builder: (context,state)
        {
          int totalPrice=0;
          if (CartCubit.get(context).responseData != null &&
              dataIndex < CartCubit.get(context).responseData!.length) {
            for (var item in CartCubit.get(context).responseData![dataIndex].order?.items ?? []) {
              int? priceItem = item.product?.productOption?.price;
              int? quantity = item.product?.productOption?.quantity;
              if (priceItem != null && quantity != null) {
                totalPrice += priceItem * quantity;
              }
            }
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
                body: Container(
                    padding: EdgeInsets.only(top: 10.sp),
                    height: ScreenUtil().screenHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 700.h,
                            width: 450.w,
                            child: CartCubit.get(context).responseData![dataIndex].order!.items!.isNotEmpty? ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: CartCubit.get(context).responseData![dataIndex].order?.items?.length ?? 0, // Adjust the number of items as needed
                              itemBuilder: (BuildContext context, int index) {
                      
                                productImgPath=CartCubit.get(context).responseData![dataIndex].order!.items?[index].product?.imgPath ??'';
                                productNameEn=CartCubit.get(context).responseData![dataIndex].order!.items?[index].product?.nameEn??'';
                                productNameAr=CartCubit.get(context).responseData![dataIndex].order!.items?[index].product?.nameAr??'';
                                optionNameAr=CartCubit.get(context).responseData![dataIndex].order!.items?[index].product?.productOption?.nameAr??'';
                                optionNameEn=CartCubit.get(context).responseData![dataIndex].order!.items?[index].product?.productOption?.nameEn??'';
                                priceItem=CartCubit.get(context).responseData![dataIndex].order!.items?[index].product?.productOption?.price!;
                                quantity=CartCubit.get(context).responseData![dataIndex].order!.items?[index].product?.productOption?.quantity!;
                                totalPriceItem=(quantity! * priceItem!);
                      
                                // CartCubit.get(context).calculateTotal(totalPriceItem!);
                                return Container(
                                  height: 170.h,
                                  // width: 200.w,
                                  margin: EdgeInsets.all(10.sp),
                                  decoration: BoxDecoration(
                                      // color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.sp),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff0083F7),
                                        ),
                                        BoxShadow(
                                          color: Color.fromRGBO(0,0, 0, 0.9),
                                          spreadRadius: -3,
                                          blurRadius: 11,
                                          offset: Offset(2,2),
                                          // blurStyle: BlurStyle.solid
                                        )
                                      ]
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      productImgPath == '' ? Padding(
                                        padding: EdgeInsets.all(10.sp),
                                        child: Image.asset(
                                          'assets/images/pngwing.png', width: 120.w,
                                          height: 160.h,),
                                      )
                                          : Padding(
                                            padding:  EdgeInsets.all(5.sp),
                                            child: Image.network(
                                              ApiUrls().imageApi + productImgPath,fit: BoxFit.fitWidth,
                                              width: 90.w, height: 130.h,),
                                          ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:100.w,
                                            child: Text(
                                              currentLang == 'en' ? productNameEn +
                                                  " " + optionNameEn :
                                              productNameAr + " " + optionNameAr,
                                              maxLines:2,
                                              // overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Color(0xff318098)),
                                            ),
                                          ),
                                          Text(
                                            "\$" + priceItem.toString() + "/item",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          Text(totalPriceItem.toString(),
                                            style: TextStyle(color: Colors.white),
                                          ),

                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 78.sp, top: 10.sp),
                                            child: InkWell(
                                                onTap: () {
                                                  // Navigator.of(context).pushNamed('/loading_screen');
                                                },
                                                child: IconButton(
                                                  onPressed: () {
                                                    CartCubit.get(context).deleteItemFromCart(
                                                    CartCubit.get(context).responseData![dataIndex].orderId.toString(),
                                                        CartCubit.get(context).responseData![dataIndex].order!.items![index].product!.productOption!.id.toString());
                                                  },
                                                  icon: Icon(Icons.highlight_remove_rounded
                                                  ),)
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 35.sp,top: 30.sp),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  child: FloatingActionButton(
                                                      mini: true,
                                                      heroTag: 'add_button_$index',
                                                      backgroundColor: Colors
                                                          .black
                                                          .withOpacity(0.1),
                                                      onPressed: () {
                                                        CartCubit.get(context)
                                                            .incrementQuantity(
                                                            dataIndex, index);
                                                        // log("aldkla${optionsMap!['26']?[0].id}");
                                                      },
                                                      child: Container(
                                                        height: 20.h,
                                                        width: 20.w,
                                                        decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Color(0xff0083F7),
                                                            ),
                                                            BoxShadow(
                                                              color: Color.fromRGBO(0,0, 0, 0.9),
                                                              spreadRadius: -1,
                                                              blurRadius: 0,
                                                              offset: Offset(0,0),
                                                              // blurStyle: BlurStyle.solid
                                                            )
                                                          ],
                                                          shape: BoxShape.circle,
                                                          // color: Color(0xff0083F7), // Set the background color here
                                                        ),
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                          // Set the color of the icon
                                                          size: 15.sp,
                                                        ),
                                                      )
                                                  ),
                                                ),
                                                SizedBox(width: 10.w,),
                                                Text(quantity.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white),),
                                                SizedBox(width: 10.sp,),
                                                SizedBox(
                                                  width: 20.w,
                                                  // height: 20.h,
                                                  child: FloatingActionButton(
                                                      mini: true,
                                                      heroTag: 'remove_button_$index',
                                                      backgroundColor: Colors
                                                          .black
                                                          .withOpacity(0.1),
                                                      foregroundColor: Colors
                                                          .white,
                                                      onPressed: () {
                                                        CartCubit.get(context).decrementQuantity(dataIndex, index);
                                                        // log("aldkla${optionsMap!['26']?[0].id}");
                                                      },
                                                      child: Container(
                                                        height: 20.h,
                                                        width: 20.w,
                                                        decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Color(
                                                                  0xff0083F7),
                                                              // Specify the shadow color here
                                                              blurRadius: 1,
                                                              // Adjust the blur radius as needed
                                                              spreadRadius: 1,
                                                              // Adjust the spread radius as needed
                                                              offset: Offset(0,
                                                                  0), // Adjust the offset of the shadow
                                                            ),
                                                          ],
                                                          shape: BoxShape.circle,
                                                          color: Colors
                                                              .black, // Set the background color here
                                                        ),
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                          // Set the color of the icon
                                                          size: 15.sp,
                                                        ),
                                                      )
                                                  ),
                                                ),
                                              ],
                                            ),
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
                            ):Container(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Price (${CartCubit.get(context).responseData![dataIndex].order?.items?.length}) :",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                              Text("\$ $totalPrice",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                      
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              dynamic orderDetails=CartCubit.get(context).responseData;
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Address(orderDetails: orderDetails,dataIndex: dataIndex,)));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10.sp,top: 10.sp),
                              padding: EdgeInsets.all(4.sp),
                              width: 300.w,
                              height: 40.h,
                              decoration:  BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff0083F7),
                                  ),
                                  BoxShadow(
                                    color: Color.fromRGBO(0,0, 0, 0.9),
                                    spreadRadius: -1,
                                    blurRadius: 17,
                                    offset: Offset(2,2),
                                    // blurStyle: BlurStyle.solid
                                  )
                                ],
                                // color: Color(0xff157A82),
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: Text(Trans('Check Out').tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                )
            );
          }else{
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
          appBar: CustomAppBar(),
          body: Container());
          }
          }
    );}
  }

