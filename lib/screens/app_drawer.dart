import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plumbify/Controller/UserController.dart';
import 'package:plumbify/model/user.dart';
import 'package:plumbify/services/auth_services.dart';
import 'package:plumbify/services/database.dart';

class MainDrawer extends StatefulWidget {
  MainDrawer({@required this.auth});
  final AuthBase auth;
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserController userController = Get.find(tag:'user_controller');
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool value=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _signout () async {
    try{
      await widget.auth.signOut();

    } catch(e){
      print(e.toString());
    }
  }


  // Future<void> _getcurrentuser() async {
  //   try{
  //     //await auth.currentUser.updateProfile(displayName: 'new name');
  //     final username =  await auth.currentUser.displayName;
  //     Text(username);
  //   } catch(e){
  //   print(e.toString());
  //   }
  // }

  @override

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
              'Hello! ${widget.userController.user.value.name}',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                  color: Theme.of(context).primaryColor),
            )
          ),
          UserAccountsDrawerHeader(
            accountName: Text(widget.userController.user.value.name),
            accountEmail: Text("${widget.userController.user.value.email}" != "null"? widget.userController.user.value.email : "Welcome!"),
            currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://library.kissclipart.com/20180830/rtq/kissclipart-user-profile-clipart-user-profile-computer-icons-9fa0da1213c19b67.jpg')),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
              leading: Icon(
                Icons.person,
                size: 26,
              ),
              title: Text(
                "Profile",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              onTap: () {

                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('profile');
              }),
          ListTile(
              leading: Icon(
                Icons.star,
                size: 26,
              ),
              title: Text(
                "Your Rewards",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('rewards');
              }),
          ListTile(
              leading: Icon(
                Icons.history,
                size: 26,
              ),
              title: Text(
                "Order History",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('orderhistory');
              }),


          ListTile(
              leading: Icon(
                Icons.notifications,
                size: 26,
              ),
              title: Text(
                "Notifications",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('notifications');
              }),
          ListTile(
              leading: Icon(
                Icons.info_outline,
                size: 26,
              ),
              title: Text(
                "About us",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('aboutus');
              }),

          ListTile(
              leading: null,
              title: Text(
                "",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              onTap: () {
              }),

          ListTile(
              leading: Icon(
                Icons.logout,
                size: 26,
                color: Colors.grey,
              ),
              title: Text(
                "Logout",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.black),

              ),
              onTap: _signout
          )
        ],
      ),
    );

  }
}


