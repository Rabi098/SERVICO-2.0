import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:plumbify/Controller/UserController.dart';
import 'package:plumbify/Login%20Work/landing_page.dart';
import 'package:plumbify/model/user.dart';
import 'package:plumbify/screens/homepage.dart';
import 'package:plumbify/services/auth_services.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class RegisterScreen extends StatefulWidget {
  RegisterScreen({this.auth});
  AuthBase auth;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  UserController userController = Get.find(tag:'user_controller');
  final _formKey = GlobalKey<FormState>();
  final _formKeyOTP = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController cellnumberController =
  new TextEditingController();
  final TextEditingController otpController = new TextEditingController();

  var isLoading = false;
  var isResend = false;
  var isRegister = true;
  var isOTPScreen = false;
  var verificationCode = '';

  Future<void> _signInWithGoogle() async {
    try{
      await widget.auth.signInWithGoogle();
      Navigator.of(context).pop();

    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> _signInWithFacebook() async {
    try{
      await widget.auth.signInWithFacebook();
      Navigator.of(context).pop();

    } catch (e) {
      print(e.toString());
    }
  }

  //Form controllers
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    nameController.dispose();
    cellnumberController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isOTPScreen ? returnOTPScreen() : registerScreen();
  }

  Widget registerScreen() {
    final node = FocusScope.of(context);
    final _gaph = MediaQuery.of(context).size.height;
    final _gapw = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          backgroundColor: Colors.red,
          title: Text('Register new user'),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50,),
                    Image(
                      image: AssetImage('assets/logo2.png'),
                      height: _gaph * 0.20,
                      width: _gapw * 0.40,
                    ),
                    Text(
                      'SERVICO',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: TextFormField(
                        enabled: !isLoading,
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            floatingLabelBehavior:
                            FloatingLabelBehavior.never,
                            labelText: 'Name'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a name';
                          }
                          if(value.length < 4)
                          {
                            return 'Username must be four character long';
                          }
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            width: 70,
                            height: 55,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(child: Text("+92",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),))),
                        SizedBox(width: 10,),
                        Expanded(
                          child: TextFormField(
                            controller: cellnumberController,
                            validator: (value) {
                              if (value.length != 10) {
                                return 'Enter valid phone number';
                              }
                              if (value.isEmpty) {
                              return 'Enter phone number first';
                              }
                              },

                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),),
                              hintText: "Phone Number",
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Container(
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           vertical: 10.0, horizontal: 10.0),
                    //       child: TextFormField(
                    //         enabled: !isLoading,
                    //         keyboardType: TextInputType.phone,
                    //         controller: cellnumberController,
                    //         textInputAction: TextInputAction.done,
                    //         onFieldSubmitted: (_) => node.unfocus(),
                    //         decoration: InputDecoration(
                    //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    //             hintText: 'Phone Number',
                    //             floatingLabelBehavior:
                    //             FloatingLabelBehavior.never,
                    //             labelText: 'Phone Number'),
                    //         validator: (value) {
                    //           if (value.isEmpty) {
                    //             return 'Please enter a phone number';
                    //           }
                    //           if (value.length > 10) {
                    //             return 'Enter valid phone number';
                    //           }
                    //         },
                    //       ),
                    //     )),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        if (!isLoading) {
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, we want to show a loading Snackbar
                            setState(() {
                              signUp();
                              isRegister = false;
                              isOTPScreen = true;
                            });
                          }
                        }
                      },
                      child: new Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        width: 100,
                        height: 50,
                        child: Center(
                          child: Text(
                            "Next",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    SignInButton(
                      Buttons.Google,
                      text: "Sign up with Google",
                      onPressed: _signInWithGoogle,
                    ),
                    SignInButton(
                      Buttons.Facebook,
                      text: "Sign up with Facebook",
                      onPressed: _signInWithFacebook,
                    ),
                  ],
                ),
              )),
        ));
  }

  Widget returnOTPScreen() {
    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          backgroundColor: Colors.red,
          title: Text('OTP Screen'),
        ),
        body: ListView(children: [
          Form(
            key: _formKeyOTP,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Text(
                            !isLoading
                                ? "Enter OTP from SMS"
                                : "Sending OTP code SMS",
                            textAlign: TextAlign.center))),
                !isLoading
                    ? Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: TextFormField(
                        enabled: !isLoading,
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        initialValue: null,
                        autofocus: true,
                        decoration: InputDecoration(
                            labelText: 'OTP',
                            labelStyle: TextStyle(color: Colors.black)),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter OTP';
                          }
                        },
                      ),
                    ))
                    : Container(),
                !isLoading
                    ? Container(
                    margin: EdgeInsets.only(top: 40, bottom: 5),
                    child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                        child: new ElevatedButton(
                          onPressed: () async {
                            if (_formKeyOTP.currentState.validate()) {
                              // If the form is valid, we want to show a loading Snackbar
                              // If the form is valid, we want to do firebase signup...
                              setState(() {
                                isResend = false;
                                isLoading = true;
                              });
                              try {
                                await _auth
                                    .signInWithCredential(
                                    PhoneAuthProvider.credential(
                                        verificationId:
                                        verificationCode,
                                        smsCode: otpController.text
                                            .toString()))
                                    .then((usercred) async =>
                                {
                                  //sign in was success
                                usercred.user.updateProfile(displayName: nameController.text),
                                  if (usercred != null)
                                    {
                                      setState(()
                                      {
                                        FirebaseFirestore roofRef = FirebaseFirestore.instance;
                                        CollectionReference alluserRef = roofRef.collection('Users');
                                        Query phonenumberQuery = alluserRef.where("Phone", isEqualTo: usercred.user.phoneNumber);
                                        phonenumberQuery.snapshots().listen(
                                                (event) async {
                                              if (event.docs.length == 0) {
                                                userController.postUser(USer(uid: usercred.user.uid,

                                                  profile_pic: usercred.user.photoURL,
                                                  phone: "+92"+cellnumberController.text,
                                                  nearby_address: '',
                                                  geoPoint: GeoPoint(0,0),
                                                  full_address: '',
                                                  email: '',
                                                  name: nameController.text,
                                                  reward: 0,

                                                ),);
                                              }
                                            });
                                      }),
                                      //store registration details in firestore database
                                      // await _firestore
                                      //     .collection('Users')
                                      //     .doc(
                                      //     _auth.currentUser.uid)
                                      //     .set(
                                      //     {
                                      //       'name': nameController
                                      //           .text
                                      //           .trim(),
                                      //       'cellnumber':
                                      //       cellnumberController
                                      //           .text
                                      //           .trim(),
                                      //     },
                                      //     SetOptions(
                                      //         merge:
                                      //         true)).then(
                                      //         (value) =>
                                      //     {
                                      //then move to authorised area
                                      setState(() {
                                        isLoading =
                                        false;
                                        isResend =
                                        false;
                                      }),

                                      Navigator.pop(context),
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext
                                          context) =>
                                              LandingPage(auth: widget.auth,),
                                        ),
                                      )
                                    }
                                })
                                    .catchError((error) =>
                                {
                                  setState(() {
                                    isLoading = false;
                                    isResend = true;
                                  }),
                                });
                                setState(() {
                                  isLoading = true;
                                });
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                          child: new Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 15.0,
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: Text(
                                    "Submit",
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        )))
                    : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(
                            backgroundColor:
                            Theme
                                .of(context)
                                .primaryColor,
                          )
                        ].where((c) => c != null).toList(),
                      )
                    ]),
                isResend
                    ? Container(
                    margin: EdgeInsets.only(top: 40, bottom: 5),
                    child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                        child: new ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isResend = false;
                              isLoading = true;
                            });
                            await signUp();
                          },
                          child: new Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 15.0,
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: Text(
                                    "Resend Code",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )))
                    : Column()
              ],
            ),
          )
        ]));
  }

  Future signUp() async {
    setState(() {
      isLoading = true;
    });
    debugPrint('Gideon test 1');
    var phoneNumber = "+92"+cellnumberController.text.toString();
    debugPrint('Gideon test 2');
    var verifyPhoneNumber = _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {
        debugPrint('Gideon test 3');
        //auto code complete (not manually)

        _auth.signInWithCredential(phoneAuthCredential).then((usercred) async =>
        {
          usercred.user.updateProfile(displayName: nameController.text),
          if (usercred != null)
            {
              setState(()
        {
          FirebaseFirestore roofRef = FirebaseFirestore.instance;
          CollectionReference alluserRef = roofRef.collection('Users');
          Query phonenumberQuery = alluserRef.where("Phone", isEqualTo: usercred.user.phoneNumber);
          phonenumberQuery.snapshots().listen(
                  (event) async {
                if (event.docs.length == 0) {
                  userController.postUser(USer(uid: usercred.user.uid,

                    profile_pic: usercred.user.photoURL,
                    phone: "+92"+cellnumberController.text,
                    nearby_address: '',
                    geoPoint: GeoPoint(0,0),
                    full_address: '',
                    email: '',
                    name: nameController.text,
                    reward: 0,

                  ),);
                }
              });
        }),
              //store registration details in firestore database

              //then move to authorised area
              setState(() {
                isLoading = false;
                isRegister = false;
                isOTPScreen = false;

                //navigate to is
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        LandingPage(auth: widget.auth,),
                  ),

                );
              })

              //     .catchError((onError) =>
              // {
              //   debugPrint(
              //       'Error saving user to db.' + onError.toString())
              // })
            }
        });
        debugPrint('Gideon test 4');
      },
      verificationFailed: (FirebaseAuthException error) {
        debugPrint('Gideon test 5' + error.message);
        setState(() {
          isLoading = false;
        });
      },
      codeSent: (verificationId, [forceResendingToken]) {
        debugPrint('Gideon test 6');
        setState(() {
          isLoading = false;
          verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        debugPrint('Gideon test 7');
        setState(() {
          isLoading = false;
          verificationCode = verificationId;
        });
      },
      timeout: Duration(seconds: 60),
    );
    debugPrint('Gideon test 7');
    await verifyPhoneNumber;
    debugPrint('Gideon test 8');
  }
}