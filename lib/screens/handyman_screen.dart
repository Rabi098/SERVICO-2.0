import 'package:flutter/material.dart';
import 'package:plumbify/model/handyman.dart';

class HandymanScreen extends StatefulWidget {
  HandymanScreen({Key key}) : super(key: key);
  @override
  _HandymanScreenState createState() => _HandymanScreenState();
}

class _HandymanScreenState extends State<HandymanScreen> {
  int length=0;
  @override

  Widget build(BuildContext context) {
      //final mealid = ModalRoute.of(context).settings.arguments as String;
      //final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealid);
    final args= ModalRoute.of(context).settings.arguments as Map<String, Handyman>;
    Handyman obj = args['handyman'];
    return Scaffold(
        //title
        appBar: AppBar(title: Text(obj.name),
      /*  actions: [
        FlatButton.icon(onPressed: () {
          Navigator.push(context,
          new MaterialPageRoute(builder: (context) => null));
          },

        icon: null,
        label:Text('')
        )
        ],*/
        ),

        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(
                      //imageURL
                      obj.profilePic,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(

                      child: ListView(
                        padding: EdgeInsets.all(15),
                          children: <Widget>[

                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 15),
                              child: Text('${obj.name}',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 15),
                              child: Text('Price: ${obj.price.toString()}',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                            ),
                            Container(
                          margin: EdgeInsets.symmetric(
                               vertical: 15),
                          child: Text('Description',
                              style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                      ),
                      Text(
                            obj.desc,
                            style: TextStyle(fontSize: 18),
                          ),
                      Expanded(
                        child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('bookingdetails',arguments: {'handyman':obj});
                              },
                              child: Container(
                                width: 200,
                                height: 50,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(bottom: 3,top: 3),
                                child: Text(
                                  'Book Now',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white

                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.all(Radius.circular(24))),

                              ),
                            )

                        ),
                        flex: 10,
                        ),




                      ])
                  ),
                ]),
          ),
        ),


    //FloatingActionButton(onPressed: () {
         // addItemtoCart();
        //}, child: length == 0 ? Icon(Icons.add) : Text(length.toString()),),
        );
    }
  }
