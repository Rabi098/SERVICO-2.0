import 'package:flutter/material.dart';
class OrderInProcess extends StatefulWidget {

  @override
  _OrderInProcessState createState() => _OrderInProcessState();
}

class _OrderInProcessState extends State<OrderInProcess> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: 5,
      itemBuilder: (BuildContext context, index){
        return Container(
          height: 150,
          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
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
