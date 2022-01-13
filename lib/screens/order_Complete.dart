import 'package:flutter/material.dart';

class isOrderPlaced extends StatelessWidget {
  bool isPlaced =true;
  @override
  Widget build(BuildContext context) {
    final args= ModalRoute.of(context).settings.arguments as Map<String, bool>;
    bool isPlaced = args['isPlaced'];
    return Scaffold(
    appBar: AppBar(
      title: Text('Order Compeletion'),
    ),
    body: Builder(builder: (context) {
      return isPlaced==true?orderPlaced(context):orderPlaced(context);
    },
    )
);
  }
  Widget errorOccurred(BuildContext context){
    return Container(
        child: Text(
        'ORDER Not Placed!\n An Error Occurred',style: TextStyle(fontSize:20)
    ),);
  }

  Widget orderPlaced(BuildContext context){
    return Container(
      child: Text(
          'ORDER Placed!\n Successfully',style: TextStyle(fontSize:20)
      ),);
  }
}
