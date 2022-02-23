import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:plumbify/services/auth_services.dart';
class Rewards extends StatefulWidget {
  Rewards({this.auth});
  final AuthBase auth;


  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {

  String user = "";

  Future<void> userid() async {
    user = widget.auth.currentUser.uid;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userid();
  }
  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> Userdata = FirebaseFirestore.instance.collection("/Users").doc(user).snapshots();

    return Scaffold(
        appBar: AppBar(title:  Text('Rewards'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Reward Points: ",style: TextStyle(fontSize: 30,color: Colors.red,fontWeight: FontWeight.bold),)),
            Container(
              width: double.infinity,
              height: 150,
              child: Card(
                child: StreamBuilder<DocumentSnapshot>(
                  stream: Userdata,
                  builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if(snapshot.hasError){
                      return Text("Something went wrong");
                    }
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Text("Loading");
                    }
                    var data;
                    String points = "0";
                    try {
                      data = snapshot.requireData;
                      points = data['Reward_Points'];
                    } catch (e) {
                      print(e);
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/coin.jpg",width: 40,height: 40,),
                            Text("$points points",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                          ],),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: () {

                          },
                          child: Container(
                            width: 120,
                            height: 40,
                            child: Center(child: Text("Use Now",style: TextStyle(fontSize: 18,color: Colors.white),)),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
                elevation: 8,
                shadowColor: Colors.red,
                margin: EdgeInsets.all(20),
                shape:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red, width: 1)
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Redeem Points Criteria",style: TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold),)),
            Container(
              width: double.infinity,
              height: 120,
              child: Card(
                child: ListTile(
                  title: Row(
                    children: [
                      Image.asset("assets/coin.jpg",width: 30,height: 30,),
                      Text("100 Points",style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: 100,),
                      Text("10% Discount",style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                elevation: 8,
                shadowColor: Colors.red,
                margin: EdgeInsets.all(20),
                shape:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red, width: 1)
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 120,
              child: Card(
                child: ListTile(
                  title: Row(
                    children: [
                      Image.asset("assets/coin.jpg",width: 30,height: 30,),
                      Text("1000 Points",style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: 95,),
                      Text("Free Service",style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                elevation: 8,
                shadowColor: Colors.red,
                margin: EdgeInsets.all(20),
                shape:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red, width: 1)
                ),
              ),
            )
          ],
        )
    );
  }
}
