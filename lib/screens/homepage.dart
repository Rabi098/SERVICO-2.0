import 'package:plumbify/screens/packages.dart';

import 'app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:plumbify/services/auth_services.dart';

class Home extends StatefulWidget {
  Home({@required this.auth});
  final AuthBase auth;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  Widget promoCard(String image) {
    return AspectRatio(
      aspectRatio: 2.62 / 3,
      child: Container(
        margin: EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                0.1,
                0.9
              ], colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.1)
              ])),
        ),
      ),
    );
  }
  // ignore: non_constant_identifier_names
  Widget BuildListTile(String image,String text,Function function){
    return InkWell(
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(image)),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                stops: [
                  0.3,
                  0.9
                ],
                colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.2)
                ]),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                text,
                style:
                TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),

      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SERVICO"),
        actions: <Widget>[
          IconButton(onPressed:(){ Navigator.of(context).pushNamed('location');}, icon: Icon(Icons.location_pin,color: Colors.white,))
        ],
      ),
      drawer: MainDrawer(auth: widget.auth,),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Get it Done!',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'on Just Few Taps',
                      style: TextStyle(color: Colors.black87, fontSize: 25),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 243, 243, 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black87,
                            ),
                            hintText: "Search you're looking for",
                            hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 15)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 500,
                      padding: EdgeInsets.all(10),
                      child: ListView(
                          children: <Widget>[

                            BuildListTile('assets/elec.jpg','Hire Electrician',(){
                              Navigator.of(context).pushNamed(null);}),
                            SizedBox(height: 15),
                            BuildListTile('assets/plum.png','Hire Plumber',(){
                              Navigator.of(context).pushNamed(null);
                            }),
                            SizedBox(height: 15),
                            BuildListTile('assets/deals.jpg','Deals',(){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Packages()));
                            }
                              ),
                            SizedBox(height: 70),
                          ]

                      ),
                    ),/*Container(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          promoCard('assets/images/one.jpg'),
                          promoCard('assets/images/two.jpg'),
                          promoCard('assets/images/three.jpg'),
                          promoCard('assets/images/four.jpg'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),*/

                  ],
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}


