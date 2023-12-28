import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';
import 'package:get/get.dart';

import '../../business_logic_layer/cubit/addProduct/add_product_cubit.dart';
import '../../business_logic_layer/cubit/addProduct/add_product_states.dart';
import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../data_layer/models/product_reposnse.dart';
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
    String currentLang = context.locale.toString();
 return  BlocConsumer<AddProductCubit,AddProductStates>
   (listener: (context,state){
     if (state is PlacedSuccessfullyState)
       {
         showToast("successfully Added");
       }
        },
        builder: (context,state){
        if(state is PlacingOrderState)
          {return CircularProgressIndicator();}
        else {
          return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                items: AppCubit.get(context).buildBottomNavItems(),
                onTap: (index) =>
                    AppCubit.get(context).navigateOnTab(context, index),
                currentIndex: AppCubit
                    .get(context)
                    .selectedTap,
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
                                                  child: BlocBuilder<
                                                      AddProductCubit,
                                                      AddProductStates>(
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
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ).tr(),
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
                                                    'Done',
                                                    style: TextStyle(
                                                      color: Color(
                                                          0XFF0EC2D1),),
                                                  ).tr(),
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
                              AddProductCubit.get(context).addOrder(companyId);

                              // Navigator.of(context).pushNamed("/cart");
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff16747C),
                              onPrimary: Colors.white,
                              elevation: 10,
                              shadowColor: Color(0xff16747C),
                            ),
                            child: Container(
                              child: Text('Add',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                ),
                              ).tr(),
                            )
                        ),
                      ),
                    ]),
              ));
        }},
      );
  }
}


