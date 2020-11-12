import 'package:aktiMVP/providers/user_info.dart';
import 'package:aktiMVP/providers/users_infos.dart';
import 'package:aktiMVP/widgets/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:aktiMVP/screens/overview_screen.dart';
import 'package:aktiMVP/screens/add_ticket_screen.dart';
import 'package:aktiMVP/screens/ticket_information_screen.dart';

import 'screens/auth_screen.dart';

import 'providers/tickets_provider.dart';
import 'providers/ticket_class.dart';
// import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Ticket()),
        ChangeNotifierProvider.value(value: Tickets()),
        ChangeNotifierProvider.value(value: UserProfileInfo()),
        ChangeNotifierProvider.value(value: UserProfileInfos()),
        ChangeNotifierProvider.value(value: AuthClass())
      ],
      child: MaterialApp(
        title: 'Akti',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.orange,
            accentColor: Colors.blueGrey,
            scaffoldBackgroundColor:
                Colors.white // Color.fromRGBO(209, 223, 205, 1),
            // visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
        home: OverviewScreen(),
        routes: {
          TicketInformationScreen.routeName: (ctx) => TicketInformationScreen(),
          AddTicketForm.routeName: (ctx) => AddTicketForm(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(),
    );
  }
}
