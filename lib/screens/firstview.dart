import 'package:flutter/material.dart';
import 'package:plumbify/screens/phone_verification.dart';
import 'package:plumbify/screens/registerscreen.dart';
import '../services/auth_services.dart';
import 'package:plumbify/screens/login_page_flow.dart';

class Firstpage extends StatelessWidget {

  Firstpage({@required this.auth});
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {

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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<void>(
                          fullscreenDialog: true,
                          builder: (context) => RegisterScreen(auth: auth))
                  );
                },
                child: Container(
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _gaph * 0.03,
              ),
              // ignore: deprecated_member_use
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<void>(
                          fullscreenDialog: true,
                          builder: (context) => NumberVerify(auth: auth))
                  );
                },
                child: Container(
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w300),
                    ),
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
