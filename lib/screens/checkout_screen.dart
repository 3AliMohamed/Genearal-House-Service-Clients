import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:general_house_service_clients/reusable/dashed_divider.dart';

import '../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../reusable/app_bar.dart';
import '../reusable/bottom_navigation_bar.dart';
import '../reusable/date-dropdown_picker.dart';
 
class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

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
  int quantity=0;
  int product_price=300;
  int total=0;
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
          child: SingleChildScrollView(
            child: Column(
                children: [
                  SizedBox(height: 10.h,),
                  Container(
                        margin: EdgeInsets.all(8.sp),
                        padding: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.sp)
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Order Details'),
                            InkWell(
                              onTap: (){},
                              child: Text("Edit Order",
                              style: TextStyle(color: Color(0xff3C7977)),
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Text('General House Service Company ',
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8.sp),
                    padding: EdgeInsets.all(5.sp),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.sp)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Address"),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed('/address');
                              },
                              child: Text("Select Address" ,
                                style: TextStyle(color: Color(0xff3C7977)),
                              ),
                            )
                          ],
                        ),
                        Divider(color: Colors.black,),
                        Container(
                          // width: .w,
                          child: Row(
                            children: [
                              Icon(
                                Icons.house,
                              ),
                              SizedBox(width: 5.w,),
                              // Image.asset('assets/images/${chosen_location_logo[0]}', width: 15.w,height: 15.h,),
                              Text(chosen_location[0]),
                              Text(" : 12 Omranya Street , 5Th Floor , Dokki , Giza , Egypt",
                                style: TextStyle(fontSize: 12.sp),),

                            ],
                          ),
                        ),
                        Divider(color: Colors.black,) ,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Do You Have Promo Code ?"),
                            InkWell(
                              onTap: (){},
                              child: Text("Apply",
                                style: TextStyle(color: Color(0xff3C7977)),
                              ),
                            )
                          ],
                        ),
                        Divider(color: Colors.black,),
                        Container(
                          height: 40.h,
                          margin: EdgeInsets.all(5.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding:EdgeInsets.all(5.sp),
                                height: 35.h,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,), // Border
                                  borderRadius: BorderRadius.circular(10.sp), // Border radius
                                ),
                                child: DropdownButton(
                                  style: TextStyle(
                                    color: Colors.black, // Text color
                                    fontSize: 16.0, // Text size
                                  ),
                                  icon: Icon(
                                    Icons.arrow_drop_down, // Dropdown icon
                                    color: Colors.black, // Icon color
                                  ),
                                  dropdownColor: Colors.white,
                                  hint: Text("delivery type"),
                                  value: selectedValue, // Current selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedValue = newValue!;
                                    });
                                  },
                                  items: items.map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Padding(
                                        padding: EdgeInsets.only(left:5.sp),
                                        child: Text(
                                          item,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF5EFEF),
                            border: Border(
                              top: BorderSide(color: Colors.black),
                              bottom: BorderSide(color: Colors.black),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Name"),
                              Text("Qty"),
                              Text("Price"),
                              Text("Total"),
                            ],
                          ),
                        ),
                        Container(
                          height: 45.h,
                          decoration: BoxDecoration(
                            // color: Color(0xffF5EFEF),
                            border: Border(
                              // top: BorderSide(color: Colors.black),
                              bottom: BorderSide(color: Colors.black),
                            ),
                          ),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.
                            children: [
                              Text("$product_name($product_option)",
                              style: TextStyle(fontSize: 13.sp),
                              ),
                              SizedBox(width: 13.sp,),
                              InkWell(
                                 onTap: (){
                                   setState(() {
                                     quantity+=1;
                                     total=quantity*product_price;
                                   });
                                 },
                                child: Icon(
                                  Icons.add,
                                  size: 15.sp,
                                ),
                              ),
                              SizedBox(width: 2.sp,),
                              Text(quantity.toString()),
                              SizedBox(width: 2.sp,),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    if(quantity>0){quantity-=1; total-=product_price;}
                                    else{quantity=0;}
                                  });
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 15.sp,
                                ),
                              ),
                              SizedBox(width: 40.sp,),
                              Text("$product_price Aud"),
                              SizedBox(width: 68.sp,),
                              Text(total.toString()),

                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10.sp,bottom: 10.sp,
                              left: 5.sp,right: 5.sp),
                          margin: EdgeInsets.only(bottom: 15.sp),
                          decoration: BoxDecoration(
                            color: Color(0xffCCDBE5),
                            border: Border(
                              bottom: BorderSide(color: Color(0xff707070)),
                              top: BorderSide(color: Color(0xff707070)),
                            )
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Sub Total:"),
                                  Text("$total Aud"),
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Minimum Charge:"),
                                  Text("$total Aud"),
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Discount:"),
                                  Text("$total Aud"),
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Vat:"),
                                  Text("$total Aud"),
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Delivery Fees:"),
                                  Text("Free"),
                                ],
                              ),
                              SizedBox(height: 13.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Text("Delivery Fees:"),
                                  Container(
                                    color: Colors.black,
                                    width: 50.w,
                                    height: 2.h,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total:"),
                                  Text("2000 Aud"),
                                ],
                              ),






                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                  // Container(
                  //   // margin: EdgeInsets.all(8.sp),
                  //   padding: EdgeInsets.all(5.sp),
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(12.sp)
                  //   ),
                  //   child: Column(
                  //     // crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text("Delivery Details"),
                  //       DashedDivider(),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Container(
                  //             padding:EdgeInsets.all(5.sp),
                  //
                  //             height: 35.h,
                  //             decoration: BoxDecoration(
                  //               border: Border.all(color: Colors.black,), // Border
                  //               borderRadius: BorderRadius.circular(10.sp), // Border radius
                  //             ),
                  //             child: DropdownButton(
                  //               style: TextStyle(
                  //                 color: Colors.black, // Text color
                  //                 fontSize: 16.0, // Text size
                  //               ),
                  //               icon: Icon(
                  //                 Icons.arrow_drop_down, // Dropdown icon
                  //                 color: Colors.black, // Icon color
                  //               ),
                  //               dropdownColor: Colors.white,
                  //               hint: Text("PickUp date"),
                  //               value: selectedValue, // Current selected value
                  //               onChanged: (String? newValue) {
                  //                 setState(() {
                  //                   selectedValue = newValue!;
                  //                 });
                  //               },
                  //               items: items.map((String item) {
                  //                 return DropdownMenuItem<String>(
                  //                   value: item,
                  //                   child: Padding(
                  //                     padding: EdgeInsets.only(left:5.sp),
                  //                     child: Text(
                  //                       item,
                  //                       style: TextStyle(color: Colors.black),
                  //                     ),
                  //                   ),
                  //                 );
                  //               }).toList(),
                  //             ),
                  //           ),
                  //           Container(
                  //             padding:EdgeInsets.all(5.sp),
                  //             height: 35.h,
                  //             decoration: BoxDecoration(
                  //               border: Border.all(color: Colors.black,), // Border
                  //               borderRadius: BorderRadius.circular(10.sp), // Border radius
                  //             ),
                  //             child: DropdownButton(
                  //               style: TextStyle(
                  //                 color: Colors.black, // Text color
                  //                 fontSize: 16.0, // Text size
                  //               ),
                  //               icon: Icon(
                  //                 Icons.arrow_drop_down, // Dropdown icon
                  //                 color: Colors.black, // Icon color
                  //               ),
                  //               dropdownColor: Colors.white,
                  //               hint: Text("Dlivery date"),
                  //               value: selectedValue, // Current selected value
                  //               onChanged: (String? newValue) {
                  //                 setState(() {
                  //                   selectedValue = newValue!;
                  //                 });
                  //               },
                  //               items: items.map((String item) {
                  //                 return DropdownMenuItem<String>(
                  //                   value: item,
                  //                   child: Padding(
                  //                     padding: EdgeInsets.only(left:5.sp),
                  //                     child: Text(
                  //                       item,
                  //                       style: TextStyle(color: Colors.black),
                  //                     ),
                  //                   ),
                  //                 );
                  //               }).toList(),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Container(
                  //             padding:EdgeInsets.all(5.sp),
                  //             height: 35.h,
                  //             decoration: BoxDecoration(
                  //               border: Border.all(color: Colors.black,), // Border
                  //               borderRadius: BorderRadius.circular(10.sp), // Border radius
                  //             ),
                  //             child: DropdownButton(
                  //               style: TextStyle(
                  //                 color: Colors.black, // Text color
                  //                 fontSize: 16.0, // Text size
                  //               ),
                  //               icon: Icon(
                  //                 Icons.arrow_drop_down, // Dropdown icon
                  //                 color: Colors.black, // Icon color
                  //               ),
                  //               dropdownColor: Colors.white,
                  //               hint: Text("Transportation"),
                  //               value: selectedValue, // Current selected value
                  //               onChanged: (String? newValue) {
                  //                 setState(() {
                  //                   selectedValue = newValue!;
                  //                 });
                  //               },
                  //               items: items.map((String item) {
                  //                 return DropdownMenuItem<String>(
                  //                   value: item,
                  //                   child: Padding(
                  //                     padding: EdgeInsets.only(left:5.sp),
                  //                     child: Text(
                  //                       item,
                  //                       style: TextStyle(color: Colors.black),
                  //                     ),
                  //                   ),
                  //                 );
                  //               }).toList(),
                  //             ),
                  //           ),
                  //           Container(
                  //             padding:EdgeInsets.all(5.sp),
                  //             height: 35.h,
                  //             decoration: BoxDecoration(
                  //               border: Border.all(color: Colors.black,), // Border
                  //               borderRadius: BorderRadius.circular(10.sp), // Border radius
                  //             ),
                  //             child: DropdownButton(
                  //               style: TextStyle(
                  //                 color: Colors.black, // Text color
                  //                 fontSize: 16.0, // Text size
                  //               ),
                  //               icon: Icon(
                  //                 Icons.arrow_drop_down, // Dropdown icon
                  //                 color: Colors.black, // Icon color
                  //               ),
                  //               dropdownColor: Colors.white,
                  //               hint: Text("Transportation"),
                  //               value: selectedValue, // Current selected value
                  //               onChanged: (String? newValue) {
                  //                 setState(() {
                  //                   selectedValue = newValue!;
                  //                 });
                  //               },
                  //               items: items.map((String item) {
                  //                 return DropdownMenuItem<String>(
                  //                   value: item,
                  //                   child: Padding(
                  //                     padding: EdgeInsets.only(left:5.sp),
                  //                     child: Text(
                  //                       item,
                  //                       style: TextStyle(color: Colors.black),
                  //                     ),
                  //                   ),
                  //                 );
                  //               }).toList(),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Container(
                  //             padding:EdgeInsets.all(5.sp),
                  //             height: 35.h,
                  //             decoration: BoxDecoration(
                  //               border: Border.all(color: Colors.black,), // Border
                  //               borderRadius: BorderRadius.circular(10.sp), // Border radius
                  //             ),
                  //             child: DropdownButton(
                  //               style: TextStyle(
                  //                 color: Colors.black, // Text color
                  //                 fontSize: 16.0, // Text size
                  //               ),
                  //               icon: Icon(
                  //                 Icons.arrow_drop_down, // Dropdown icon
                  //                 color: Colors.black, // Icon color
                  //               ),
                  //               dropdownColor: Colors.white,
                  //               hint: Text("PickUp driver"),
                  //               value: selectedValue, // Current selected value
                  //               onChanged: (String? newValue) {
                  //                 setState(() {
                  //                   selectedValue = newValue!;
                  //                 });
                  //               },
                  //               items: items.map((String item) {
                  //                 return DropdownMenuItem<String>(
                  //                   value: item,
                  //                   child: Padding(
                  //                     padding: EdgeInsets.only(left:5.sp),
                  //                     child: Text(
                  //                       item,
                  //                       style: TextStyle(color: Colors.black),
                  //                     ),
                  //                   ),
                  //                 );
                  //               }).toList(),
                  //             ),
                  //           ),
                  //           Container(
                  //             padding:EdgeInsets.all(5.sp),
                  //             height: 35.h,
                  //             decoration: BoxDecoration(
                  //               border: Border.all(color: Colors.black,), // Border
                  //               borderRadius: BorderRadius.circular(10.sp), // Border radius
                  //             ),
                  //             child: DropdownButton(
                  //               style: TextStyle(
                  //                 color: Colors.black, // Text color
                  //                 fontSize: 16.0, // Text size
                  //               ),
                  //               icon: Icon(
                  //                 Icons.arrow_drop_down, // Dropdown icon
                  //                 color: Colors.black, // Icon color
                  //               ),
                  //               dropdownColor: Colors.white,
                  //               hint: Text("Dlivery driver"),
                  //               value: selectedValue, // Current selected value
                  //               onChanged: (String? newValue) {
                  //                 setState(() {
                  //                   selectedValue = newValue!;
                  //                 });
                  //               },
                  //               items: items.map((String item) {
                  //                 return DropdownMenuItem<String>(
                  //                   value: item,
                  //                   child: Padding(
                  //                     padding: EdgeInsets.only(left:5.sp),
                  //                     child: Text(
                  //                       item,
                  //                       style: TextStyle(color: Colors.black),
                  //                     ),
                  //                   ),
                  //                 );
                  //               }).toList(),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //
                  //
                  //     ],
                  //   ),
                  // ),
                  Padding(
                            padding: EdgeInsets.all(16.sp),
                            child:
                            Container(
                              width: 400.w,
                              margin: EdgeInsets.all(8.sp),
                                padding: EdgeInsets.only(left:8.sp,right: 8.sp,top: 8.sp,bottom: 15.sp),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.sp)
                                ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Delivery Details",style: TextStyle(fontWeight: FontWeight.bold)),

                                  SizedBox(height: 20.h),
                                  DropdownButton<String>(
                                    hint: Text('Pickup Date',style: TextStyle(color: Colors.black,),),
                                    style: TextStyle(
                                                      color: Colors.black, // Text color
                                                      fontSize: 16.0, // Text size
                                                    ),
                                    value: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value;
                                      });
                                    },
                                    items:  items.map((String item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(item,style: TextStyle(color: Colors.black)),
                                    ))
                                        .toList(),
                                  ),
                                  SizedBox(height: 20.h),
                                  DropdownButton<String>(
                                    hint: Text('Transportation Period',style: TextStyle(color: Colors.black,),),
                                    value: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value;
                                      });
                                    },
                                    items:  items.map((String item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(item,style: TextStyle(color: Colors.black)),
                                    ))
                                        .toList(),
                                  ),
                                  SizedBox(height: 20.h),
                                  DropdownButton<String>(
                                    hint:Text('Pickup Driver',style: TextStyle(color: Colors.black,),),
                                    value: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value;
                                      });
                                    },
                                    items:  items.map((String item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(item,style: TextStyle(color: Colors.black)),
                                    ))
                                        .toList(),
                                  ),

                                  /////
                                  DropdownButton<String>(
                                    hint: Text('Delivery Date',style: TextStyle(color: Colors.black,),),
                                    style: TextStyle(
                                      color: Colors.black, // Text color
                                      fontSize: 16.0, // Text size
                                    ),
                                    value: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value;
                                      });
                                    },
                                    items:  items.map((String item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(item,style: TextStyle(color: Colors.black)),
                                    ))
                                        .toList(),
                                  ),
                                  SizedBox(height: 20.h),
                                  DropdownButton<String>(
                                    hint: Text('Transportation Period',style: TextStyle(color: Colors.black,),),
                                    value: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value;
                                      });
                                    },
                                    items:  items.map((String item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(item,style: TextStyle(color: Colors.black)),
                                    ))
                                        .toList(),
                                  ),
                                  SizedBox(height: 20.h),
                                  DropdownButton<String>(
                                    hint:Text('Delivery Driver',style: TextStyle(color: Colors.black,),),
                                    value: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value;
                                      });
                                    },
                                    items:  items.map((String item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(item,style: TextStyle(color: Colors.black)),
                                    ))
                                        .toList(),
                                  ),
                                  /////////
                                  Row(
                                    children: [
                                      Text("Special Instructions",style: TextStyle(fontWeight: FontWeight.bold)),
                                      IconButton(onPressed: (){}, icon:Icon(Icons.add_circle_outline),),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: instructions_controller,
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                      hintText: 'Write Your Instruction',
                                    ),
                                  )
                                ],
                              ),
                            ),
                                     ),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.sp),
                      padding: EdgeInsets.all(1.sp),
                      width: 300.w,
                      height: 37.h,
                      decoration:  BoxDecoration(
                        color: Color(0xff157A82),
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Text('Confirm',
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
  }
}


