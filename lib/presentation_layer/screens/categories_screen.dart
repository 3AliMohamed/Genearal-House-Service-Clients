import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/categories/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/categories/states.dart';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/presentation_layer/screens/products_screen.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';
import 'package:general_house_service_clients/presentation_layer/screens/categories_company.dart';

import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../reusable/app_bar.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key, this.parentId, this.companyId,this.parentCatName});
  int? parentId;

  int? companyId ;
  String? parentCatName;

  @override
  Widget build(BuildContext context) {
    String currentLang = context.locale.toString();
    return BlocProvider(
      create: (context) {
        return CategoryCubit();
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
                    parentCatName==null ? 'All Categories' : parentCatName!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ).tr(),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 57.sp),
                  child: Container(
                    color: Color(0xff167279),
                    height: 6.h,
                    width: 70.w,
                  ),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                      height: 750.h,
                      width: double.infinity,
                      child: BlocConsumer<CategoryCubit, CategoryStates>(
                        listener: (context, state) {
                          if (state is LoadingErrorState) {
                            showToast(state.error);
                          }
                        },
                        builder: (context, state) {
                          if (state is InitialState) {
                            CategoryCubit.get(context).getCategory(
                                parentId: parentId, companyId: companyId);
                            return CircularProgressIndicator();
                          } else if (state is LoadedSuccessfullyState) {
                            // log("respo : "+ state.response.data.categories[0].nameEn.toString());
                            return GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return buildCategoryItem(
                                  // CategoryCubit.get(context).categoriesIdsWithSubCategories[parentId?.toInt()]![index].imgPath.toString(),
                                  // CategoryCubit.get(context).categoriesIdsWithSubCategories[parentId?.toInt()]![index].nameEn.toString(),
                                  state.response.data!.categories![index].imgPath.toString(),
                                  currentLang=='en'? state.response.data!.categories![index].nameEn.toString()
                                      : state.response.data!.categories![index].nameAr.toString(),

                                  () {
                                    // log("company id : " + companyId.toString());
                                    if (state.response.data!.categories![index].haveSubCategories! == 1) {
                                      // context.read<CategoryCubit>().emit(InitialState());
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen(
                                        parentId: state.response.data!.categories?[index].id?.toInt(),

                                        parentCatName: currentLang=='en'? state.response.data!.categories![index].nameEn.toString()
                                            : state.response.data!.categories![index].nameAr.toString(),
                                        companyId: companyId,
                                      )));
                                    } else {
                                      // if ccompanyId!null navigate to product direct with companyid this condition will apply if the user come from
                                      // home page with company id
                                      if(companyId != null) {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductsScreen(
                                                      companyId: companyId,
                                                      categoryId: state.response.data!
                                                          .categories?[index].id
                                                          ?.toInt(),)));
                                      }
                                      else {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CategoriesCompany(
                                                        id: state.response.data!
                                                            .categories?[index]
                                                            .id?.toInt())));
                                      }
                                        }
                                  },

                                );
                              },
                              itemCount:state.response.data!.categories!.length,
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      )),
                ),
              ],
            ),
          )),
    );
  }
}
