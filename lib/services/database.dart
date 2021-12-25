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