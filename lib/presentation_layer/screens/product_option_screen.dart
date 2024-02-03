import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';
import 'package:get/get.dart';

import '../../business_logic_layer/cubit/addProduct/add_product_cubit.dart';
import '../../business_logic_layer/cubit/addProduct/add_product_states.dart';
import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../business_logic_layer/cubit/cart/cubit.dart';
import '../../data_layer/models/responses/product_reposnse.dart';
import '../../data_layer/models/requests/AddItemToOrderRequest.dart';
import '../../helpers/SharedPrefManager.dart';
import '../../reusable/app_bar.dart';

class ProductOption extends StatelessWidget {
   ProductOption({Key? key,this.productId,this.optionsMap,this.companyId}) ;
   List<List<Map<String, int>>> lsiOfProductOrders = [];
   @override
  Map<String, List<Options>> ? optionsMap = {};
  // String? chosenOption;
   String? productId;
   int? companyId;
  String product_name = 'T-shirt black Size (M)';


  @override
  Widget build(BuildContext context) {
    String? currentLang = SharedPreferencesManager.getString('lang');
 return  BlocConsumer<AddProductCubit,AddProductStates>
   (listener: (context,state){
     if (state is PlacedSuccessfullyState)
       {
         showToast("successfully Added");
       }
        },
        builder: (context,state){
        if(state is PlacingOrderState)
          {return  SpinKitFadingCube(
            color: Color(0xffB4AFAF),
            size: 50.0,
          );}
        else {
          return Scaffold(
              bottomNavigationBar:Container(
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
                          //ProductCubit.get(context).optionsMap[productId]!.length,
                          itemCount: optionsMap?[productId]?.length,
                          // Adjust the number of items as needed
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                // AddProductCubit.get(context).chosenItem.clear();
                                showDialog(
                                  context: context,
                                  builder: (_) =>
                                      AlertDialog(
                                        title: Center(child: Text(currentLang=='en'?
                                          optionsMap![productId]![index].nameEn!
                                            :optionsMap![productId]![index].nameAr!,)),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                //
                                                FloatingActionButton.small(
                                                  heroTag: 'btn1',
                                                  backgroundColor: Colors.black
                                                      .withOpacity(0.1),
                                                  foregroundColor: Colors.white,
                                                  onPressed: () {
                                                    // log("aldkla${optionsMap!['26']?[0].id}");
                                                    AddProductCubit.get(context)
                                                        .incrementQuantity();
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
                                                    borderRadius: BorderRadius
                                                        .circular(2),
                                                  ),
                                                  width: 30.w,
                                                  child: BlocBuilder<AddProductCubit, AddProductStates>(
                                                    builder: (context, state) {
                                                      return Center(
                                                        child: Text(
                                                          "${AddProductCubit
                                                              .get(context)
                                                              .quantity}",
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                FloatingActionButton.small(
                                                  heroTag: 'btn2',
                                                  backgroundColor: Colors.black
                                                      .withOpacity(0.1),
                                                  foregroundColor: Colors.white,
                                                  onPressed: () {
                                                    AddProductCubit.get(context)
                                                        .decrementQuantity();
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    Trans('Cancel').tr,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                SizedBox(width: 16.w),
                                                TextButton(
                                                  onPressed: () {
                                                    AddProductCubit.get(context)
                                                        .addOption(
                                                        optionsMap![productId]![index]
                                                            .id, AddProductCubit
                                                        .get(context)
                                                        .quantity);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                   Trans('Done').tr,
                                                    style: TextStyle(
                                                      color: Color(
                                                          0XFF0EC2D1),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 75.w,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffD6E3EC),

                                ),
                                child: Text(currentLang=='en'?
                                    optionsMap![productId]![index].nameEn.toString():
                                optionsMap![productId]![index].nameAr.toString()
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 220.h,
                      ),
                      Container(

                        margin: EdgeInsets.only(left: 80.sp, right: SharedPreferencesManager.getString('lang')=='English'? 0.sp:70.sp),
                        width: 280.w,
                        child: ElevatedButton
                          (
                            onPressed: () {
                              if(SharedPreferencesManager.containKey('token')==true) {
                                log("token");
                                final cartCubit = BlocProvider.of<CartCubit>(context);
                                cartCubit.reset(); // Call the reset function
                                // AddProductCubit.get(context).addOrder(
                                //     companyId);
                              }else{
                                log('not token');
                                showToast('You Should Log In First');
                              }
                              // Navigator.of(context).pushNamed("/cart");
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff16747C),
                              onPrimary: Colors.white,
                              elevation: 10,
                              shadowColor: Color(0xff16747C),
                            ),
                            child: Container(
                              child: Text(Trans('Add').tr,
                                style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            )
                        ),
                      ),
                    ]),
              ));
        }},
      );
  }
}


