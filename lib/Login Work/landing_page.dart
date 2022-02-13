import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plumbify/Controller/UserController.dart';
import '../services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/page_routes.dart';
import '../screens/firstview.dart';

class LandingPage extends StatelessWidget {
LandingPage({this.auth});
final AuthBase auth;
  UserController userController=Get.put(UserController(),tag: "user_controller");


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          if (user == null) {
            return Firstpage(
              auth:auth
            );
          }
          userController.fetchUser(user.uid);

          return HomePage(
            auth: auth,
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}