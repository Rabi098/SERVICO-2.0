import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Handyman{
  String id;
  String name;
  String Type;
  String phoneNum;
  String desc;
  String profilePic;
  LatLng location;
  int price;
  Handyman({this.id,this.name,this.Type,this.phoneNum,this.desc,this.location,this.profilePic,this.price});
}