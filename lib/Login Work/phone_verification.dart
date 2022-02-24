import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:plumbify/Login%20Work/landing_page.dart';
import 'package:plumbify/screens/homepage.dart';
import 'package:plumbify/Login%20Work/registerscreen.dart';
import 'package:plumbify/services/auth_services.dart';

import '../screens/login_page_flow.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class NumberVerify extends StatefulWidget {
  NumberVerify(
      {this.auth}
      );
  AuthBase auth;

  @override
  _NumberVerifyState createState() => _NumberVerifyState();
}

class _NumberVerifyState extends State<NumberVerify> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  //final phoneController = TextEditingController();
  String _phone = '';
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if(authCredential?.user != null){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> LandingPage(auth: widget.auth)));
      }
      else
      {
        //showAlertDialog(context);
      }

    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  bool _trySubmitForm() {
    final bool isValid = _formKey.currentState?.validate();
    return isValid;
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("Register"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen(auth: widget.auth,)));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Notice!"),
      content: Text("Register your account first."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



  getMobileFormWidget(context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Spacer(),
          Row(
            children: <Widget>[
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
                  validator: (value) {
                    if (value.length > 10) {
                      return 'Enter valid phone number';
                    }
                  },
                  onChanged: (value) {
                    _phone = "+92"+value;
                    print(_phone);
                    _trySubmitForm();
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

          SizedBox(
            height: 16,
          ),
          FlatButton(
            onPressed: ()  {
              bool value =_trySubmitForm();
              if(value == true) {
                setState(() {
                  showLoading = true;
                });
                FirebaseFirestore roofRef = FirebaseFirestore.instance;
                CollectionReference alluserRef = roofRef.collection('Users');
                Query phonenumberQuery = alluserRef.where("Phone",isEqualTo: _phone);
                phonenumberQuery.snapshots().listen(
                        (event) async {
                      if(event.docs.length == 0)
                      {
                        showAlertDialog(context);
                      }
                      else {
                        var phoneNumber = _phone;
                        await _auth.verifyPhoneNumber(
                          phoneNumber: phoneNumber,
                          verificationCompleted: (phoneAuthCredential) async {
                            setState(() {
                              showLoading = false;
                            });
                            //signInWithPhoneAuthCredential(phoneAuthCredential);
                          },
                          verificationFailed: (verificationFailed) async {
                            setState(() {
                              showLoading = false;
                            });
                            _scaffoldKey.currentState.showSnackBar(
                                SnackBar(content: Text(verificationFailed.message)));
                          },
                          codeSent: (verificationId, resendingToken) async {
                            setState(() {
                              showLoading = false;
                              currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                              this.verificationId = verificationId;
                            });
                          },
                          codeAutoRetrievalTimeout: (verificationId) async {},
                        );
                      }
                    });
              }

            },
            child: Text("SEND OTP"),
            color: Colors.red,
            textColor: Colors.white,
          ),
          Spacer(),
        ],
      ),
    );
  }


  getOtpFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: otpController,
          decoration: InputDecoration(
            hintText: "Enter OTP",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        FlatButton(
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
            PhoneAuthProvider.credential(
                verificationId: verificationId, smsCode: otpController.text);

            signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          child: Text("VERIFY"),
          color: Colors.red,
          textColor: Colors.white,
        ),
        Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("SignIn with Phone number"),
        ),
        key: _scaffoldKey,
        body: Container(
          child: showLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
              ? getMobileFormWidget(context)
              : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ));
  }
}