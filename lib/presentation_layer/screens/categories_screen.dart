import 'dart:developer';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/categories/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/categories/states.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:general_house_service_clients/presentation_layer/screens/products_screen.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';
import 'package:general_house_service_clients/presentation_layer/screens/categories_company.dart';
import 'package:get/get.dart';
import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../reusable/app_bar.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key, this.parentId, this.companyId,this.parentCatName});
  int? parentId;
String? currentLang = SharedPreferencesManager.getString('lang');
  int? companyId ;
  String? parentCatName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CategoryCubit();
      },
      child: Scaffold(
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
                    parentCatName==null ? Trans('All Categories').tr : parentCatName!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                      height: 770.h,
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
                            return  SpinKitFadingCube(
                              color: Color(0xffB4AFAF),
                              size: 50.0,
                            );
                          } else if (state is LoadedSuccessfullyState) {
                            // log("respo : "+ state.response.data.categories[0].nameEn.toString());
                            return  ListView.separated(
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
                                        log('comapny id');
                                        log(state.response.data!.categories![index].id.toString());
                                        log(companyId.toString());
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
                              separatorBuilder: (context,index){
                                return SizedBox(height: 30.h,);
                              },
                            );

                          } else {
                            return  SpinKitFadingCube(
                              color: Color(0xffB4AFAF),
                              size: 50.0,
                            );
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
