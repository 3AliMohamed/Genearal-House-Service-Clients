import 'dart:developer';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:general_house_service_clients/presentation_layer/screens/add_new_address.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../../reusable/app_bar.dart';
import '../../reusable/bottom_navigation_bar.dart';
class ChooseFromMap extends StatefulWidget {
  @override
  _ChooseFromMapState createState() => _ChooseFromMapState();
}

class _ChooseFromMapState extends State<ChooseFromMap> {
  GoogleMapController? mapController;
  LocationData? currentLocation;
  @override
  void initState() {
    super.initState();

  }

  // Get the current location using the location package
  Future<void> getLocation() async {
    Location location = Location();

    try {
      LocationData _locationData = await location.getLocation();
      setState(() {
        currentLocation = _locationData;
      });

      // Move the camera to the current location
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              currentLocation?.latitude ?? 0.0,   // Use a default value (0.0) if null
              currentLocation?.longitude ?? 0.0,  // Use a default value (0.0) if null
            ),
            zoom: 15.0,
          ),
        ),
      );
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children:[ GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(0.0, 0.0), // Initial camera position
            zoom: 10.0,
          ),
        ), 
        Positioned(
          top: 660.sp,
          child:InkWell(
          onTap: (){
            getLocation();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNewAddress(long: currentLocation?.longitude,lat: currentLocation?.latitude,)));
          },
          child: Container(
            margin: EdgeInsets.only(top:50.sp,left: 70.sp),
            padding: EdgeInsets.all(1.sp),
            width: 280.w,
            height: 37.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xff0083F7),
                ),
                BoxShadow(
                  color: Color.fromRGBO(0,0, 0, 0.9),
                  spreadRadius: -3,
                  blurRadius: 10,
                  offset: Offset(5,5),
                  // blurStyle: BlurStyle.solid
                )
              ],
              // color: Color(0xff157A82),
              borderRadius: BorderRadius.circular(5.sp),
            ),
            child: Text('Locate Me And Confirm Location',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,
                fontSize: 20.sp,
              ),
            ),
          ),
        ),
        )
        ]
      ),
    );
  }
}
