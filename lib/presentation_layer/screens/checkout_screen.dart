import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/checkOut/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/checkOut/states.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/promo_code/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/promo_code/states.dart';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/data_layer/models/responses/cart_response.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;

import 'package:date_format/date_format.dart' as dateFormatter;
import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../business_logic_layer/cubit/cart/cubit.dart';
import '../../reusable/app_bar.dart';

class CheckOut extends StatefulWidget {
  final List<Data>? orderDetails;
  Map<String,dynamic>? chosenAddress;
 final int? dataIndex;
   CheckOut({Key? key,this.orderDetails, this.dataIndex,this.chosenAddress}) : super(key: key);


   @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> with TickerProviderStateMixin{
  late AnimationController _animationController;
  TextEditingController instructions_controller= TextEditingController();
  String? selectedValue = null ;
  List<String> items = ['car','onfoot'];
  int selectedTab = 1;

  String product_name='t-shirt black';
  String product_option='ironing';
  List<String> chosen_location_logo=['apartment_logo.png','home.png','office_white.png',];
  List <String> chosen_location=['House','Apartment','Office'];
  Map<String,String> locationType={
    'apartment': 'assets/images/apartment_logo.png',
    'house' : 'assets/images/home.png',
    'office':'assets/images/office_white.png',
    'other':''
  };
  int quantity=0;
  int product_price=300;
  int total=0;
  num? totalOrderPrice=0;
  String? currentLang=SharedPreferencesManager.getString('lang');
  // List<TransportationPeriodData> transportationPeriodPickupList = [];
  Map<String, List<dynamic>> products = {
    'productsAr': [],
    'productsEn': [],
    'quantity': [],
    'prices': [],
    'optionsAr': [],
    'optionsEn': [],
    'totalPrice': [],
    'optionsIds':[],
    'orderId':[],
    'clientId':[],
    'specialInstruction':[],
    'comment':[],
    'companyId':[],
    'deliveryTypeId':[],
    'locationId':[]
  };
  TextEditingController promoCodeController=TextEditingController();
  @override
  void initState() {
    super.initState();
    // if(widget.chosenAddress!.isEmpty){
    //   widget.chosenAddress={
    //     'id':'',
    //     'locationType':'',
    //     'detailedAddress':''
    //   };
    // }
    // Initialize the variableToUse in initState
    _animationController = AnimationController(
      vsync: this, // Use 'this' as the TickerProvider
      duration: const Duration(milliseconds: 1200),
    );
    log(widget.chosenAddress.toString());
    for(int i=0;i<widget.orderDetails![widget.dataIndex!].order!.items!.length;i++)
      {
        products['productsAr']?.add(widget.orderDetails![widget.dataIndex!].order!.items![i].product!.nameAr);
        products['productsEn']?.add(widget.orderDetails![widget.dataIndex!].order!.items![i].product!.nameEn);
        products['quantity']?.add(widget.orderDetails![widget.dataIndex!].order!.items![i].product!.productOption!.quantity);
        products['prices']?.add(widget.orderDetails![widget.dataIndex!].order!.items![i].product!.productOption!.price);
        products['optionsAr']?.add(widget.orderDetails![widget.dataIndex!].order!.items![i].product!.productOption!.nameAr);
        products['optionsEn']?.add(widget.orderDetails![widget.dataIndex!].order!.items![i].product!.productOption!.nameEn);
        products['totalPrice']?.add(products['quantity']?[i]*products['prices']?[i]);
        products['optionsIds']?.add(widget.orderDetails![widget.dataIndex!].order!.items![i].product!.productOption!.id.toString());

      }
      products['clientId']?.add('35');
      products['specialInstruction']?.add('make the right thing');
      products['comment']?.add('should work hard');
      products['companyId']?.add(widget.orderDetails![widget.dataIndex!].company!.userId.toString());
      products['deliveryTypeId']?.add('16');
      products['orderId']?.add(widget.orderDetails![widget.dataIndex!].order!.id.toString());
      products['locationId']?.add('52');

    @override
    void dispose() {
      _animationController.dispose();
      // ... dispose of other resources ...
      super.dispose();
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>CheckOutCubit(),
        child: BlocConsumer<CheckOutCubit,CheckOutStates>(
          listener:(context,state){

          },
        builder: (context,state){
          totalOrderPrice= CheckOutCubit.get(context).calculateTotalOrderPrice(products['totalPrice']!);
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
                  height: ScreenUtil().screenHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:  EdgeInsets.only(right: 380.sp),
                          child: IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: Icon(
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5), // Shadow color
                                offset: Offset(0, 7), // Specify the offset of the shadow
                                blurRadius: 4, // Specify the blur radius of the shadow
                              ),
                            ],
                            Icons.arrow_back_sharp,
                            color: Colors.white,
                          )),
                        ),
                        Text(
                          'Checkout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5), // Shadow color
                                offset: Offset(0, 10), // Specify the offset of the shadow
                                blurRadius: 4, // Specify the blur radius of the shadow
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: 10.h,),
                        Container(
                          height: 70.h,
                          width: double.infinity,
                          margin: EdgeInsets.all(8.sp),
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                              color: Color(0xff1D1D1D),
                              borderRadius: BorderRadius.circular(12.sp)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order Details',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5), // Shadow color
                                    offset: Offset(0, 5), // Specify the offset of the shadow
                                    blurRadius: 4, // Specify the blur radius of the shadow
                                  ),
                                ],
                              ),),
                              Text(widget.orderDetails![widget.dataIndex!].company!.nameEn.toString(),
                              style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 200.h,
                          width: double.infinity,
                          child: ListView.builder(
                              itemCount: widget.orderDetails![widget.dataIndex!].order?.items?.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context,index){
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      // width:200.w,
                                      padding:EdgeInsets.only(left:10.sp),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(products['productsEn']?[index],
                                            style: TextStyle(color: Colors.white),),
                                          Text(products['optionsEn']?[index],
                                              style: TextStyle(color: Colors.white)),
                                          Row(
                                            children: [
                                              Text(products['prices']![index].toString() ,
                                                  style: TextStyle(color: Colors.white)),
                                              SizedBox(width: 10.w,),
                                              Text('Express',style: TextStyle(color: Color(0xff64ACDC)),)

                                            ]
                                          ),
                                          Text(products['quantity']![index].toString(),
                                              style: TextStyle(color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right:10.sp),
                                      height:100.h,
                                      width:100.w,
                                      child: Image.network(ApiUrls().imageApi+widget.orderDetails![widget.dataIndex!].order!.items![index].product!.imgPath.toString()
                                      )
                                    )],
                                );
                              }),
                        ),
                        BlocConsumer<PromoCodeCubit,PromoCodeStates>(
                            builder: (context,state){
                              PromoCodeCubit.get(context).calculateTotalOrderPrice(totalOrderPrice!);
                              if(state is PromoCodeLoadingState){
                                return SpinKitFadingCircle(
                                  color: Colors.grey,
                                  size: 50.0,
                                  controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                                );
                              }
                              else {
                                return Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(5.sp),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                          ),
                                          BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.9),
                                            spreadRadius: -1,
                                            blurRadius: 3,
                                            offset: Offset(0, 0),
                                            // blurStyle: BlurStyle.solid
                                          )
                                        ],
                                        // border: Border.all(color: Colors.white,width: 2.sp,),
                                        borderRadius: BorderRadius.circular(
                                            5.sp),

                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 320.w,

                                            child: TextFormField(
                                              decoration: InputDecoration(

                                                contentPadding: EdgeInsets.only(
                                                    left: 10.sp),
                                                hintText: 'Do You Have A Promo Code ?',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              // textAlign: TextAlign.center,
                                              controller: promoCodeController,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              // onChanged: (value) => ,

                                            ),
                                          ),
                                          TextButton(onPressed: () {
                                            PromoCodeCubit.get(context)
                                                .tryPromoCode(
                                                products['orderId']![0]
                                                    .toString(),
                                                promoCodeController.text,
                                                products['companyId']![0]
                                                    .toString(),
                                                totalOrderPrice!);
                                          },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        left: BorderSide(
                                                          color: Colors.white,
                                                          width: 2,
                                                        )
                                                    )
                                                ),
                                                padding: EdgeInsets.only(
                                                    left: 10.sp),
                                                child: Text('Apply',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h,),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 5.sp, bottom: 5.sp,
                                          left: 5.sp, right: 5.sp),
                                      // margin: EdgeInsets.only(bottom: 15.sp),
                                      decoration: BoxDecoration(
                                        color: Color(0xff1D1D1D),

                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text("Order :",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.sp),
                                              ),
                                              Text("$totalOrderPrice Aud",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.sp),),
                                            ],
                                          ),
                                          SizedBox(height: 5.h,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Discount:",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.sp),),
                                              Text("${PromoCodeCubit
                                                  .get(context)
                                                  .discount} Aud",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.sp),),
                                            ],
                                          ),
                                          SizedBox(height: 5.h,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text("VAT:",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.sp),),
                                              Text("$total Aud",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.sp),),
                                            ],
                                          ), SizedBox(height: 5.h,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text("Delivery Fess:",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.sp),),
                                              Text("0 Aud",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.sp),),
                                            ],
                                          ),
                                          Divider(color: Colors.white,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text("Summary:",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.sp),),
                                              Text("${PromoCodeCubit
                                                  .get(context)
                                                  .totalOrderPrice} Aud",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.sp),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }, listener: (context,state){

                        }),
                        SizedBox(height: 10.h,),
                        Container(
                          padding: EdgeInsets.only(left: 10.sp),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Shipping Address ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.5), // Shadow color
                                          offset: Offset(0, 10), // Specify the offset of the shadow
                                          blurRadius: 4, // Specify the blur radius of the shadow
                                        ),
                                      ],
                                    ),),
                                  Image.asset(locationType[widget.chosenAddress?['locationType']]!,width: 30.w,height: 30.h,),
                                ],
                              ),
                              Text(widget.chosenAddress?['detailedAddress']!,
                              style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h,),
                        Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 10.sp),
                            child: Text("Shipment Details",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,
                             fontSize: 20.sp, shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5), // Shadow color
                                  offset: Offset(0, 10), // Specify the offset of the shadow
                                  blurRadius: 4, // Specify the blur radius of the shadow
                                ),
                              ],),)),
                        SizedBox(height: 10.h,),
                        Container(
                          width: 400.w,
                          height: 50.h,
                          padding: EdgeInsets.only(left:10.sp,right: 10.sp),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                              ),
                              BoxShadow(
                                color: Color(0xff1D1D1D),
                                spreadRadius: -1,
                                blurRadius: 10,
                                offset: Offset(0,0),
                                // blurStyle: BlurStyle.solid
                              )
                            ],
                            // border: Border.all(color: Colors.white,width: 2.sp,),
                            borderRadius: BorderRadius.circular(10.sp),

                          ),
                          child:   DropdownButton<String>(
                            hint: Text('Pickup Date',style: TextStyle(color: Colors.white,),),
                            style: TextStyle(
                              color: Colors.white, // Text color
                              fontSize: 16.0, // Text size
                            ),
                            value: selectedValue,
                            onChanged: (value){

                            },
                            underline: Container(  // Remove underline border
                              decoration: BoxDecoration(
                                border: Border.all(width: 0), // Transparent border
                              )),
                            isExpanded: true,  // Make the dropdown button take the full width
                            icon: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white),  // Customizing the dropdown arrow
                            iconSize: 24.0,  // Adjust the icon size as needed
                            iconEnabledColor: Colors.white,  // Set the color of the enabled icon
                            dropdownColor: Color(0xff1D1D1D),  // Set the color of the dropdown list
                            items:  items.map((String item) => DropdownMenuItem(
                              value: item,
                              child: Text(item,style: TextStyle(color: Colors.white)),
                            )).toList(),
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Container(
                          width: 400.w,
                          height: 50.h,
                          padding: EdgeInsets.only(left:10.sp,right: 10.sp),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                              ),
                              BoxShadow(
                                color: Color(0xff1D1D1D),
                                spreadRadius: -1,
                                blurRadius: 10,
                                offset: Offset(0,0),
                                // blurStyle: BlurStyle.solid
                              )
                            ],
                            // border: Border.all(color: Colors.white,width: 2.sp,),
                            borderRadius: BorderRadius.circular(10.sp),

                          ),
                          child:   DropdownButton<String>(
                            hint: Text('Pickup Date',style: TextStyle(color: Colors.white,),),
                            style: TextStyle(
                              color: Colors.white, // Text color
                              fontSize: 16.0, // Text size
                            ),
                            value: selectedValue,
                            onChanged: (value){

                            },
                            underline: Container(  // Remove underline border
                              decoration: BoxDecoration(
                                border: Border.all(width: 0), // Transparent border
                              )),
                            isExpanded: true,  // Make the dropdown button take the full width
                            icon: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white),  // Customizing the dropdown arrow
                            iconSize: 24.0,  // Adjust the icon size as needed
                            iconEnabledColor: Colors.white,  // Set the color of the enabled icon
                            dropdownColor: Color(0xff1D1D1D),  // Set the color of the dropdown list
                            items:  items.map((String item) => DropdownMenuItem(
                              value: item,
                              child: Text(item,style: TextStyle(color: Colors.white)),
                            )).toList(),
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Container(
                          width: 400.w,
                          height: 50.h,
                          padding: EdgeInsets.only(left:10.sp,right: 10.sp),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                              ),
                              BoxShadow(
                                color: Color(0xff1D1D1D),
                                spreadRadius: -1,
                                blurRadius: 10,
                                offset: Offset(0,0),
                                // blurStyle: BlurStyle.solid
                              )
                            ],
                            // border: Border.all(color: Colors.white,width: 2.sp,),
                            borderRadius: BorderRadius.circular(10.sp),

                          ),
                          child:   DropdownButton<String>(
                            hint: Text('Transportation Period',style: TextStyle(color: Colors.white,),),
                            style: TextStyle(
                              color: Colors.white, // Text color
                              fontSize: 16.0, // Text size
                            ),
                            value: selectedValue,
                            onChanged: (value){

                            },
                            underline: Container(  // Remove underline border
                              decoration: BoxDecoration(
                                border: Border.all(width: 0), // Transparent border
                              )),
                            isExpanded: true,  // Make the dropdown button take the full width
                            icon: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white),  // Customizing the dropdown arrow
                            iconSize: 24.0,  // Adjust the icon size as needed
                            iconEnabledColor: Colors.white,  // Set the color of the enabled icon
                            dropdownColor: Color(0xff1D1D1D),  // Set the color of the dropdown list
                            items:  items.map((String item) => DropdownMenuItem(
                              value: item,
                              child: Text(item,style: TextStyle(color: Colors.white)),
                            )).toList(),
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Container(
                          width: 400.w,
                          height: 50.h,
                          padding: EdgeInsets.only(left:10.sp,right: 10.sp),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                              ),
                              BoxShadow(
                                color: Color(0xff1D1D1D),
                                spreadRadius: -1,
                                blurRadius: 10,
                                offset: Offset(0,0),
                                // blurStyle: BlurStyle.solid
                              )
                            ],
                            // border: Border.all(color: Colors.white,width: 2.sp,),
                            borderRadius: BorderRadius.circular(10.sp),

                          ),
                          child:   DropdownButton<String>(
                            hint: Text('Delivery Date',style: TextStyle(color: Colors.white,),),
                            style: TextStyle(
                              color: Colors.white, // Text color
                              fontSize: 16.0, // Text size
                            ),
                            value: selectedValue,
                            onChanged: (value){

                            },
                            underline: Container(  // Remove underline border
                              decoration: BoxDecoration(
                                border: Border.all(width: 0), // Transparent border
                              )),
                            isExpanded: true,  // Make the dropdown button take the full width
                            icon: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white),  // Customizing the dropdown arrow
                            iconSize: 24.0,  // Adjust the icon size as needed
                            iconEnabledColor: Colors.white,  // Set the color of the enabled icon
                            dropdownColor: Color(0xff1D1D1D),  // Set the color of the dropdown list
                            items:  items.map((String item) => DropdownMenuItem(
                              value: item,
                              child: Text(item,style: TextStyle(color: Colors.white)),
                            )).toList(),
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Container(
                          width: 400.w,
                          height: 50.h,
                          padding: EdgeInsets.only(left:10.sp,right: 10.sp),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                              ),
                              BoxShadow(
                                color: Color(0xff1D1D1D),
                                spreadRadius: -1,
                                blurRadius: 10,
                                offset: Offset(0,0),
                                // blurStyle: BlurStyle.solid
                              )
                            ],
                            // border: Border.all(color: Colors.white,width: 2.sp,),
                            borderRadius: BorderRadius.circular(10.sp),

                          ),
                          child:   DropdownButton<String>(
                            hint: Text('Pickup Driver',style: TextStyle(color: Colors.white,),),
                            style: TextStyle(
                              color: Colors.white, // Text color
                              fontSize: 16.0, // Text size
                            ),
                            value: selectedValue,
                            onChanged: (value){

                            },
                            underline: Container(  // Remove underline border
                              decoration: BoxDecoration(
                                border: Border.all(width: 0), // Transparent border
                              )),
                            isExpanded: true,  // Make the dropdown button take the full width
                            icon: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white),  // Customizing the dropdown arrow
                            iconSize: 24.0,  // Adjust the icon size as needed
                            iconEnabledColor: Colors.white,  // Set the color of the enabled icon
                            dropdownColor: Color(0xff1D1D1D),  // Set the color of the dropdown list
                            items:  items.map((String item) => DropdownMenuItem(
                              value: item,
                              child: Text(item,style: TextStyle(color: Colors.white)),
                            )).toList(),
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Container(
                          width: 400.w,
                          height: 50.h,
                          padding: EdgeInsets.only(left:10.sp,right: 10.sp),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                              ),
                              BoxShadow(
                                color: Color(0xff1D1D1D),
                                spreadRadius: -1,
                                blurRadius: 10,
                                offset: Offset(0,0),
                                // blurStyle: BlurStyle.solid
                              )
                            ],
                            // border: Border.all(color: Colors.white,width: 2.sp,),
                            borderRadius: BorderRadius.circular(10.sp),

                          ),
                          child:   DropdownButton<String>(
                            hint: Text('Delivery Driver',style: TextStyle(color: Colors.white,),),
                            style: TextStyle(
                              color: Colors.white, // Text color
                              fontSize: 16.0, // Text size
                            ),
                            value: selectedValue,
                            onChanged: (value){

                            },
                            underline: Container(  // Remove underline border
                              decoration: BoxDecoration(
                                border: Border.all(width: 0), // Transparent border
                              )),
                            isExpanded: true,  // Make the dropdown button take the full width
                            icon: Icon(Icons.keyboard_arrow_down_sharp, color: Colors.white),  // Customizing the dropdown arrow
                            iconSize: 24.0,  // Adjust the icon size as needed
                            iconEnabledColor: Colors.white,  // Set the color of the enabled icon
                            dropdownColor: Color(0xff1D1D1D),  // Set the color of the dropdown list
                            items:  items.map((String item) => DropdownMenuItem(
                              value: item,
                              child: Text(item,style: TextStyle(color: Colors.white)),
                            )).toList(),
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container( 
                                margin: EdgeInsets.only(left:12.sp,top: 7.sp),
                                child: Text("Special Instructions",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))),
                            Container(
                              margin: EdgeInsets.all(10.sp),
                              child: TextFormField(
                                controller: instructions_controller,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 2.sp,
                                      )
                                    // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  hintText: 'Write Your Instruction',
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                          
                        InkWell(
                          onTap: (){
                            // log(products.toString());
                            final cartCubit = BlocProvider.of<CartCubit>(context);
                            cartCubit.reset(); // Call the reset function
                            CheckOutCubit.get(context).setOrder(products);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10.sp),
                            padding: EdgeInsets.all(1.sp),
                            width: 300.w,
                            height: 37.h,
                            decoration:  BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff0083F7),
                                ),
                                BoxShadow(
                                  color: Color.fromRGBO(0,0, 0, 0.9),
                                  spreadRadius: -3,
                                  blurRadius: 15,
                                  offset: Offset(5,5),
                                  // blurStyle: BlurStyle.solid
                                )
                              ],
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: Text('Place Your Order',
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
              ),
            );
        },
    ),
    );
  }
}


