import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
class AddLocation extends StatefulWidget {
  @override
  _AddLocationState createState() => _AddLocationState();

}

class _AddLocationState extends State<AddLocation> {
  String latitudeData = '';
  String longitudeData = '';
  bool map=true;
  double heighT;
  final completeAddress = TextEditingController();
  final nearby = TextEditingController();

  Position positionData;
  Set<Marker> _pin ={};
  @override
  void initState(){
    super.initState();
    geoCurrentLocation();
  }
  geoCurrentLocation() async {
    final geoPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      positionData = geoPosition;
      latitudeData = '${geoPosition.latitude}';
      longitudeData = '${geoPosition.longitude}';
      debugPrint(longitudeData+"  "+latitudeData);
    }
    );
    setState(() {
      _pin.removeAll(_pin);
      _pin.add(Marker(
        markerId: MarkerId("abc"),
        position: LatLng(positionData.latitude,positionData.longitude),

      ));
    });
    return null;

  }
  @override
  Widget build(BuildContext context) {
    debugPrint(longitudeData + "  " + latitudeData);
    if (positionData == null) {
      geoCurrentLocation().then((_)
      {
        setState((){
        });
      }
      );
      return Scaffold(
        backgroundColor: Colors.white10,
      );

    }
    else
    {
      return Scaffold(
          appBar: AppBar(title: Text('Add Location'),),
          body:Stack(
            children: <Widget> [
              GoogleMap(
                onTap: (position){
                  setState(() {
                    _pin.removeAll(_pin);
                    _pin.add(Marker(
                      markerId: MarkerId("abc"),
                      position: position,

                    ));
                  });
                },
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                    target: LatLng(positionData.latitude,positionData.longitude),
                    zoom
                        :
                    15
                ),
                markers: _pin,
              ),

              SlidingUpPanel(
                  maxHeight: 300,
                  panel:SlidingPanel()
              )


            ],
          )
      );


    }
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
