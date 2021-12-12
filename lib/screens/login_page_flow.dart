import 'package:flutter/material.dart';
import 'package:plumbify/Login%20Work/email_signin_form.dart';
import '../Login Work/forgot_password_form.dart';
import '../services/auth_services.dart';
import 'package:plumbify/Login%20Work/email_signup_form.dart';


class EmailSignInPage extends StatelessWidget {

  EmailSignInPage({@required this.auth});
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {

    final _gaph = MediaQuery.of(context).size.height;
    final _gapw = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("SERVICO"),
        backgroundColor: Colors.red,
        elevation: 2.0,
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Card(
                  child: Emailsigninform(
                    auth: auth
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

class EmailsignUpPage extends StatelessWidget {

  EmailsignUpPage({@required this.auth});
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    final _gaph = MediaQuery.of(context).size.height;
    final _gapw = MediaQuery.of(context).size.width;
    return Scaffold(
          appBar: AppBar(
            title: Text("SERVICO"),
            backgroundColor: Colors.red,
            elevation: 2.0,
          ),
          backgroundColor: Colors.grey[200],
          body: Padding(
            padding: const EdgeInsets.all(16.8),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Card(
                      child: EmailsignUpform(
                          auth: auth
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
class Forgotpasswordpage extends StatelessWidget {

  Forgotpasswordpage({@required this.auth});
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    final _gaph = MediaQuery.of(context).size.height;
    final _gapw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("SERVICO"),
        backgroundColor: Colors.red,
        elevation: 2.0,
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Card(
                child: ForgotPasswordform(
                    auth: auth
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

}
