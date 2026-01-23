import 'package:flutter/cupertino.dart';
import 'ticket_unissued_query.dart';
import 'ticket_unissued_table.dart';

class TicketUnissuedPage extends StatelessWidget {
  const TicketUnissuedPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TicketUnissuedQuery(),
        TicketUnissuedTable(),
      ],
    );
  }
}
