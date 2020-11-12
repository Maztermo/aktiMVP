import 'package:aktiMVP/widgets/header_leading.dart';
import 'package:aktiMVP/widgets/ticket_list.dart';
import 'package:aktiMVP/widgets/title_card.dart';
import 'package:flutter/material.dart';

class Tab0 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.all(0), children: [
      LeadingHeader(),
      TitleCard(),
      TicketList(),
    ]);
  }
}
