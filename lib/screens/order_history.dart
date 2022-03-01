import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:plumbify/Controller/UserController.dart';
import 'package:plumbify/services/auth_services.dart';
class OrderHistory extends StatefulWidget {
  AuthBase auth;
  OrderHistory({this.auth});

  final now = DateTime.now();
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

List<Order> items = [];

class _OrderHistoryState extends State<OrderHistory> {
  UserController userController = Get.find(tag:'user_controller');
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore roofRef = FirebaseFirestore.instance;
    CollectionReference alluserRef = roofRef.collection('Orders');
    Query orders = alluserRef.where("customerId", isEqualTo: userController.user.value.uid);
    orders.snapshots().listen((event) {
      for(int i=0; i <event.docs.length; i++)
        {
          items.add(Order(customerId: event.docs[i]['customerId']));
          items.add(Order(orderDate: event.docs[i]['orderDate']));
          items.add(Order(amount: event.docs[i]['amount']));
        }
    });
      return ListView.builder(
          itemCount: items.length,
        itemBuilder: (BuildContext context, index){
          return Container(
            height: 150,
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Card(
              elevation: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Worker Name:',style: TextStyle(fontSize: 17),),
                        Text('Total pay:',style: TextStyle(fontSize: 17),),
                        Text('Service type:',style: TextStyle(fontSize: 17),),
                        Text('Date and Time:',style: TextStyle(fontSize: 17),),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(items[index].customerId,style: TextStyle(fontSize: 17),),
                        Text(items[index].amount != null? items[index].amount : "0",style: TextStyle(fontSize: 17),),
                        Text("Electrician",style: TextStyle(fontSize: 17),),
                        Text("12/02/2022",style: TextStyle(fontSize: 17),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        );

  }
}



class Order {
  String id;
  String HandymanId;
  String amount;
  String customerId;
  GeoPoint handyman_location;
  GeoPoint customer_location;
  String orderDate;
  String status;
  String Totaltime;
  int user_points;
  Timestamp updateDate;
  Timestamp starttime;
  Timestamp endtime;
  List images;

  Order({this.Totaltime,this.user_points,this.starttime,this.endtime,this.id,this.status,this.amount,this.customer_location,this.customerId,this.handyman_location,this.orderDate, this.HandymanId, this.images,this.updateDate});
  void setStatus(String status){
    this.status = status;
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }

}