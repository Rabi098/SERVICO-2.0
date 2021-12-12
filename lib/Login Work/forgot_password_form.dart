import 'package:flutter/material.dart';
import '../services/auth_services.dart';
import '../screens/login_page_flow.dart';




class ForgotPasswordform extends StatefulWidget {
  ForgotPasswordform({@required this.auth});
  final AuthBase auth;

  @override
  _ForgotPasswordformState createState() => _ForgotPasswordformState();
}

class _ForgotPasswordformState extends State<ForgotPasswordform> {


  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  String get _email => _emailcontroller.text;
  String get _password => _passwordcontroller.text;

  void _submit() async {
    try{
      await widget.auth.sendPasswordResetEmail(_email);
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
      RaisedButton(
        onPressed: _submit,
        color: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 10.0, left: 50.0, right: 50.0),
          child: Text(
            'Reset Password',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w300),
          ),
        ),
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