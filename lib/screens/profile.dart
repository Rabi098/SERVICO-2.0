import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../Controller/UserController.dart';
import '../services/auth_services.dart';
import '../model/user.dart';
import 'login_page_flow.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';


class Profile extends StatefulWidget {
  Profile({@required this.auth});
  final AuthBase auth;
  @override
  _ProfileState createState() => _ProfileState();

}

class _ProfileState extends State<Profile> {

  UserController userController = Get.find(tag:'user_controller');
  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController chargesController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String _type;
  bool _displayNameValid = true;
  bool _bioValid = true;
  File _image;
  String val;
  String url;
  updateProfileData() {
    setState(() {
      USer user = USer(
        uid: userController.user.value.uid,
        name: displayNameController.text,
        email: bioController.text,
        full_address: userController.user.value.full_address,
        nearby_address: userController.user.value.nearby_address,
        geoPoint: userController.user.value.geoPoint,
        phone: phoneController.text,
        profile_pic: url,
      );
      if(userController.user.value != user) {
        userController.postUser(user);
        bool isUpdated;
        setState(() {
          userController.user.value = user;
        });
      }
      // SnackBar snackbar = SnackBar(content: Text("Profile updated!"));
      // _scaffoldKey.currentState.showSnackBar(snackbar);
    });

    print(_type+'--------++++++++++----------');
  }
  @override
  void initState() {
    super.initState();
    displayNameController.text = userController.user.value.name;
    bioController.text = userController.user.value.email;
    url = userController.user.value.profile_pic;
    phoneController.text = userController.user.value.phone;
    addressController.text = userController.user.value.full_address;

  }

  Future uploadpic(BuildContext context) async {
    String filename = basename(_image.path);
    Reference ref = FirebaseStorage.instance.ref().child(filename);
    UploadTask uploadTask = ref.putFile(_image);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    url = imageUrl.toString();

    print(url);

    setState(() {
      print("Profile Picture uploaded");
      print("....................$url");
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Profile Picture Uploaded')));
    });


  }

  @override
  Widget build(BuildContext context) {
    print('-----------------------------------------------------');
    print(userController.user.value.toString());
    print(userController.user.value.name);
    print('-----------------------------------------------------');

    Future getImage() async {
      // ignore: deprecated_member_use
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
      });
      uploadpic(context);
    }

    return Scaffold(

      // appBar: AppBar(
      //   title: Text('Edit Profile'), ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.red,
                            child: ClipOval(
                              child: new SizedBox(
                                  width: 180.0,
                                  height: 180.0,
                                  child: (_image!=null)?Image.file(
                                    _image,
                                    fit: BoxFit.fill,
                                  ):url!=null?Image.network(url):Image.network('https://upload.wikimedia.org/wikipedia/commons/4/41/Profile-720.png')),
                            ),
                          ),
                        ),


                        Padding(
                          padding: EdgeInsets.only(top: 60.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.camera,
                              size: 30.0,
                            ),
                            onPressed: () {
                              getImage();
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    buildDisplayNameField(),
                    buildBioField(),
                    phone_number(),
                    address(context)

                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ignore: deprecated_member_use
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: updateProfileData,
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              // ignore: deprecated_member_use
              OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<void>(
                          fullscreenDialog: true,
                          builder: (context) => Forgotpasswordpage(auth: widget.auth,))
                  );
                },
                child: Text("Change Password",
                    style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildDisplayNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Change Display Name",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: displayNameController,
          decoration: InputDecoration(
            hintText: widget.auth.currentUser.displayName,
            errorText: _displayNameValid ? null : "Display Name too short",
          ),
        )
      ],
    );
  }

  Column buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Update Email Address",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: bioController,
          decoration: InputDecoration(
            hintText: widget.auth.currentUser.email,
            errorText: _bioValid ? null : "Bio too long",
          ),
        )
      ],
    );
  }


  Column phone_number() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Phone Number",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: phoneController,
          decoration: InputDecoration(
              hintText: widget.auth.currentUser.phoneNumber
          ),
        )
      ],
    );
  }
  Column address(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Address",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Expanded(
              child: TextField(

                controller: addressController,
                enabled: false,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,

                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )
                ),
              ),),
            GestureDetector(

              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: Colors.black,
                  ),
                  color: Colors.red,
                ),
                child: Icon(
                  Icons.location_pin,
                  color: Colors.white,
                ),
              ),
              onTap: (){
                Navigator.of(context).pushReplacementNamed('location');
              },
            ),
          ],),
      ],
    );
  }




}