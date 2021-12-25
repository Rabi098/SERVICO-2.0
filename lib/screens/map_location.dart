import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plumbify/services/database.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/material.dart';
class Map_location extends StatefulWidget {
  @override
  _Map_locationState createState() => _Map_locationState();
}

class _Map_locationState extends State<Map_location> {
  LatLng currentLocation;
  GoogleMapController _mapController;
  final completeAddress = TextEditingController();
  final nearby = TextEditingController();
  geoCurrentLocation() async {
    final geoPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(geoPosition.latitude, geoPosition.longitude);
    });
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
    final locationData = currentLocation;

    return Scaffold(
      appBar: AppBar(title: Text('Add Location'),),
      body: Stack(
        children: [
          GoogleMap(initialCameraPosition: CameraPosition(
            target: currentLocation,
            zoom:15.0
          ),
          zoomControlsEnabled: true,
            //minMaxZoomPreference: MinMaxZoomPreference(1.5,2.8),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            mapToolbarEnabled: true,
            zoomGesturesEnabled: true,
            tiltGesturesEnabled: true,
            onCameraMove: (CameraPosition position) async{
              currentLocation = LatLng(position.target.latitude, position.target.longitude);
              print(position.zoom.toString()+'---------------------------------------------------------------');
            },
            onMapCreated: onCreated,
          ),
          Center(
            child: Icon(
              Icons.location_on,
              color:Colors.red,
              size: 36,
            ),
          ),
          SlidingUpPanel(
              maxHeight: 300,
              panel:SlidingPanel()
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
            if(result == true){
                print('True Return');
            }else{
              print('False Return');
            }
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
}

