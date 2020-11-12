import 'package:aktiMVP/widgets/auth.dart';
import 'package:flutter/material.dart';

class LogInTab extends StatefulWidget {
  @override
  _LogInTabState createState() => _LogInTabState();
}

class _LogInTabState extends State<LogInTab> {
  final AuthClass _auth = AuthClass();
  final _formKey = GlobalKey<FormState>();

  // Text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 600,
        width: 300,
        decoration: BoxDecoration(
            color: Color.fromRGBO(129, 168, 121, 1),
            border: Border.all(width: 2, color: Colors.black)),
        child: Center(
          child: Container(
            height: 500,
            width: 280,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 300,
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Logg inn',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Email
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Epost'),
                    validator: (value) =>
                        value.isEmpty ? 'Skriv inn en epost' : null,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  // Password
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Passord'),
                    validator: (value) => value.length < 4
                        ? 'Passordet må være minst 4 karakterer langt'
                        : null,
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    color: Color.fromRGBO(63, 107, 71, 1),
                    child: Text(
                      'Logg inn',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic signInResult =
                            await _auth.signIn(email, password);
                        if (signInResult == null) {
                          setState(() {
                            error =
                                'Kunne ikke logge inn med denne kombinasjonen av email & passord';
                          });
                        } else {
                          print('signed in');
                          print(signInResult);
                          Navigator.of(context).pushReplacementNamed('/');
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
