import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/app_cubit/states.dart';
import 'package:flutter/material.dart';
import '../../../presentation_layer/widgets/reusable_widgets.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit() :super (AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int selectedTap=3;


  // void changeBottomNavBar(int index)
  // {
  //   selectedTap=index;
  // }
   void navigateOnTab(BuildContext context,int index)
  {
    selectedTap=index;
    Navigator.of(context).pushNamed(screens[index]);
    emit(ChangeBottomNavBarState());
    emit(NavigateOnTapState());


  }
  List<String> screens=
  [
    '/about_us',
    '/cart',
    '/categories',
    '/home'
  ];


  List<BottomNavigationBarItem> buildBottomNavItems()
  {
    List<String> icons =
    [
      'about_us_icon.png',
      'cart_icon.png',
      'categories_icon.png',
      'home_icon.png',
    ];
    List<String> labels = [
    'About Us',
      'Cart',
      'Categories',
      'Home',
    ];
    List<BottomNavigationBarItem> items = List<BottomNavigationBarItem>.generate(
        icons.length,(index) {
      // print("$selectedTap == ${index.toString()} ${selectedTap == index}");
      return BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/${icons[index]}',
          width: 35.w,
          color: selectedTap == index ? const Color(0XFF00B7E6) : Colors.white,
        ),
        label: (labels[index]).tr(),
      );}
    );

    return items;
  }


}