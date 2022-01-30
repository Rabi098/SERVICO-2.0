import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/material.dart';
import '../Controller/UserController.dart';
import '../model/user.dart';
class Map_location extends StatefulWidget {
  @override
  _Map_locationState createState() => _Map_locationState();
}

class _Map_locationState extends State<Map_location> {
  LatLng currentLocation;
  UserController userController = Get.find(tag:'user_controller');

  GoogleMapController _mapController;
  final completeAddress = TextEditingController();
  final nearby = TextEditingController();
  geoCurrentLocation() async {
    GeoPoint data = userController.user.value.geoPoint;
    if(data.latitude != 0 && data.longitude != 0) {
      setState(() {
        currentLocation = LatLng(data.latitude, data.longitude);
      });
    }else {
      final geoPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentLocation = LatLng(geoPosition.latitude, geoPosition.longitude);
      });
    }
  }
  void initState(){
    geoCurrentLocation();
    super.initState();
  }
  void onCreated(GoogleMapController controller){
    setState(() {
      _mapController = controller;
    });
  }
  @override
  Widget build(BuildContext context) {

    completeAddress.text = userController.user.value.full_address;
    nearby.text = userController.user.value.nearby_address;

      return Scaffold(
        appBar: AppBar(title: Text('Add Location'),),
        body: Stack(
          children: [
            GoogleMap(initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 15.0
            ),
              zoomControlsEnabled: true,
             //  minMaxZoomPreference: MinMaxZoomPreference(1.5,2.8),
               myLocationEnabled: true,
               myLocationButtonEnabled: true,
               mapType: MapType.normal,
               mapToolbarEnabled: true,
               zoomGesturesEnabled: true,
              tiltGesturesEnabled: true,
              onCameraMove: (CameraPosition position) async {
                currentLocation =
                    LatLng(position.target.latitude, position.target.longitude);
                print(position.zoom.toString() +
                    '---------------------------------------------------------------');
              },
              onMapCreated: onCreated,
            ),
            Center(
              child: Icon(
                Icons.location_on,
                color: Colors.red,
                size: 36,
              ),
            ),
            SlidingUpPanel(
                maxHeight: 300,
                panel: SlidingPanel()
            )


          ],
        ),
      );

  }
  Widget SlidingPanel(){
    return Column(
      children:<Widget> [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              Icon(Icons.keyboard_arrow_up),
              Text('Save Address')
            ]
        ),

        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              Container(
                height: 45,
                width: 300,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 243, 243, 1),
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  controller: completeAddress,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Complete Address",
                    hintStyle:
                    TextStyle(color: Colors.grey, fontSize: 15),
                  ),

                ),
              ),
              SizedBox(height: 15,),


            ]
        ),
        SizedBox(height: 15,),
        Container(
          height: 45,
          width: 300,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Color.fromRGBO(244, 243, 243, 1),
              borderRadius: BorderRadius.circular(15)),
          child: TextField(
            controller: nearby,
            decoration: InputDecoration(

              border: InputBorder.none,
              hintText: "Nearby Popular Place(Optional)",
              hintStyle:
              TextStyle(color: Colors.grey, fontSize: 15),
            ),

          ),
        ),
        SizedBox(height: 15,),
        GestureDetector(
          onTap: (){
            bool result= true;
            updateProfileData();
          },
          child: Container(
              alignment: Alignment.center,
              height: 35,
              width: 150,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Text('Save Address',style: TextStyle(color: Colors.white),)
          ),
        ),
      ],
    );
  }
  updateProfileData() {
    setState(() {
      USer user = USer(
        uid: userController.user.value.uid,
        name: userController.user.value.name,
        email: userController.user.value.email,
        full_address: completeAddress.text,
        nearby_address: nearby.text,
        geoPoint: GeoPoint(currentLocation.latitude,currentLocation.longitude),
        phone: userController.user.value.phone,
        profile_pic: userController.user.value.profile_pic,
      );
      userController.postUser(user);
      bool isUpdated;
      setState(() {
        userController.user.value = user;
      });

      // SnackBar snackbar = SnackBar(content: Text("Profile updated!"));
      // _scaffoldKey.currentState.showSnackBar(snackbar);
    });
  }
}

