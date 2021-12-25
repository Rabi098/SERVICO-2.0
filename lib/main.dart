import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plumbify/screens/firstview.dart';
import 'package:plumbify/Login%20Work/landing_page.dart';
import 'package:plumbify/services/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
//Checking clone
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(auth: Auth(),),
     );
  }
}
