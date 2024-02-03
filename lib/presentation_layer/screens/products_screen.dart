import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:general_house_service_clients/constants/end_points.dart';
import 'package:general_house_service_clients/helpers/SharedPrefManager.dart';
import 'package:general_house_service_clients/presentation_layer/screens/product_option_screen.dart';
import 'package:general_house_service_clients/presentation_layer/widgets/reusable_widgets.dart';
import 'package:get/get.dart';

import '../../business_logic_layer/cubit/addProduct/add_product_cubit.dart';
import '../../business_logic_layer/cubit/addProduct/add_product_states.dart';
import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../business_logic_layer/cubit/cart/cubit.dart';
import '../../business_logic_layer/cubit/getProducts/cubit.dart';
import '../../business_logic_layer/cubit/getProducts/states.dart';
import '../../data_layer/models/responses/company_response.dart';
import '../../reusable/app_bar.dart';

class ProductsScreen extends StatefulWidget {
   ProductsScreen(
      {Key? key,
      this.id,
      this.categoryId,
      this.companyId,
      this.categoriesProduct,
      this.company});
  int? id;
  int? categoryId;
  int? companyId;
  String? productId;
  List<Categories>? categoriesProduct = [];
  Map<String, dynamic>? company = {};
  int? deliveryTypeId;
  // Data companyData=  Data.fromJson(company!);
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String? currentLang = SharedPreferencesManager.getString('lang');
  int? tappedIndex;
  @override
  Widget build(BuildContext context) {
    String? currentLang = SharedPreferencesManager.getString('lang');
    return BlocProvider(
      create: (context)=> ProductCubit(),

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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    child: Text(
                      Trans('Products').tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 300.h,
                    width: double.infinity,
                    padding:
                        EdgeInsets.only(left: 20.sp, right: 20.sp, top: 13.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        // color: Colors.red.withOpacity(0.2),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff0083F7),
                          ),
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.9),
                            spreadRadius: -1,
                            blurRadius: 20,
                            offset: Offset(10, 0),
                            // blurStyle: BlurStyle.solid
                          )
                        ]),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //comp_temp.png
                        widget.company!['cover_path'] == null
                            ? Image.asset('assets/images/comp_temp.png')
                            : Image.network(
                                ApiUrls().imageApi +
                                    widget.company!['cover_path'].toString(),
                                height: 130.h,
                              ),
                        // Text("For washing all kinds of clothes",style: TextStyle(fontSize: 10.sp),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  widget.company!['name_en'],
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white),
                                ),
                                Text(
                                  'Delivery By ${widget.company!['name_en']}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.sp),
                                ),
                                Text(
                                  'Payment : Cash ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.sp),
                                ),
                                Text(
                                  '24 Hour Delivery',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Ignore taps
                                      },
                                      child: RatingBar.builder(
                                        unratedColor: Colors.grey,
                                        itemSize: 20.sp,
                                        initialRating: widget
                                            .company!['avrage_rate']
                                            .toDouble(),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemBuilder: (context, index) {
                                          return Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          );
                                        },
                                        onRatingUpdate: (rating) {
                                          // This won't be called since GestureDetector ignores taps
                                          print(rating);
                                        },
                                      ),
                                    ),
                                    Text(
                                      '(${widget.company!['rate_count'].toString()})',
                                      style: TextStyle(fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            widget.company!['logo_path'] == null
                                ? Image.asset('assets/images/comp_temp.png')
                                : Image.network(
                                    ApiUrls().imageApi +
                                        widget.company!['logo_path'].toString(),
                                    width: 100.w,
                                    height: 130.h,
                                  ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(1.sp),
                    height: 45.h,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff0083F7),
                          ),
                          BoxShadow(
                            color:  Color.fromRGBO(0, 0, 0, 0.9).withOpacity(0.8),
                            spreadRadius: -1,
                            blurRadius: 6,
                            offset: Offset(0,0),
                            // blurStyle: BlurStyle.solid
                          )
                        ]
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 340.w,
                            child: ListView.builder(
                                itemBuilder: (context,indexDeliveryType)
                            {
                              return TextButton(
                                  onPressed: () {
                                    ProductCubit.get(context).setPercentage(widget.company!['delivery_types'][indexDeliveryType]['added_value']);
                                    widget.deliveryTypeId=widget.company!['delivery_types'][indexDeliveryType]['id'];
                                    log("delivery id : " +widget.deliveryTypeId.toString());
                                    },
                                  child: Text(
                                    widget.company!['delivery_types'][indexDeliveryType]['name_en'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19.sp),
                                  ));
                            },
                              itemCount: widget.company!['delivery_types'].length,
                              scrollDirection: Axis.horizontal,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80.h,
                    child: ListView.separated(
                      separatorBuilder: (context,int index){
                        return SizedBox(width: 10.w,);
                      },
                      scrollDirection: Axis.horizontal,
                      //ProductCubit.get(context).optionsMap[productId]!.length,
                      itemCount: widget.categoriesProduct!.length,
                      // Adjust the number of items as needed
                      itemBuilder: (BuildContext context, int index) {
                        int specificId = widget
                            .categoryId!; // Replace this with your specific ID
                        widget.categoriesProduct?.sort((a, b){
                          if (a.id == specificId) {
                            return -1; // 'a' comes first if its ID matches the specific ID
                          } else if (b.id == specificId) {
                            return 1; // 'b' comes first if its ID matches the specific ID
                          } else {
                            return 0; // Maintain the order for other entries
                          }
                        });
                        return Container(
                          margin:  EdgeInsets.only(left: 10.sp,top: 3.sp),
                          child: GestureDetector(
                              onTap: () {
                                int tappedProductCategoryId =
                                    widget.categoriesProduct![index].id!.toInt();
                                if (tappedIndex != index) {
                                  setState(() {
                                    tappedIndex =
                                        index; // Update the tapped index
                                  });
                                  BlocProvider.of<ProductCubit>(context).emit(InitialState());
                                  ProductCubit.get(context).clearProducts();
                                  ProductCubit.get(context).getProduct(
                                      widget.companyId!, tappedProductCategoryId);
                                }
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Circular Image
                                  Container(
                                    width:
                                        150.0, // Adjust the size of the circle as needed
                                    height: 150.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(ApiUrls().imageApi +
                                            widget.categoriesProduct![index].imgPath.toString()),
                                      ),
                                    ),
                                  ),
                                  // Text above the circular image
                                  Positioned(
                                    top: 20,
                                    child: Text(
                                      currentLang == 'en' ? widget.categoriesProduct![index].nameEn.toString()
                                          : widget.categoriesProduct![index].nameAr.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: tappedIndex == index
                                              ? Colors.blue
                                              : Colors.white,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              )),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  BlocConsumer<ProductCubit, ProductStates>(
                    listener: (context, state) {
                      if (state is LoadedErrorState) {
                        showToast(state.error.toString());
                        log(state.error.toString());
                      }
                    },
                    builder: (context, state) {
                      if (state is InitialState ) {
                        ProductCubit.get(context).getProduct(widget.companyId!, widget.categoryId!);
                        return  SpinKitFadingCube(
                          color: Color(0xffB4AFAF),
                          size: 50.0,
                        );    }
                      else if(state is LoadingState)
                        { return  SpinKitFadingCube(
                          color: Color(0xffB4AFAF),
                          size: 50.0,
                        ); }
                      // else if(state is LoadedErrorState)
                      //   {
                      //     return Text(data)
                      //   }
                      else {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SizedBox(
                            height: 750.h,
                            width: 500.w,
                            child: ListView.separated(
                                itemCount: ProductCubit.get(context).products!.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 10.h,
                                  );
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: 150.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xff0083F7),
                                          ),
                                          BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.9),
                                            spreadRadius: -1,
                                            blurRadius: 20,
                                            offset: Offset(10,10),
                                            // blurStyle: BlurStyle.solid
                                          )
                                        ]
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ProductCubit.get(context).products![index].imgPath == null ?
                                        Image.asset("assets/images/product.png",
                                          fit: BoxFit.fill,
                                          height: 155.h,
                                        ) :
                                        Container(
                                            width:100.w,
                                            height: 100.h,
                                            padding: EdgeInsets.all(2.sp),
                                            margin:EdgeInsets.all(10.sp),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.sp),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xff0083F7),
                                                  ),
                                                  BoxShadow(
                                                    color: Color.fromRGBO(0, 0, 0, 0.9),
                                                    spreadRadius: -1,
                                                    blurRadius: 20,
                                                    offset: Offset(0, 0),
                                                    // blurStyle: BlurStyle.solid
                                                  )
                                                ]
                                            ),
                                            child: Image.network(ApiUrls().imageApi + ProductCubit.get(context).products![index].imgPath.toString(),width: 90.w,
                                              height:90.h,)),
                                        SizedBox(
                                          width:300.w,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 20.h,),
                                              SizedBox(
                                                width:320.w,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:CrossAxisAlignment.start,
                                                      children: [
                                                        Text(currentLang == 'en' ? ProductCubit.get(context).products![index].nameEn.toString()
                                                            : ProductCubit.get(context).products![index].nameAr.toString(),
                                                          style: TextStyle(fontSize: 20.sp,color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text('T-Shirt Clean',
                                                          style: TextStyle(fontSize: 17.sp,color: Colors.white,
                                                              fontStyle: FontStyle.italic),
                                                        ),

                                                      ],
                                                    ),
                                                    BlocListener<AddProductCubit,AddProductStates>(
                                                        listener: (context,state)
                                                        {

                                                        },
                                                        child:  InkWell(
                                                          onTap: () async {
                                                            if(SharedPreferencesManager.containKey('token')==true) {
                                                              log("token");
                                                               // Call the reset function
                                                              widget.deliveryTypeId??=1;
                                                              Future<bool> isAdded=AddProductCubit.get(context).addOrder(
                                                                  widget.companyId,widget.deliveryTypeId);
                                                              if(await isAdded){
                                                                BlocProvider.of<CartCubit>(context).reset();}
                                                            }else{
                                                              log('not token');
                                                              showToast('You Should Log In First');
                                                            }
                                                            // Navigator.of(context).pushNamed("/cart");

                                                          },
                                                          child: Container(
                                                              width: 35.w,
                                                              height: 35.h,
                                                              // padding: EdgeInsets.only(bottom: 30.sp),
                                                              margin: EdgeInsets.only(right: 13.sp,bottom: 30.sp),
                                                              decoration: BoxDecoration(
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Color(0xff0083F7),
                                                                    ),
                                                                    BoxShadow(
                                                                      color: Color.fromRGBO(0, 0, 0, 0.9),
                                                                      spreadRadius: -1,
                                                                      blurRadius: 10,
                                                                      offset: Offset(0, 0),
                                                                      // blurStyle: BlurStyle.solid
                                                                    )
                                                                  ]
                                                              ),
                                                              child: Image.asset('assets/images/check33.png')),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height:40.h,
                                                width:300.w,
                                                child: ListView.separated(
                                                  scrollDirection: Axis.horizontal,
                                                  //ProductCubit.get(context).optionsMap[productId]!.length,
                                                  itemCount: ProductCubit.get(context).products![index].options!.length,
                                                  separatorBuilder: (context, index3) {
                                                    return SizedBox(
                                                      width: 20.w,
                                                    );
                                                  },
                                                  // Adjust the number of items as needed
                                                  itemBuilder: (BuildContext context, int index2) {
                                                    ProductCubit.get(context).calculateIncreasedValue(ProductCubit.get(context).products![index].options![index2].price!);
                                                    num priceAfterIncreasedValue = (ProductCubit.get(context).products![index].options![index2].price ?? 0) +
                                                        (ProductCubit.get(context).increasedValue ?? 0);

                                                    // log(ProductCubit.get(context).pric.toString());
                                                    // int h=ProductCubit.get(context).products![index].options![index2].price!+int.parse(ProductCubit.get(context).increasedValue.toString());
                                                    return GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (_) => AlertDialog(
                                                            backgroundColor: Color.fromRGBO(0, 0, 0, 0.9),
                                                            title: Center(child: Text(currentLang=='en'?
                                                            ProductCubit.get(context).products![index].options![index2].nameEn!
                                                                :ProductCubit.get(context).products![index].options![index2].nameAr!,
                                                              style: TextStyle(color: Colors.white),)),
                                                            content: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    //
                                                                    FloatingActionButton.small(
                                                                      heroTag: 'btn$index2',
                                                                      backgroundColor: Colors.black.withOpacity(0.1),
                                                                      foregroundColor: Color(0XFF0EC2D1),
                                                                      onPressed: () {
                                                                        // // log("aldkla${optionsMap!['26']?[0].id}");
                                                                        AddProductCubit.get(context)
                                                                            .incrementQuantity();
                                                                      },
                                                                      child: Icon(
                                                                        Icons.add,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 2.w,
                                                                    ),
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.black38,
                                                                        borderRadius: BorderRadius
                                                                            .circular(2),
                                                                      ),
                                                                      width: 30.w,
                                                                      child:  BlocBuilder<AddProductCubit, AddProductStates>(
                                                                        builder: (context, state) {
                                                                          return Center(
                                                                            child: Text(
                                                                              "${AddProductCubit.get(context).quantity}",
                                                                              style: TextStyle(
                                                                                fontSize: 20,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                    FloatingActionButton.small(
                                                                      heroTag: 'btn$index2',
                                                                      backgroundColor: Colors.black
                                                                          .withOpacity(0.1),
                                                                      foregroundColor: Color(0XFF0EC2D1),
                                                                      onPressed: () {
                                                                        AddProductCubit.get(context)
                                                                            .decrementQuantity();
                                                                      },
                                                                      child: Icon(
                                                                        Icons.remove,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  children: [
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      child: Text(
                                                                        Trans('Cancel').tr,
                                                                        style: TextStyle(
                                                                            color: Colors.white),
                                                                      ),
                                                                    ),
                                                                    SizedBox(width: 16.w),
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        AddProductCubit.get(context).addOption(
                                                                            ProductCubit.get(context).optionsMap[ProductCubit.get(context).products![index].id.toString()]![index2].id,
                                                                            AddProductCubit.get(context).quantity);
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      child: Text(
                                                                        Trans('Done').tr,
                                                                        style: TextStyle(
                                                                          color: Color(
                                                                              0XFF0EC2D1),),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                        );
                                                      },
                                                      child: Container(
                                                        width: 130.w,
                                                        // height: 60.h,
                                                        padding: EdgeInsets.only(top:5.sp),
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Color(0xff0083F7),
                                                              ),
                                                              BoxShadow(
                                                                color: Color.fromRGBO(0, 0, 0, 0.9),
                                                                spreadRadius: -1,
                                                                blurRadius: 20,
                                                                offset: Offset(0, 0),
                                                                // blurStyle: BlurStyle.solid
                                                              )
                                                            ]
                                                        ),
                                                        child: Text(currentLang=='en'?
                                                        "${ProductCubit.get(context).products![index].options![index2].nameEn} "
                                                            "${priceAfterIncreasedValue} AUD":
                                                        ProductCubit.get(context).products![index].options![index2].nameAr.toString()+" "+
                                                            ProductCubit.get(context).products![index].options![index2].price.toString()+" AUD",
                                                          style: TextStyle(color: Colors.white,
                                                            fontSize: 15.sp,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
