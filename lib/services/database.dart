import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plumbify/model/user.dart';

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
  Future<USer> getUser(String uid) async{
    USer uSer;
    print('-----------------------------------------------------------------------------');
    print(uid);
    print('-----------------------------------------------------------------------------');

    await Firestore.collection("Users").where("uid",isEqualTo: uid).limit(1).get().then(( QuerySnapshot value) {

      Map<String, dynamic> documentData = value.docs.single.data();
      uSer = USer(
        name: documentData['Name'],
        email: documentData['Email'],
        full_address: documentData['full_address'],
        geoPoint: documentData['workerLocation'],
        nearby_address: documentData['nearby_address'],
        phone: documentData['Phone'],
        profile_pic: documentData['profilePic'],
        uid: documentData['uid'],
      );

      print('----------------------------Return uSer-------------------------'+uSer.toString()+uSer.email);
      return uSer;
      // }else{
      //   print('-----------------------------------------------------------------------------');
      //   print('Exception');
      //   print('-----------------------------------------------------------------------------');
      //
      // }

    }).catchError((e) {
      print('+++++++++++++++++++++++++++++++++++++++++++++');
      print(e.toString());
      return null;
    });
    return uSer;

  }
  addUser(USer user){
    bool is_Added = true;
    var x = Firestore.collection('Users').doc(user.uid)
        .set({
      'uid':user.uid,
      'Name': user.name,
      'Email':user.email,
      'Phone': user.phone,
      'profilePic':user.profile_pic!=null?user.profile_pic:'https://upload.wikimedia.org/wikipedia/commons/4/41/Profile-720.png',
      'workerLocation':user.geoPoint,
      'full_address':user.full_address,
      'nearby_address':user.nearby_address

    }).catchError((e){
      print("--------------------------------------------------------------------------------------------");
      is_Added =false;
      print(e.toString());
      print("--------------------------------------------------------------------------------------------");

    });
    return is_Added;
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
      'time':time,
      'Image':['s','b'],

    }).catchError((e){
      print("--------------------------------------------------------------------------------------------");
      is_Ordered =false;
      print(e.toString());
      print("--------------------------------------------------------------------------------------------");

    });
    return is_Ordered;
  }
  getWorkers(String query) async {
    Stream<QuerySnapshot> x = await Firestore
        .collection("Handyman").where('Type',isEqualTo: query)
        .snapshots();
    print("--------------------------------------------------------------------------------------------");
    print(x.toString());
    print("--------------------------------------------------------------------------------------------");
    return x;
  }

}