import 'package:aktiMVP/providers/user_info.dart';
import 'package:aktiMVP/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aktiMVP/providers/tickets_provider.dart';

class TicketInformationScreen extends StatelessWidget {
  static const routeName = '/ticketInfo';

  magicPaymentFunction() {
    // first remove X from available tickets.
    // help me lord I hope Stripe is easy to integrate
    // successful? Add ticket to "user purchases"
    //    add 0 available tickets.
    // Unsucceful or canceled? add X back to available tickets.
  }

  @override
  Widget build(BuildContext context) {
    final ticketId = ModalRoute.of(context).settings.arguments as String;
    final loadedTicket =
        Provider.of<Tickets>(context, listen: false).findById(ticketId);
    final isLoggedIn = Provider.of<UserProfileInfo>(context).loggedIn;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Hero(
              tag: '$ticketId',
              child: Image.network(
                loadedTicket.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    title: Text(loadedTicket.title,
                        style: TextStyle(fontSize: 24)),
                  ),
                  ListTile(
                    title: Text(loadedTicket.description,
                        style: TextStyle(fontSize: 16)),
                  ),
                  Spacer(flex: 1),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(flex: 1),
                      Text(
                        'førpris: ' + loadedTicket.fullPrice.toString(),
                        style:
                            TextStyle(decoration: TextDecoration.lineThrough),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 8, right: 12),
                        child: RaisedButton(
                          onPressed: isLoggedIn
                              ? magicPaymentFunction()
                              : () {
                                  showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      title: Text('Whoops!'),
                                      content: Text(
                                          'Du må være logget inn for å kunne kjøpe en billett'),
                                      actions: [
                                        FlatButton(
                                            onPressed: null, child: Text('Ok')),
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pushNamed(context,
                                                  AuthScreen.routeName);
                                            },
                                            child: Text(
                                                'Logg inn / Lag en bruker'))
                                      ],
                                    ),
                                  );
                                },
                          child: Text(
                            'Kjøp nå for: ' +
                                loadedTicket.discountPrice.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 100,
        clipBehavior: Clip.hardEdge,
        color: Color.fromRGBO(129, 168, 121, 1),
        child: Container(height: 65),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.arrow_back,
        ),
        label: Text('tilbake'),
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: Color.fromRGBO(63, 107, 71, 1),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }
}
