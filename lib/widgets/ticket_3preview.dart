import 'package:aktiMVP/screens/ticket_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aktiMVP/providers/ticket_class.dart';

class Ticket3Preview extends StatelessWidget {
  final borderHeight = 2.0;
  final ticketHeight = 140.0;
  final bottomDecorationHeight = 40.0;

  @override
  Widget build(BuildContext context) {
    final ticket = Provider.of<Ticket>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        width: double.infinity,
        height: ticketHeight,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              TicketInformationScreen.routeName,
              arguments: ticket.id,
            );
          },
          child: Row(
            children: [
              // Left side of ticket (picture + text)
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    // Picture
                    Container(
                      height: ticketHeight,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        child: Hero(
                          tag: '${ticket.id}',
                          child: Image.network(
                            '${ticket.imageUrl}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    // BottomDecoration + Text
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.black87,
                                Colors.black38,
                                Colors.black12,
                                Color.fromRGBO(0, 0, 0, 0.04),
                                Color.fromRGBO(0, 0, 0, 0.03),
                                Color.fromRGBO(0, 0, 0, 0.02),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        height: ticketHeight,
                        width: double.infinity,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        ticket.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    // Container(
                    //   child: Text(
                    //     ticket.discountPrice.toString() + ',-',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 20,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),

              // Right side of Ticket
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: Container(
                    height: ticketHeight,
                    color: Color.fromRGBO(129, 168, 121, 1),
                    child: Column(
                      children: [
                        Spacer(flex: 1),
                        Text(
                          '12.01.2021 \nKl 18:00',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Spacer(flex: 2),
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              TicketInformationScreen.routeName,
                              arguments: ticket.id,
                            );
                          },
                          color: Color.fromRGBO(63, 107, 71, 1),
                          child: Text(
                            'Nå: ' + ticket.discountPrice.toString() + ',-',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          'Førpris: ' + ticket.fullPrice.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            // decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Spacer(flex: 1)
                      ],
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
