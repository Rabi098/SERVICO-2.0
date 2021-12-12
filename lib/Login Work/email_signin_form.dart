import 'package:flutter/material.dart';
import 'package:plumbify/Login%20Work/email_signup_form.dart';
import 'package:plumbify/Login%20Work/forgot_password_form.dart';
import '../services/auth_services.dart';
import '../screens/login_page_flow.dart';



class Emailsigninform extends StatefulWidget {
  Emailsigninform({@required this.auth});
  final AuthBase auth;

  @override
  _EmailsigninformState createState() => _EmailsigninformState();
}

class _EmailsigninformState extends State<Emailsigninform> {


  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  String get _email => _emailcontroller.text;
  String get _password => _passwordcontroller.text;

  void _submit() async {
    try{
      await widget.auth.signInWithEmailAndPassword(_email, _password);
      Navigator.of(context).pop();

    } catch (e) {
      print(e.toString());
    }
  }

  List<Widget> _buildchildren() {
    return [
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
      RaisedButton(
        onPressed: _submit,
        color: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 10.0, left: 50.0, right: 50.0),
          child: Text(
            'Sign In',
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
      FlatButton(onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute<void>(
                fullscreenDialog: true,
                builder: (context) => Forgotpasswordpage(auth: widget.auth))
        );
      },
        child: Text('Forgot Password?'),
      ),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EmailsignUpPage(auth: widget.auth)));
      },
          child: Text('Need an account? Register'),
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
