import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../services/database.dart';
import 'package:flutter/material.dart';


class PlumberHome extends StatefulWidget {
  @override
  _PlumberHomeState createState() => _PlumberHomeState();
}

class _PlumberHomeState extends State<PlumberHome> {
  Stream PlumberData;

  Widget PlumberList() {

    return StreamBuilder<QuerySnapshot>(
      stream: PlumberData,
      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? StaggeredGridView.countBuilder(crossAxisCount: 2,
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return snapshot.data.docs[index]['Type']=='Plumber'?ElectricainTile(
                name: snapshot.data.docs[index]['Name']
                    .toString(),
                profilepic: snapshot.data.docs[index]["profilePic"],
              ):Container();
            },
            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            )
            : Container(
          child: Text("NO DATA Recieved\n"+snapshot.toString()),
        );
      },
    );
  }

  @override
  void initState() {
    getUserInfogetData();
    super.initState();
  }

  getUserInfogetData() async {
    //Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getWorkers().then((snapshots) {
      setState(() {
        PlumberData = snapshots;
        print(
          "--------------------------------------------------------------------------------------"+
          "we got the data + ${PlumberData.toString()} t"+
          "--------------------------------------------------------------------------------------"
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plumbers near You"),
        elevation: 0.0,
        centerTitle: false,

      ),
      body: Container(
        child: PlumberList(),
      ),
    );
  }
}

class ElectricainTile extends StatelessWidget {
  final String profilepic;
  final String name;

  ElectricainTile({this.profilepic,this.name});

  Widget _buildImageWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15)),
      child: Image.network(profilepic!=null?profilepic:"https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png",
          height: 250, width: double.infinity, fit: BoxFit.cover),
    );
  }

  Widget _buildTitleWidget() {
    if (name != null && name != '') {
      return Text(name, style: TextStyle(fontWeight: FontWeight.bold),);
    } else {
      return SizedBox();
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white,
      child: GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            _buildImageWidget(),
            _buildTitleWidget(),
          ],
        ),
        onTap: (){
          Navigator.of(context).pushNamed('NULL');
        },
      ),
    );
  }
}
