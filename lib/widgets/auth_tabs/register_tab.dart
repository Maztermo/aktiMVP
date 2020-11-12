import 'package:flutter/material.dart';

import '../auth.dart';
import 'package:aktiMVP/providers/user_info.dart';
import 'package:aktiMVP/providers/users_infos.dart';

class RegisterTab extends StatefulWidget {
  @override
  _RegisterTabState createState() => _RegisterTabState();
}

// Future registerWithEmailAndPassword(String email, String password) async {
//   try {

//   } catch { return email;}
// }

class _RegisterTabState extends State<RegisterTab> {
  final AuthClass _auth = AuthClass();
  final _formKey = GlobalKey<FormState>();

  // Text field state
  String valgtNavn = '';
  String email = '';
  String password = '';
  String aktiveringskode = '';
  String error = '';
  var navn = ['Navn', 'Bedriftsnavn'];
  var tittel = ['Opprett bruker', 'Opprett bedriftsbruker'];
  var registrerText = ['Registrer ny bruker', 'Registrer ny bedriftsbruker'];
  var knappText = ['Bedrift? Trykk her', 'Ikke bedriftskunde? Trykk her'];
  UserProfileInfo newUser;
  int hvilken = 0;
  bool isCompanyUser = false;

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
                          tittel[hvilken],
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Name
                  TextFormField(
                    decoration: InputDecoration(hintText: navn[hvilken]),
                    validator: (value) => value.length < 4
                        ? 'Navn må være minst 4 karakterer'
                        : null,
                    obscureText: false,
                    onChanged: (value) {
                      setState(() {
                        valgtNavn = value;
                      });
                    },
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
                  SizedBox(height: 20),
                  if (isCompanyUser)
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Aktiveringskode'),
                      validator: (value) =>
                          value != 'AKTIMVP' && isCompanyUser == true
                              ? 'Konktakt oss på email/tlf for riktig kode'
                              : null,
                      onChanged: (value) {
                        setState(() {
                          aktiveringskode = value;
                        });
                      },
                    ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  RaisedButton(
                    color: Color.fromRGBO(63, 107, 71, 1),
                    child: Text(registrerText[hvilken],
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result =
                            await _auth.registerWithEmailAndPassword(
                                email, password, valgtNavn, isCompanyUser);
                        if (result == null) {
                          setState(() {
                            error = 'Vennligst oppgi en gyldig epost';
                          });
                        } else {
                          error = '';
                          newUser = UserProfileInfo(
                              isCompanyUser: isCompanyUser,
                              loggedIn: true,
                              userEmail: email,
                              userName: valgtNavn);
                          UserProfileInfos().addUserToDatabase(newUser);
                          Navigator.of(context).pushReplacementNamed('/');
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                      color: Color.fromRGBO(63, 107, 71, 1),
                      child: Text(knappText[hvilken],
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () {
                        setState(() {
                          isCompanyUser = !isCompanyUser;
                          if (isCompanyUser) {
                            hvilken = 1;
                          } else {
                            hvilken = 0;
                          }
                        });
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
