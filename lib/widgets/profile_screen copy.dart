import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:provider/provider.dart';
import 'package:aktiMVP/widgets/cloud_functions.dart';

class ProfileScreen2 extends StatefulWidget {
  ProfileScreen2();

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen2> {
  final AuthClass _auth = AuthClass();

  final DatabaseService _cloud = DatabaseService();

  // @override
  // void initState() {
  //   _cloud.getUserData().then((result) {
  //     print(result);
  //     userDataComplete = result;
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthClass>(context).user;
    Future<Map<String, dynamic>> userData = _cloud.getUserData();
    return FutureBuilder(
      future: userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: 8),
              Text(
                // 'abc\'s profil',
                '${snapshot.data['navn']}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: Color.fromRGBO(63, 107, 71, 1),
                ),
              ),
              Spacer(flex: 1),
              Text(
                '${snapshot.data['brukerEpost']}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(63, 107, 71, 1),
                  fontSize: 20,
                ),
              ),
              Spacer(flex: 3),
              Container(
                width: 250,
                child: RaisedButton(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  child: Text(
                    'Mine billetter',
                    style: TextStyle(
                        color: Color.fromRGBO(63, 107, 71, 1), fontSize: 20),
                  ),
                ),
              ),
              Spacer(flex: 1),
              Container(
                width: 250,
                child: RaisedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Vår kontaktinfo'),
                        content: Text('Tlf 8080 8080 \nEmail: kontakt@akti.no'),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Ok',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    'Kontakt oss',
                    style: TextStyle(
                        color: Color.fromRGBO(63, 107, 71, 1), fontSize: 20),
                  ),
                ),
              ),
              Spacer(flex: 1),
              Container(
                width: 250,
                child: RaisedButton(
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  child: Text(
                    'Logg ut',
                    style: TextStyle(
                        color: Color.fromRGBO(63, 107, 71, 1), fontSize: 20),
                  ),
                ),
              ),
              Spacer(flex: 1),

              // Delete user
              Center(
                child: FlatButton.icon(
                    icon: Icon(
                      Icons.person,
                      color: Color.fromRGBO(63, 107, 71, 1),
                    ),
                    label: Text(
                      'Slett bruker',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(63, 107, 71, 1), fontSize: 16),
                    ),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          title: Text('Er du sikker?'),
                          content: Text(
                              'Om du sletter brukeren mister du all tilgang på tidligere kjøpte biletter'),
                          actions: [
                            FlatButton(
                              onPressed: () async {
                                String idHolder = user.uid;
                                await _auth.deleteUser();
                                await _cloud.deleteUserData(idHolder);
                                // Pop Dialog box
                                Navigator.of(context).pop();
                                // Pop current and push the homescreen
                                Navigator.of(context).pushReplacementNamed('/');
                              },
                              child: Text(
                                'Ja, slett brukeren min',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Nei',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              Spacer(flex: 22),
              Container(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/islandbridges.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
