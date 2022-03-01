import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plumbify/Controller/UserController.dart';
import 'package:plumbify/model/handyman.dart';
import 'package:plumbify/screens/order_Complete.dart';
import 'package:plumbify/screens/polylineView.dart';
import 'package:plumbify/services/auth_services.dart';
import 'package:plumbify/services/database.dart';
import '../utils/CustomTextStyles.dart';

class PkgBooking extends StatefulWidget {
  final AuthBase auth;
  int index;
  QuerySnapshot data;
  PkgBooking({Key key, @required this.auth,this.data,this.index}) : super(key: key);
  UserController userController;

  @override
  _PkgBookingState createState() => _PkgBookingState();
}

class _PkgBookingState extends State<PkgBooking> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    widget.userController = Get.find(tag:'user_controller');

    // final args= ModalRoute.of(context).settings.arguments as Map<String, Handyman>;
    // Handyman obj = args['handyman'];
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Confirm Booking",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      body: Builder(builder: (context) {
        return Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: ListView(
                  children: <Widget>[
                    selectedAddressSection(),
                    taskDescription(),
                    priceSection(int.parse(widget.data.docs[widget.index]["Price"]))
                  ],
                ),
              ),
              flex: 90,
            ),
            Expanded(
              child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: updateButton(context, 'Confirm', (){
                    DateTime today = DateTime.now();
                    var x = DatabaseMethods().addPkgOrder(widget.data.docs[widget.index].id,widget.data.docs[widget.index]['Price'],widget.auth.currentUser.uid,GeoPoint(0,0),'Pending',today,today);
                    print('Afterr*************************************');
                    if(x == true){
                      //Navigator.of(context).pushNamed('isOrderPlaced',arguments: {'isPlaced':true});
                      Navigator.of(context).popAndPushNamed('isOrderPlaced',arguments: {'isPlaced':true});
                    }else
                    {

                      Navigator.of(context).popAndPushNamed('isOrderPlaced',arguments: {'isPlaced':false});
                      //Navigator.of(context).pushNamed('isOrderPlaced',arguments: {'isPlaced':false});

                    }
                  })
              ),
              flex: 10,
            )

          ],

        );
      }),
    );
  }
  taskDescription(){
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description\n',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
          Text(widget.data.docs[widget.index]["Description"],style: TextStyle(fontSize: 16),),
          SizedBox(height: 20,),
          Row(
            children: [
              Text("Title :",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
              SizedBox(width: 20,),
              Text(widget.data.docs[widget.index]['Title'],style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.green),),
            ],
          ),
          Row(
            children: [
              Text("Price :",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
              SizedBox(width: 20,),
              Text("Rs:" + widget.data.docs[widget.index]["Price"],style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.green),),
            ],
          ),
          Row(
            children: [
              Text("Brand :",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
              SizedBox(width: 20,),
              Text("Servico",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.green),),
            ],
          ),
        ],
      ),
    );
  }

  updateButton(BuildContext context,String title,Function function){
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        width: 200,
        height: 30,
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 3,top: 3),
        child: Text(
          title,
          style: CustomTextStyle.textFormFieldMedium
              .copyWith(color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(24))),

      ),
    );
  }
  bottomSheetButtons(BuildContext context) {
    return _scaffoldKey.currentState.showBottomSheet((context) {
      return Container(
        height: 200,
        padding: EdgeInsets.all(15),
        width: double.infinity,

        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        child: Column(
          children: <Widget>[

            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 45,
                      width: 300,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 243, 243, 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Describe your Work",
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 15),
                        ),

                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 45,
                      width: 300,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 243, 243, 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Requirments(if Any)",
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 15),
                        ),

                      ),
                    ),
                    FlatButton(onPressed: (){

                    },
                        child: Text('Place Bid',style: TextStyle(color: Colors.teal,fontSize: 14),))
                    /*updateButton(context, 'Cancel Order', (){ Navigator.of(context).pushNamed(null); }),
                    SizedBox(
                      height: 24,
                    ),
                    updateButton(context, 'Processing', (){ Navigator.of(context).pushNamed(null); }),
                    SizedBox(
                      height: 24,
                    ),
                    updateButton(context, 'Complete', (){ Navigator.of(context).pushNamed(null); }),
                    SizedBox(
                      height: 24,
                    ),
                  */

                  ],
                ),
              ),
              flex: 5,
            )
          ],
        ),
      );
    },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        backgroundColor: Colors.white,
        elevation: 2);
  }

  selectedAddressSection() {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.userController.user.value.name,
                    style: CustomTextStyle.textFormFieldSemiBold
                        .copyWith(fontSize: 14),
                  ),
                  Container(
                    padding:
                    EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Text(
                      "HOME",
                      style: CustomTextStyle.textFormFieldBlack.copyWith(
                          color: Colors.indigoAccent.shade200, fontSize: 8),
                    ),
                  )
                ],
              ),
              Text(
                "Date: ${DateTime.now()}",
                style: CustomTextStyle.textFormFieldSemiBold
                    .copyWith(fontSize: 14),
              ),
              createAddressText(
                  widget.userController.user.value.full_address, 16),
              createAddressText(widget.userController.user.value.nearby_address, 6),

              SizedBox(
                height: 6,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Mobile : ",
                      style: CustomTextStyle.textFormFieldMedium
                          .copyWith(fontSize: 12, color: Colors.grey.shade800)),
                  TextSpan(
                      text: widget.userController.user.value.phone,
                      style: CustomTextStyle.textFormFieldBold
                          .copyWith(color: Colors.black, fontSize: 12)),
                ]),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey.shade300,
                height: 1,
                width: double.infinity,
              ),
              addressAction()
            ],
          ),
        ),
      ),
    );
  }

  createAddressText(String strAddress, double topMargin) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      child: Text(
        strAddress,
        style: CustomTextStyle.textFormFieldMedium
            .copyWith(fontSize: 12, color: Colors.grey.shade800),
      ),
    );
  }

  addressAction() {
    return Container(
      child: Row(
        children: <Widget>[
          Spacer(
            flex: 2,
          ),

          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }


  priceSection(int price) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(color: Colors.grey.shade200)),
            padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 4,
                ),
                Text(
                  "PRICE DETAILS",
                  style: CustomTextStyle.textFormFieldMedium.copyWith(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 4,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Package (Assets Included): ",
                      style: CustomTextStyle.textFormFieldSemiBold
                          .copyWith(color: Colors.black, fontSize: 12),
                    ),
                    Text(
                      getFormattedCurrency(price),
                      style: CustomTextStyle.textFormFieldMedium
                          .copyWith(color: Colors.black, fontSize: 12),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text("Use Reward Points",style:  CustomTextStyle.textFormFieldSemiBold
                //         .copyWith(color: Colors.black, fontSize: 12),),
                //     TextField(
                //       keyboardType: TextInputType.number,
                //       decoration: InputDecoration(
                //         border: OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.black)
                //         )
                //       ),
                //     )
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getFormattedCurrency(int amount) {

    return 'Rs. ${amount.toString()}';
  }

  createPriceItem(String key, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
            style: CustomTextStyle.textFormFieldMedium
                .copyWith(color: Colors.grey.shade700, fontSize: 12),
          ),
          Text(
            value,
            style: CustomTextStyle.textFormFieldMedium
                .copyWith(color: color, fontSize: 12),
          )
        ],
      ),
    );
  }
}
