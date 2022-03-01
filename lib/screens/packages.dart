import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plumbify/screens/PkgOrder.dart';
import 'package:plumbify/screens/booking_details.dart';
import 'package:plumbify/screens/rewards.dart';
import 'package:plumbify/services/auth_services.dart';

class Packages extends StatefulWidget {
  AuthBase auth;
  Packages({this.auth});
  @override
  _PackagesState createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  final Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection("Packages").snapshots();
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];


  void getPostsData() {


  }

  @override
  void initState() {
    super.initState();
    //getPostsData();
    controller.addListener(() {

      double value = controller.offset/119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.red,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.cancel),
            color: Colors.black,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
            height: size.height,
            child: StreamBuilder<QuerySnapshot>(
                stream: users,
                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasError){
                    return Text("Something went wrong");
                  }
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Text("Loading");
                  }

                  final data = snapshot.requireData;
                  //print(data.docs[0]['Title']);
                  return Column(
                    children: <Widget>[

                      const SizedBox(
                        height: 10,
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: closeTopContainer?0:1,
                        child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: size.width,
                            alignment: Alignment.topCenter,
                            height: closeTopContainer?0:categoryHeight,
                            child: categoriesScroller),
                      ),
                      Expanded(
                          child: ListView.builder(
                              controller: controller,
                              itemCount: data.docs.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                double scale = 1.0;
                                if (topContainer > 0.5) {
                                  scale = index + 0.5 - topContainer;
                                  if (scale < 0) {
                                    scale = 0;
                                  } else if (scale > 1) {
                                    scale = 1;
                                  }
                                }
                                return Opacity(
                                  opacity: scale,
                                  child: Transform(
                                    transform:  Matrix4.identity()..scale(scale,scale),
                                    alignment: Alignment.bottomCenter,
                                    child: Align(
                                        heightFactor: 0.7,
                                        alignment: Alignment.topCenter,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => PkgBooking(auth: widget.auth,data: data,index: index)));
                                          },
                                          child: Container(
                                              height: 150,
                                              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
                                                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
                                              ]),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text(
                                                          data.docs[index]['Title'],
                                                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                        ),
                                                        Text(
                                                            'SERVICO',
                                                          style: const TextStyle(fontSize: 13, color: Colors.grey),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "\Rs ${data.docs[index]["Price"]}",
                                                          style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                                                        )
                                                      ],
                                                    ),
                                                    Image.network(
                                                      "${data.docs[index]["Image"]}",
                                                      height: double.infinity,
                                                      width: 100,
                                                    )
                                                  ],
                                                ),
                                              )),
                                        )

                                    ),
                                  ),
                                );
                              })),
                    ],
                  );
                }
            )
        ),
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Most\nFavorites",
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "20 Items",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.blue.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Newest",
                          style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "20 Items",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.lightBlueAccent.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Super\nSaving",
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "20 Items",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

