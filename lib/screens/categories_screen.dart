import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/categories/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/categories/states.dart';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/data_layer/repository/category_repository.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';
import 'package:general_house_service_clients/screens/categories_company.dart';

import '../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../reusable/app_bar.dart';
import '../reusable/bottom_navigation_bar.dart';

class CategoriesScreen extends StatelessWidget
{
  CategoriesScreen({Key? key, this.parentId,this.companyId});
  int? parentId=24;

  int? companyId=24;

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
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              Container(
                child: Text(
                   'All Categories$parentId',
                  style: TextStyle(color: Colors.white, fontSize: 20.sp,fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 57.sp),
                child:Container(
                  color: Color(0xff167279),
                  height: 6.h,
                  width: 70.w ,
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: 750.h,
                  width: double.infinity,
                  child: BlocConsumer<CategoryCubit,CategoryStates>(
                    listener: (context,state){
                      if( state is CategoryLoadErrorState){
                        showToast(state.error);
                      }
                    },
                    builder: (context,state){
                      if (state is CategoryInitialState){
                        log("id inside builder ::"+parentId.toString());
                          CategoryCubit.get(context).getCategory(parentId:parentId,companyId:companyId);
                          return CircularProgressIndicator();
                      }
                      else if(state is CategoryLoadedSuccessState)
                        {
                          log("inside category state");
                          // log("respo : "+ state.response.data.categories[0].nameEn.toString());
                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return buildCategoryItem(
                                  state.response.data!.categories![index].imgPath.toString(),
                                  state.response.data!.categories![index].nameEn.toString(),
                                  () {
                                    log("have sub cat :" +state.response.data!.categories![index].haveSubCategories.toString());
                                    if(state.response.data!.categories![index].haveSubCategories! == 1){ 
                                      log("id befor navigate :" +state.response.data!.categories![index].id.toString());
                                      context.read<CategoryCubit>().emit(CategoryInitialState());
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => CategoriesScreen(parentId:state.response.data!.categories![index].id)));
                                    } else{
                                      // if ccompanyId!null navigate to product direct with companyid this condition will apply if the user come from
                                      // home page with company id
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => CategoriesCompany(id: state.response.data!.categories![index].id)));
                                    }
                                  },
                              // "${ApiUrls().apiUrl}${CategoryCubit.get(context).categories[index]['img_path']}",
                              // CategoryCubit.get(context).categories[index]['name_ar'],
                              //     (){}
                              );
                            },
                            itemCount: state.response.data?.categories?.length,
                          );

                        }
                      else if(state is CategoryWithParentLoadedSuccessState)
                          {
                            log("inside category with parent");
                            return GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return buildCategoryItem(
                                  state.response.data!.categories![index].imgPath.toString(),
                                  state.response.data!.categories![index].nameEn.toString(),
                                      () {
                                    if(state.response.data!.categories![index].haveSubCategories! == 1){
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => CategoriesScreen(parentId:state.response.data!.categories![index].id)));
                                    } else{
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => CategoriesCompany(id: state.response.data!.categories![index].id)));
                                    }
                                  },
                                  // "${ApiUrls().apiUrl}${CategoryCubit.get(context).categories[index]['img_path']}",
                                  // CategoryCubit.get(context).categories[index]['name_ar'],
                                  //     (){}
                                );
                              },
                              itemCount: state.response.data?.categories?.length,
                            );
                          }
                      else{
                        return Text("error");
                      }
                    },
                  )
                ),
              ),
            ],
          ),
        ));
  }
}




