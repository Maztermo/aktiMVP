import 'package:aktiMVP/screens/ticket_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aktiMVP/providers/ticket_class.dart';

class Ticket2Preview extends StatelessWidget {
  final borderHeight = 2.0;
  final ticketHeight = 119.0;
  final bottomDecorationHeight = 40.0;

  @override
  Widget build(BuildContext context) {
    final ticket = Provider.of<Ticket>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: borderHeight, color: Colors.black87),
            borderRadius: BorderRadius.circular(5)),
        width: double.infinity,
        height: ticketHeight,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              TicketInformationScreen.routeName,
              arguments: ticket.id,
            );
          },
          child: Column(
            children: [
              // Picture
              Container(
                height: 90,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3),
                    topRight: Radius.circular(3),
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
                  bottomLeft: Radius.circular(3),
                  bottomRight: Radius.circular(3),
                ),
                child: Container(
                  color: Color.fromRGBO(129, 168, 121, 1),
                  height: 25,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          ticket.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          ticket.discountPrice.toString() + ',-',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      // Container(
                      //   color: Colors.black38,
                      //   width: 180,
                      //   child: Text(
                      //     ticket.description,
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 13,
                      //     ),
                      //   ),
                      // )
                    ],
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
