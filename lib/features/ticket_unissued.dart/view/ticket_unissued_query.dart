import 'package:flutter/material.dart';

class TicketUnissuedQuery extends StatelessWidget {
  const TicketUnissuedQuery({ super.key });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {

            },
            child: const Text('搜索'),
          ),
        ],
      ),
    );
  }
}