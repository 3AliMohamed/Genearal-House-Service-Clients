import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../business_logic_layer/cubit/app_cubit/cubit.dart';
import '../reusable/app_bar.dart';
import '../reusable/bottom_navigation_bar.dart';
class ChooseFromMap extends StatefulWidget {
  @override
  _ChooseFromMapState createState() => _ChooseFromMapState();
}

class _ChooseFromMapState extends State<ChooseFromMap> {
  GoogleMapController? mapController;
  LocationData? currentLocation;
  int selectedTab =1;
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
          },
          child: Container(
            margin: EdgeInsets.only(top:50.sp,left: 70.sp),
            padding: EdgeInsets.all(1.sp),
            width: 280.w,
            height: 37.h,
            decoration:  BoxDecoration(
              color: Color(0xff157A82),
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
