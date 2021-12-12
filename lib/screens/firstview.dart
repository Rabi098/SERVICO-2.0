import 'package:flutter/material.dart';
import '../services/auth_services.dart';
import 'package:plumbify/screens/login_page_flow.dart';

class Firstpage extends StatelessWidget {

  Firstpage({@required this.auth});
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {

    void _signInWithEmail(){
          Navigator.of(context).push(
            MaterialPageRoute<void>(
                fullscreenDialog: true,
                builder: (context) => EmailSignInPage(auth: auth))
          );
    }
    void _signUpWithEmail(){
      Navigator.of(context).push(
          MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (context) => EmailsignUpPage(auth: auth))
      );
    }

    final _gaph = MediaQuery.of(context).size.height;
    final _gapw = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/logo2.png'),
                height: _gaph * 0.30,
                width: _gapw * 0.50,
              ),
              Text(
                'SERVICO',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: _gaph * 0.02,
              ),
              Text(
                "Why Travel? When you have SERVICO",
                maxLines: 2,
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
              SizedBox(
                height: _gaph * 0.03,
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: _signUpWithEmail,
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              SizedBox(
                height: _gaph * 0.03,
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () {
                  _signInWithEmail();
                },
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
                        fontSize: 28,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
