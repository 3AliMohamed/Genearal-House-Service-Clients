import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/checkOut/cubit.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/checkOut/states.dart';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/data_layer/models/responses/cart_response.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';


import 'package:get/get.dart';
import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../business_logic_layer/cubit/cart/cubit.dart';
import '../../business_logic_layer/cubit/transportation_period/cubit.dart';
import '../../models/GetTransportationPeriod.dart';
import '../../reusable/app_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
as picker;


class CheckOut extends StatefulWidget {
  final List<Data>? orderDetails;
  Map<String,dynamic>? chosenAddress;
 final int? dataIndex;
   CheckOut({Key? key,this.orderDetails, this.dataIndex,this.chosenAddress}) : super(key: key);


   @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
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
  double? totalOrderPrice=0;

  ////////////////////////////
  String fromDate = '';
  String? selectedPickupPeriod;
  final inDropdownColor = Colors.black; // Color when in the dropdown
  final selectedColor = Colors.white;

  Set<String> uniqueCombinedPickupPeriods = Set();
  List<Drivers>? driversInPickupPeriods;
  Map<String, List<Drivers>> driversByPeriodPickup = {};
  String selectedPickupDriver = '';
  String selectedPickupDriverId = '';
  String selectedDeliveryDriver = '';
  String selectedDeliveryDriverId = '';
  String driverDate = '';
  //// Delivery
  Map<String, List<Drivers>> driversByPeriodDelivery = {};
  Set<String> uniqueCombinedDeliveryPeriods = Set();

  String? selectedDeliveryPeriod;
  List<Drivers>? driversInDeliveryPeriods;

