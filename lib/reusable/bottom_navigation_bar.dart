// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class MyBottomNavigationBar extends StatelessWidget {
//   final int selectedTab;
//   final Function(int) onTabTapped;
//
//   MyBottomNavigationBar({required this.selectedTab, required this.onTabTapped});
//
//   static void navigateOnTab(BuildContext context ,int index)
//   {
//       // Your navigation logic here
//       switch (index)
//       {
//         case 0:
//           Navigator.of(context).pushNamed('/about_us');
//           break;
//         case 1:
//           Navigator.of(context).pushNamed('/cart');
//           break;
//         case 2:
//           Navigator.of(context).pushNamed('/categories');
//           break;
//         case 3:
//           Navigator.of(context).pushNamed('/home');
//           break;
//       }
//
//   }
//   List<BottomNavigationBarItem> buildBottomNavItems() {
//     List<String> icons = [
//       'about_us_icon.png',
//       'cart_icon.png',
//       'categories_icon.png',
//       'home_icon.png',
//     ];
//
//     List<String> labels = [
//       'About Us',
//       'Cart',
//       'Categories',
//       'Home',
//     ];
//
//     List<BottomNavigationBarItem> items = List<BottomNavigationBarItem>.generate(
//       icons.length,
//           (index) {
//             print("$selectedTab == ${index.toString()} ${selectedTab == index}");
//         return BottomNavigationBarItem(
//         icon: Image.asset(
//           'assets/images/${icons[index]}',
//           width: 35.w,
//           color: selectedTab == index ? const Color(0XFF00B7E6) : Colors.white,
//         ),
//         label: labels[index],
//           );}
//     );
//
//     return items;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       selectedFontSize: 10.sp,
//       unselectedFontSize: 10.sp,
//       unselectedItemColor: Colors.blueGrey,
//       selectedIconTheme: IconThemeData(color: Colors.orangeAccent),
//       selectedItemColor: Colors.blueGrey,
//       type: BottomNavigationBarType.fixed,
//       backgroundColor: Color(0XFF202020),
//       items: buildBottomNavItems(),
//       currentIndex: selectedTab,
//       onTap: onTabTapped,
//     );
//   }
// }
