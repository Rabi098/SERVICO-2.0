import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class USer {
  final String uid;
  final String email;
  String name;
  String phone;
  String profile_pic;
  String full_address;
  String nearby_address;
  String reward;
  GeoPoint geoPoint;
  USer({this.uid,this.email,this.name,this.phone,this.profile_pic,this.geoPoint,this.full_address,this.nearby_address,this.reward});
  @override


  String toString() {
    // TODO: implement toString
    return super.toString();
  }

}