  void buildDriverDialog(BuildContext context, List<Drivers> drivers) {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text(Trans('Choose Driver').tr),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Perform actions when a driver is selected
                      setState(() {
                        selectedPickupDriver = drivers[index].driver!.user!.name.toString();
                        selectedPickupDriverId = drivers[index].id.toString();
                      });
                      Navigator.pop(
                          context); // Close the dialog after selection
                    },
                    child: drivers[index].driver?.user?.name == null || drivers[index].driver!.user!.name!.isEmpty
                        ? Text(Trans('No Drivers').tr, style: TextStyle(fontSize: 16),)
                        : Text(
                      '${drivers[index].driver!.user!.name!}, ${Trans('Capacity').tr}:${drivers[index].capacity}',
                      style: TextStyle(fontSize: 16),
                    ),

                  ),
                  // 'Driver Name: ${driver!.driver!.user!.name}, Capacity: ${driver.capacity}',
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.blue,
                );
              },
              itemCount: drivers.length,
            ),
          ),
        );
      },
    );
  }


  void buildDriverDialogTwo(BuildContext context, List<Drivers> driversTwo) {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text(Trans('Choose Driver').tr),
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Perform actions when a driver is selected
                      setState(() {
                        selectedDeliveryDriver =
                            driversTwo[index].driver!.user!.name.toString();
                        selectedDeliveryDriverId =
                            driversTwo[index].id.toString();
                      });

                      Navigator.pop(
                          context); // Close the dialog after selection
                    },
                    child:driversTwo[index].driver?.user?.name == null || driversTwo[index].driver!.user!.name!.isEmpty
                        ? Text(Trans('No Drivers').tr, style: TextStyle(fontSize: 16),):
                    Text(
                      '${driversTwo[index].driver!.user!.name!},${Trans('Capacity').tr}: ${driversTwo[index].capacity}', style: TextStyle(fontSize: 16),),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.blue,
                );
              },
              itemCount: driversTwo.length,
            ),
          ),
        );
      },
    );
  }
  //////////////////////////////
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
                        Container(
                          margin: EdgeInsets.all(5.sp),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                              ),
                              BoxShadow(
                                color: Color.fromRGBO(0,0, 0, 0.9),
                                spreadRadius: -1,
                                blurRadius: 3,
                                offset: Offset(0,0),
                                // blurStyle: BlurStyle.solid
                              )
                            ],
                            // border: Border.all(color: Colors.white,width: 2.sp,),
                            borderRadius: BorderRadius.circular(5.sp),

                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 320.w,

                                child: TextFormField(
                                  decoration: InputDecoration(

                                    contentPadding: EdgeInsets.only(left: 10.sp),
                                    hintText: 'Do You Have A Promo Code ?',
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                  // textAlign: TextAlign.center,
                                  controller: promoCodeController,
                                  style: TextStyle(color: Colors.white),
                                  // onChanged: (value) => ,

                                ),
                              ),
                              TextButton(onPressed: (){
                                log(widget.chosenAddress.toString());
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
                                    padding: EdgeInsets.only(left: 10.sp),
                                    child: Text('Apply',
                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Container(
                          padding: EdgeInsets.only(top: 5.sp,bottom: 5.sp,
                              left: 5.sp,right: 5.sp),
                          // margin: EdgeInsets.only(bottom: 15.sp),
                          decoration: BoxDecoration(
                              color: Color(0xff1D1D1D),

                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Text("Order :",
                                  style: TextStyle(color: Colors.white,fontSize: 15.sp),
                                  ),
                                  Text("$totalOrderPrice Aud",
                                    style: TextStyle(color: Colors.white,fontSize: 15.sp),),
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Text("Discount:",
                                    style: TextStyle(color: Colors.white,fontSize: 15.sp),),
                                  Text("$total Aud",
                                    style: TextStyle(color: Colors.white,fontSize: 15.sp),),
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Text("VAT:",
                                     style: TextStyle(color: Colors.white,fontSize: 15.sp),),
                                  Text("$total Aud",
                                    style: TextStyle(color: Colors.white,fontSize: 15.sp),),
                                ],
                              ),
                              Divider(color: Colors.white,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Text("Summary:",
                                    style: TextStyle(color: Colors.white,fontSize: 15.sp),),
                                  Text("$total Aud",
                                    style: TextStyle(color: Colors.white,fontSize: 15.sp),),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                                  Image.asset(locationType[widget.chosenAddress?['locationType']]!,
                                    width: 30.w,height: 30.h,),
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
                        SizedBox(height: 15.h,),
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
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                Trans('Pickup Date').tr,
                                style: TextStyle(
                                  color: Color(0XFF707070),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '${fromDate}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  DatePicker.showDatePicker(
                                    context,
                                    showTitleActions: true,
                                    minTime: DateTime(2023, 3, 1),
                                    maxTime: DateTime(2030, 1, 1),
                                    onChanged: (date) {
                                      log('change $date');
                                    },
                                    onConfirm: (date) async {
                                      log('confirm $date');
                                      DateTime today = DateTime.now();
                                      String todayFormatted= DateFormat('yyyy-MM-dd').format(today);
                                      log("today "+todayFormatted);
                                      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                                      log('formattedDate' + formattedDate);

                                      if(date.isAfter(today)|| todayFormatted == formattedDate){
                                        try {
                                          setState(() {
                                            fromDate = formattedDate;
                                            TransportationPeriodCubit.get(context).getTransportationPeriod('40', formattedDate);
                                            ///////////////////////
                                            for (var period in TransportationPeriodCubit.get(context).transportationPeriodPickupList) {
                                              String? fromPeriodTime = period.from;
                                              String? toPeriodTime = period.to;
                                              String combinedPeriod =
                                                  "$fromPeriodTime To $toPeriodTime";
                                              // Check if combinedPeriod has not been added to periods before
                                              if (!uniqueCombinedPickupPeriods
                                                  .contains(combinedPeriod)) {
                                                // periods.add(combinedPeriod);
                                                uniqueCombinedPickupPeriods.add(
                                                    combinedPeriod); // Add it to the set to mark it as added
                                              }
                                              driversInPickupPeriods = period.drivers;

                                              if (driversByPeriodPickup
                                                  .containsKey(combinedPeriod)) {
                                                log("combinedPeriod $combinedPeriod");
                                                if (driversInPickupPeriods != null) {
                                                  // log(" driversByPeriod[combinedPeriod]"+driversByPeriod[combinedPeriod].toString());
                                                  driversByPeriodPickup[combinedPeriod]!
                                                      .addAll(driversInPickupPeriods!);
                                                }
                                              } else {
                                                log("combinedPeriod in else: $combinedPeriod");
                                                driversByPeriodPickup[combinedPeriod] =
                                                driversInPickupPeriods != null
                                                    ? List.from(driversInPickupPeriods!)
                                                    : [];
                                              }
                                            }
                                            //////////////////////////////////////////////
                                          });
                                        }
                                        catch (e) {
                                          // Handle any errors that occurred during the asynchronous operation here.
                                          log('Error: $e');
                                          Fluttertoast.showToast(
                                              msg: "No Transportation Periods",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              textColor: Colors.white,
                                              backgroundColor: Colors.red,
                                              fontSize: 16.0);
                                          rethrow;
                                        }

                                      }
                                      else {

                                        Fluttertoast.showToast(
                                          backgroundColor: Colors.redAccent,
                                          msg: Trans('date must be a date after ').tr + todayFormatted.toString(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 6,
                                          textColor: Colors.white,
                                          fontSize: 16.sp,
                                        );
                                      }

                                    },
                                    currentTime: DateTime.now(),
                                    locale: Get.locale!.languageCode == "en"
                                        ? LocaleType.en
                                        : LocaleType.ar,
                                  );
                                },
                                child: Image.asset(
                                  'assets/images/calendar (3).png',
                                  height: 30.h,
                                  width: 100.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h,),
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
                          child:
                          DropdownButton<String>(
                            hint: Text(
                              Trans('Select a Pickup Period').tr,
                              style: TextStyle(
                                color: Color(0XFF00FFFF),
                              ),
                            ),
                            value: selectedPickupPeriod,
                            items: uniqueCombinedPickupPeriods == null
                                ? null
                                : uniqueCombinedPickupPeriods.map((String period) {
                              return DropdownMenuItem<String>(
                                value: period,
                                child: Text(
                                  period,
                                  style: TextStyle(
                                      color: selectedPickupPeriod == period
                                          ? selectedColor
                                          : inDropdownColor,
                                      fontSize: 20.sp),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedPickupPeriod = '';
                                selectedPickupPeriod = newValue!;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 15.h,),
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
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                Trans('Delivery Date').tr,
                                style: TextStyle(
                                  color: Color(0XFF707070),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '${driverDate}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {

                                  DatePicker.showDatePicker(
                                    context,
                                    showTitleActions: true,
                                    minTime: DateTime(2023, 3, 1),
                                    maxTime: DateTime(2030, 1, 1),
                                    onChanged: (date) {
                                      log('change $date');
                                    },
                                    onConfirm: (date) async {
                                      log('confirm $date');
                                      DateTime today = DateTime.now();
                                      String todayFormatted= DateFormat('yyyy-MM-dd').format(today);
                                      log("today"+today.toString());
                                      try {
                                        String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                                          if (date.isAfter(today) || todayFormatted ==formattedDate) {
                                            setState(() {
                                              driverDate = formattedDate;
                                              TransportationPeriodCubit.get(context).getTransportationPeriodTwo('118', formattedDate);
                                              for (var period in TransportationPeriodCubit.get(context).transportationPeriodDeliveryList) {
                                                String? fromPeriodTime = period.from;
                                                String? toPeriodTime = period.to;
                                                String combinedPeriod = "$fromPeriodTime To $toPeriodTime";

                                                if (!uniqueCombinedDeliveryPeriods.contains(combinedPeriod)) {
                                                  uniqueCombinedDeliveryPeriods.add(combinedPeriod);
                                                }

                                                driversInDeliveryPeriods = period.drivers;

                                                if (driversByPeriodDelivery.containsKey(combinedPeriod)) {
                                                  if (driversInDeliveryPeriods != null) {
                                                    driversByPeriodDelivery[combinedPeriod]!.addAll(driversInDeliveryPeriods!);
                                                  }
                                                } else {
                                                  driversByPeriodDelivery[combinedPeriod] =
                                                  driversInDeliveryPeriods != null ? List.from(driversInDeliveryPeriods!) : [];
                                                }
                                              }
                                              log("06:00:00 To 07:00:00" +
                                                  driversByPeriodDelivery['06:00:00 To 07:00:00'].toString());
                                            });
                                          }
                                          else {
                                            Fluttertoast.showToast(
                                              backgroundColor: Colors.redAccent,
                                              msg: Trans('date must be a date after ').tr + todayFormatted.toString(),
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 6,
                                              textColor: Colors.white,
                                              fontSize: 16.sp,
                                            );
                                          }
                                      }
                                      catch (e) {
                                        Fluttertoast.showToast(
                                          msg: Trans("No Transportation Periods").tr,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          textColor: Colors.white,
                                          backgroundColor: Colors.red,
                                          fontSize: 16.0,
                                        );
                                        log('Error: $e');
                                        rethrow;
                                      }
                                    },
                                    currentTime: DateTime.now(),
                                    locale: Get.locale!.languageCode == "en"
                                        ? LocaleType.en
                                        : LocaleType.ar,
                                  );
                                },
                                child: Image.asset(
                                  'assets/images/calendar (3).png',
                                  height: 30.h,
                                  width: 100.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h,),
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
                          child:
                          DropdownButton<String>(
                            hint: Text(
                              Trans('Select a Delivery Period').tr,
                              style: TextStyle(
                                color: Color(0XFF00FFFF),
                              ),
                            ),
                            value: selectedDeliveryPeriod,
                            items: uniqueCombinedDeliveryPeriods == null
                                ? null
                                : uniqueCombinedDeliveryPeriods.map((String period) {
                              return DropdownMenuItem<String>(
                                value: period,
                                child: Text(
                                  period,
                                  style: TextStyle(
                                      color: selectedDeliveryPeriod == period
                                          ? selectedColor
                                          : inDropdownColor,
                                      fontSize: 20.sp),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDeliveryPeriod = '';
                                selectedDeliveryPeriod = newValue!;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 15.h,),
                        Container(
                          width: 400.w,
                          height: 60.h,
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
                          child:
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                Trans('Pickup Driver').tr,
                                style: TextStyle(color: Color(0XFF707070)),
                              ),
                              InkWell(
                                onTap: () {
                                  if (driversByPeriodPickup[selectedPickupPeriod] ==
                                      null) {
                                    Fluttertoast.showToast(
                                        msg: Trans("Select Period First").tr,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.red,
                                        fontSize: 16.0);
                                  } else {
                                    buildDriverDialog(
                                        context,
                                        driversByPeriodPickup[
                                        selectedPickupPeriod]!);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      selectedPickupDriver,
                                      style: TextStyle(color: Colors.white),
                                      // fontSize: k14TextSize,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    ),

                                  ],
                                ),
                              ),
                              Divider(
                                color: Color(0XFF007885),
                                height: 30.h,
                                thickness: 1.sp,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h,),
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
                          child:
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                Trans('Delivery Driver').tr,
                                style: TextStyle(color: Color(0XFF707070)),
                              ),
                              InkWell(
                                onTap: () {
                                  if (driversByPeriodDelivery[
                                  selectedDeliveryPeriod] ==
                                      null) {
                                    Fluttertoast.showToast(
                                        msg: Trans("Select Period First").tr,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.red,
                                        fontSize: 16.0);
                                  } else {
                                    buildDriverDialogTwo(
                                        context,
                                        driversByPeriodDelivery[
                                        selectedDeliveryPeriod]!);
                                  }
                                },
                                child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      selectedDeliveryDriver,
                                      // getLang(context) == 'ar' ? 'Arabic'.tr() : 'English'.tr(),
                                      style: TextStyle(color: Colors.white),
                                      // fontSize: k14TextSize,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,

                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Color(0XFF007885),
                                height: 30.h,
                                thickness: 1.sp,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h,),
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


