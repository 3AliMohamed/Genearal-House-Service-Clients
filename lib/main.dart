import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/app_cubit/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/register/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/authentication/update_profile/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/cart/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/categories/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/getProducts/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/home_page/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/my_orders/cubit.dart';
import 'package:general_house_service_clients/data_layer/repository/authentication/login_repository.dart';
import 'package:general_house_service_clients/data_layer/web_services/authentication/login_web_services.dart';
import 'package:general_house_service_clients/presentation_layer/screens/categories_company.dart';
import 'package:general_house_service_clients/presentation_layer/screens/categories_screen.dart';
import 'package:general_house_service_clients/presentation_layer/screens/drawer_screen.dart';
import 'package:general_house_service_clients/presentation_layer/screens/home_screen.dart';
import 'package:general_house_service_clients/presentation_layer/screens/product_option_screen.dart';
import 'package:general_house_service_clients/presentation_layer/screens/products_screen.dart';
import 'package:general_house_service_clients/presentation_layer/screens/ForgetPassword.dart';
import 'package:general_house_service_clients/presentation_layer/screens/Login_screen.dart';
import 'package:general_house_service_clients/presentation_layer/screens/ResetPassword.dart';
import 'package:general_house_service_clients/presentation_layer/screens/SignUp.dart';
import 'package:general_house_service_clients/screens/Verification.dart';
import 'package:general_house_service_clients/screens/about_us_screen.dart';
import 'package:general_house_service_clients/presentation_layer/screens/add_new_address.dart';
import 'package:general_house_service_clients/presentation_layer/screens/address.dart';
import 'package:general_house_service_clients/presentation_layer/screens/cart_screen.dart';
import 'package:general_house_service_clients/presentation_layer/screens/checkout_screen.dart';
import 'package:general_house_service_clients/presentation_layer/screens/choose_from_map.dart';
import 'package:general_house_service_clients/screens/loading_screen.dart';
import 'package:general_house_service_clients/presentation_layer/screens/my_orders_screen.dart';
import 'package:general_house_service_clients/presentation_layer/screens/order_details.dart';
import 'package:general_house_service_clients/presentation_layer/screens/profile_screen.dart';
import 'package:general_house_service_clients/screens/rate_order.dart';
import 'package:general_house_service_clients/shared/bloc_observer.dart';
import 'package:general_house_service_clients/screens/splash_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'business_logic_layer/cubit/addProduct/add_product_cubit.dart';
import 'business_logic_layer/cubit/authentication/get_profile/cubit.dart';
import 'business_logic_layer/cubit/authentication/login_cubit/cubit.dart';
import 'business_logic_layer/cubit/authentication/logout/cubit.dart';
import 'business_logic_layer/cubit/company/cubit.dart';
import 'constants/LocalString.dart';
import 'helpers/SharedPrefManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await SharedPreferencesManager.init();
  // authenticationRepository= AuthenticationRepository(AuthenticationWebServices());

  // AuthenticationWebServices.login('mahmoud@gmail.com', 'test');
  runApp(
    MyApp(),
  );
  SharedPreferencesManager.init();


}

class MyApp extends StatelessWidget {
  late LogInRepository loginRepository;
  String? lang=SharedPreferencesManager.getString('lang');
  MyApp(){
    loginRepository=LogInRepository(LogInWebServices());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 1004),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return MultiBlocProvider(
        providers:
        [
          BlocProvider(create: (context) => AppCubit()),
          BlocProvider(create: (context) => LogInCubit(loginRepository)),
          BlocProvider(create: (context) => RegisterCubit()),
          BlocProvider(create: (context) => HomePageCubit()),
          BlocProvider(create: (context) => CompanyCubit()),
          BlocProvider(create: (context) => AddProductCubit()),
          BlocProvider(create: (context) => LogoutCubit()),
          BlocProvider(create: (context) => ProfileCubit()),
          BlocProvider(create: (context) => UpdateProfileCubit()),
          BlocProvider(create: (context) => CartCubit()),
          BlocProvider(create: (context) => MyOrdersCubit()),
          // BlocProvider(create: (context) => ProductCubit()),
          BlocProvider(create: (context) => AddProductCubit()),


          // BlocProvider.value(value: LanguageCubit()),

        ],
        child: GetMaterialApp(
              translations: LocalString(),
              locale: Locale(lang!),
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
              routes: {
                '/categories': (context) => CategoriesScreen(),
                '/home': (context) => HomeScreen(),
                '/about_us': (context) => AboutUs(),
                '/login': (context) => LoginPage(),
                '/signup': (context) => SignupPage(),
                '/forget_password': (context) => Forgetpassword(),
                // '/reset_password': (context) => Resetpassword(),
                '/verification': (context) => Verificationcode(),
                '/categories_company': (context) => CategoriesCompany(),
                '/products': (context) => ProductsScreen(),
                '/product_option': (context) => ProductOption(),
                '/cart': (context) => const CartScreen(),
                '/loading_screen': (context) => const LoadingScreen(),
                '/drawer_screen': (context) => const DrawerScreen(),
                '/profile': (context) => const Profile(),
                '/my_orders': (context) => const MyOrders(),
                '/add_new_address': (context) => const AddNewAddress(),
                '/rate_order': (context) => const RateOrder(),
                // '/checkout': (context) => const CheckOut(),
                '/address': (context) =>  Address(),
                '/order_details': (context) =>  OrderDetails(),
                '/choose_from_map': (context) => ChooseFromMap(),

              },
            ),
        );
    }
    );

  }
}




