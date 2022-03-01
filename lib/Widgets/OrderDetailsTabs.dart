import 'package:flutter/material.dart';
import 'package:plumbify/screens/order_history.dart';
import 'package:plumbify/screens/order_inprogress.dart';
import 'package:plumbify/services/auth_services.dart';

class OrderDetails extends StatefulWidget {
  AuthBase auth;
  OrderDetails({this.auth});
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                tabs: [
                  Tab(
                    text: 'Order in Process',
                  ),
                  Tab(
                    text: 'Order History',
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OrderInProcess(),
            OrderHistory(auth: widget.auth),
          ],
        ),
      ),
    );
  }
}
