import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/database.dart';
import '../model/user.dart';
class UserController extends GetxController{
  var user = USer().obs;

  void onInit() async {
    super.onInit();
  }

  bool user_null(){
    user.value =null;
    if(user.value == null)
      return true;
    else
      return false;
  }
    postUser(USer temp)async{

       var value = await DatabaseMethods().addUser(temp);
       user.value = temp;
  }


  Future<bool> updateUser()async{
    await DatabaseMethods().addUser(user.value);
  }


   fetchUser(String uid) async {
   USer uSer = await DatabaseMethods().getUser(uid);
   user.value = uSer;
   if(uSer == null)
      print('------------------------------------'
      +'NULL'+'-----------------------------------------'+uSer.toString());
  }

}
