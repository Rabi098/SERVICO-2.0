import 'package:flutter/material.dart';
import '../services/auth_services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class EmailsignUpform extends StatefulWidget {
  EmailsignUpform({@required this.auth});
  final AuthBase auth;

  @override
  _EmailsignUpformState createState() => _EmailsignUpformState();
}

class _EmailsignUpformState extends State<EmailsignUpform> {

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  String get _email => _emailcontroller.text;
  String get _password => _passwordcontroller.text;
  String get _name => _usernamecontroller.text;


  void _submit() async {
    try{
      await widget.auth.createUserWithEmailAndPassword(_email, _password,_name);
      Navigator.of(context).pop();

    } catch (e) {
      print(e.toString());
    }
  }

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


  List<Widget> _buildchildren() {
    return [
      TextField(
        controller: _usernamecontroller,
        decoration: InputDecoration(
          labelText: 'Username',
        ),
      ),
      TextField(
        controller: _emailcontroller,
        decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'test@test.com'
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
      TextField(
        controller: _passwordcontroller,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
      ),
      SizedBox(
        height: 8.0,
      ),
      // ignore: deprecated_member_use
      RaisedButton(
        onPressed: _submit,
        color: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 10.0, left: 50.0, right: 50.0),
          child: Text(
            'Create New Account',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w300),
          ),
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
      Center(child: Text('OR')),
      SizedBox(
        height: 8.0,
      ),
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

    ];
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildchildren(),
      ),
    );
  }
}