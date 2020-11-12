import 'package:aktiMVP/widgets/ticket_3preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aktiMVP/providers/tickets_provider.dart';

class TicketList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ticketsData = Provider.of<Tickets>(context);
    final tickets = ticketsData.tickets;
    return Container(
      height: 150.0 * tickets.length, // height + padding
      width: double.infinity,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(0),
        itemCount: tickets.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: tickets[i],
          child: Ticket3Preview(), // TicketPreview(),
        ),
      ),
    );
  }
}
