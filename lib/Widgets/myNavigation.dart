import 'package:flutter/material.dart';
import 'package:plumbify/screens/app_drawer.dart';
import 'package:plumbify/screens/homepage.dart';
import 'package:plumbify/services/auth_services.dart';

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar({@required this.auth,});
  final AuthBase auth;

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar > {

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void myfunc() {
    _widgetOptions.add(Home(auth: widget.auth));
    _widgetOptions.add(Text("profile"));
    _widgetOptions.add(Text("Search"));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myfunc();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SERVICO"),
        actions: <Widget>[
          IconButton(onPressed:(){ Navigator.of(context).pushNamed('location');}, icon: Icon(Icons.location_pin,color: Colors.white,))
        ],
      ),
      drawer: MainDrawer(auth: widget.auth,),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Color(0xffCD1313),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home,color: Colors.white,),
                title: Text('Home',style: TextStyle(color: Colors.white,fontSize: 16),),
                backgroundColor: Colors.green
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search,color: Colors.white,),
                title: Text('Search',style: TextStyle(color: Colors.white,fontSize: 16),),
                backgroundColor: Colors.yellow
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,color: Colors.white,),
              title: Text('Profile',style: TextStyle(color: Colors.white,fontSize: 16),),
              backgroundColor: Colors.blue,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 35,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }
}