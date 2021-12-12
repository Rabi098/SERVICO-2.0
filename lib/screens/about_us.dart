import 'package:flutter/material.dart';
class AboutUS extends StatefulWidget {
  @override
  _AboutUSState createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(title:  Text('About Us'),


        ),
        body:Container(
        child: ListView(
                  padding: EdgeInsets.all(15),
                  children: <Widget>[

          Container(
              margin: EdgeInsets.symmetric(
                  vertical: 15),
              child: Text('1.What is SERVICO?',
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: 15),
            child: Text('SERVICO is a marketplace where no electrician and plumber (handyman) goes unemployed and households and businesses get the finest handyman services easily and conveniently.',
                style:
                TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: 15),
            child: Text('2.What’s our vision?',
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: 15),
            child: Text('Our Vision is to make such marketplace where no electrician and plumber (handyman) goes unemployed and households and businesses get the finest handyman services, easily and conveniently',
                style:
                TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
          ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 15),
                      child: Text('3. Contact us?',
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 15),
                      child: Text('Our team will try their best to reach you and help you as soon as possible.\n\nEmail us : servico@gmail.com\nContact no: 03152224237',
                          style:
                          TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
                    ),
         ])
        ));
  }
}
