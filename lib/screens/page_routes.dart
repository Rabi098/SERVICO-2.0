import 'package:plumbify/screens/about_us.dart';
import 'package:plumbify/screens/electrician_homepage.dart';
import 'package:plumbify/screens/handyman_screen.dart';
import 'package:plumbify/screens/homepage.dart';
import 'package:plumbify/screens/map_location.dart';
import 'package:plumbify/screens/notfications.dart';
import 'package:plumbify/screens/order_history.dart';
import 'package:plumbify/screens/packages.dart';
import 'package:plumbify/screens/plumber_homepage.dart';
import 'package:plumbify/screens/profile.dart';
import 'package:plumbify/screens/rewards.dart';
import 'package:flutter/material.dart';
import 'package:plumbify/services/auth_services.dart';


class HomePage extends StatelessWidget {

  HomePage({@required this.auth});
  final AuthBase auth;
  // This widget is the root of your application.
  Map<int, Color> color = {
    50: const Color.fromRGBO(250, 80, 88, .1),
    100: const Color.fromRGBO(250, 80, 88, .2),
    200: const Color.fromRGBO(250, 80, 88, .3),
    300: const Color.fromRGBO(250, 80, 88, .4),
    400: const Color.fromRGBO(250, 80, 88, .5),
    500: const Color.fromRGBO(250, 80, 88, .6),
    600: const Color.fromRGBO(250, 80, 88, .7),
    700: const Color.fromRGBO(250, 80, 88, .8),
    800: const Color.fromRGBO(250, 80, 88, .9),
    900: const Color.fromRGBO(250, 80, 88, 1),
  };

  @override
  Widget build(BuildContext context) {
    final MaterialColor colorCustom = MaterialColor(0xFFFF0000 , color);
    return MaterialApp(
      title: 'SERVICO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: colorCustom,
        accentColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => Home(auth: auth,),
        'aboutus':(context) => AboutUS(),
        'rewards':(context) => Rewards(),
        'orderhistory':(context) => OrderHistory(),
        'profile':(context) => Profile(auth: auth),
        'notifications':(context) => Notifications(),
        'location':(context) => Map_location(),
        'electricians':(context) => ElectricianHome(),
        'plumber':(context) => PlumberHome(),
        'HandymanScreen':(context) => HandymanScreen()

      },
    );
  }
}







// ignore: must_be_immutable
