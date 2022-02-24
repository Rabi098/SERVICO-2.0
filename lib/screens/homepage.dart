import 'package:plumbify/screens/packages.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

  int currentPos = 0;
  List<String> listPaths = [
    "assets/electricianpic.jpg",
    "assets/plumberpic.png",
    "assets/plumberpic2.png"
  ];


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
      onTap: function,
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

      // appBar: AppBar(
      //   title: Text("SERVICO"),
      //   actions: <Widget>[
      //     IconButton(onPressed:(){ Navigator.of(context).pushNamed('location');}, icon: Icon(Icons.location_pin,color: Colors.white,))
      //   ],
      // ),
      //drawer: MainDrawer(auth: widget.auth,),
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
                //padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Container(
                    //   padding: EdgeInsets.all(5),
                    //   decoration: BoxDecoration(
                    //       color: Color.fromRGBO(244, 243, 243, 1),
                    //       borderRadius: BorderRadius.circular(15)),
                    //   child: TextField(
                    //     decoration: InputDecoration(
                    //         border: InputBorder.none,
                    //         prefixIcon: Icon(
                    //           Icons.search,
                    //           color: Colors.black87,
                    //         ),
                    //         hintText: "Search you're looking for",
                    //         hintStyle:
                    //         TextStyle(color: Colors.grey, fontSize: 15)),
                    //   ),
                    // ),
                CarouselSlider(
                  items: [
                    //1st Image of Slider
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(listPaths[0],fit: BoxFit.fill,),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(listPaths[1],fit: BoxFit.fill),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(listPaths[2],fit: BoxFit.fill),
                    ),
                  ],
                  //Slider Container properties
                  options: CarouselOptions(
                    onPageChanged: (index , reason) {
                      setState(() {
                        currentPos = index;
                      });
                    },
                    autoPlay: true,
                    height: MediaQuery.of(context).size.height * 0.3,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    viewportFraction:1,
                  ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: listPaths.map((url) {
                    int index = listPaths.indexOf(url);
                    return Container(
                      width: 20.0,
                      height: 10.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentPos == index
                            ? Colors.black
                            : Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    );
                  }).toList(),
                ),
                    Center(
                      child: Text(
                        'Get it Done!',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                        'on Just Few Taps',
                        style: TextStyle(color: Colors.black87, fontSize: 25),
                      ),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      padding: EdgeInsets.all(10),
                      child: ListView(
                          children: <Widget>[

                            BuildListTile('assets/elec.jpg','Hire Electrician',(){
                              Navigator.of(context).pushNamed('electricians');
                            }),
                            SizedBox(height: 15),
                            BuildListTile('assets/plum.png','Hire Plumber',(){
                              Navigator.of(context).pushNamed('plumber');
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


