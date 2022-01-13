import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore Firestore = FirebaseFirestore.instance;

class DatabaseMethods {

  getWorker(String email) async {
    return Firestore
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  addOrder(String amount, String customerId, GeoPoint customerLocation,GeoPoint  handmanLocation, String handymanId, String status, DateTime orderTime,DateTime time) async{
    bool is_Ordered = true;
    var x = Firestore.collection('Orders')
        .add({
      'amount': amount,
      'customerId': customerId,
      'customer_location':customerLocation,
      'handymanId':handymanId,
      'handyman_location':handmanLocation,
      'status':status,
      'orderDate':orderTime,
      'time':time

    }).catchError((e){
      print("--------------------------------------------------------------------------------------------");
      is_Ordered =false;
      print(e.toString());
      print("--------------------------------------------------------------------------------------------");

    });
    return is_Ordered;
  }
  getWorkers() async {
    Stream<QuerySnapshot> x = await Firestore
        .collection("Handyman")
        .snapshots();
    print("--------------------------------------------------------------------------------------------");
    print(x.toString());
    print("--------------------------------------------------------------------------------------------");
    return x;
  }

}