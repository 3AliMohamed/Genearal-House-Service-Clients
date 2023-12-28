import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/presentation_layer/screens/product_option_screen.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';

import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../business_logic_layer/cubit/getProducts/cubit.dart';
import '../../business_logic_layer/cubit/getProducts/states.dart';
import '../../reusable/app_bar.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key, this.id, this.categoryId, this.companyId});
  int? id;
  int? categoryId;
  int? companyId;
  @override
  Widget build(BuildContext context) {
    String currentLang = context.locale.toString();
    return BlocProvider(
      create: (context) {
        return ProductCubit();
      },
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: AppCubit.get(context).buildBottomNavItems(),
            onTap: (index) =>
                AppCubit.get(context).navigateOnTab(context, index),
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
                    id == null ? 'Products' : "Dynamic name",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ).tr(),
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
                BlocConsumer<ProductCubit,ProductStates>(
                    listener: (context,state){
                        if( state is LoadedErrorState)
                          {
                            showToast(state.error.toString());
                          }
                    },
                  builder: (context,state){
                      if(state is InitialState || state is LoadingState)
                        {
                          ProductCubit.get(context).getProduct(companyId!, categoryId!);
                          return CircularProgressIndicator();
                        }
                      else if(state is LoadedSuccessfullyState)
                        {
                          return SingleChildScrollView(
                            child: SizedBox(
                              height: 750.h,
                              width: 500.w,
                              child: GridView.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10.sp,
                                children: List.generate(state.products.length, (index) {
                                  return InkWell(
                                    onTap: () {
                                      // log("product id "+state.products[index].id!.toString());
                                      // log("length"+ProductCubit.get(context).optionsMap['26']!.length.toString());
                                      dynamic optionsMap=ProductCubit.get(context).optionsMap;
                                      // log(ProductCubit.get(context).optionsMap[state.products[index].id!.toString()]![0].nameEn.toString());
                                      // log(ProductCubit.get(context).optionsMap[productId.toString()]![0].nameEn.toString());

                                      // optionsMap.forEach((key, value) {
                                      //   print('Product ID: $key');
                                      //   print('Options:');
                                      //
                                      //   value.forEach((option) {
                                      //     print('Option ID: ${option.id}, Name (EN): ${option.nameEn}');
                                      //     // Print other option details as needed
                                      //   });
                                      //   print('-----------------');
                                      // });
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductOption(productId: state.products[index].id.toString(),
                                          optionsMap:optionsMap,companyId: companyId)));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 400.h,
                                        width: 100.w,
                                        child: Column(
                                          children: [
                                            state.products[index].imgPath==null?Image.asset(
                                              "assets/images/product.png",
                                              fit: BoxFit.fill,
                                              height: 155.h,
                                            ):
                                                Image.network(ApiUrls().imageApi+state.products[index].imgPath),
                                            Container(
                                                width: 160.w,
                                                height: 38.h,
                                                // padding: EdgeInsets.all(20)
                                                child: Center(
                                                    child: Text(currentLang=='en'?
                                                      state.products[index].nameEn.toString():
                                                      state.products[index].nameAr.toString(),
                                                      style: TextStyle(fontSize: 15.sp),
                                                    )),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.withOpacity(0.3),
                                                  borderRadius: BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0xff35737D)
                                                          .withOpacity(0.2),
                                                      spreadRadius: 5,
                                                      blurRadius: 5,
                                                      offset: Offset(0, 1),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          );
                        }
                      // else if(state is LoadedErrorState)
                      //   {
                      //     return Text(data)
                      //   }
                      else {
                        return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
