import 'package:aktiMVP/screens/ticket_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aktiMVP/providers/ticket_class.dart';

class TicketPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ticket = Provider.of<Ticket>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(5.0),
      height: 110,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                TicketInformationScreen.routeName,
                arguments: ticket.id,
              );
            },
            child: Container(
              child: Row(
                children: [
                  Container(
                    width: 160,
                    height: 105,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Hero(
                        tag: '${ticket.id}',
                        child: Image.network(
                          '${ticket.imageUrl}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      children: [
                        Container(
                          width: 180,
                          child: Text(
                            ticket.title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          width: 180,
                          child: Text(
                            ticket.description,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
