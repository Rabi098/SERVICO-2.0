import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class OrderHistory extends StatefulWidget {

  final now = DateTime.now();
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: 10,
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
                      Text("Gurdeep",style: TextStyle(fontSize: 17),),
                      Text("500",style: TextStyle(fontSize: 17),),
                      Text("Electrician",style: TextStyle(fontSize: 17),),
                      Text('12/03/12',style: TextStyle(fontSize: 17),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },);
  }
}
