import 'package:flutter/material.dart';

class TicketUnissuedQuery extends StatefulWidget {
  const TicketUnissuedQuery({super.key});

  @override
  State<TicketUnissuedQuery> createState() => _TicketUnissuedQueryState();
}

class _TicketUnissuedQueryState extends State<TicketUnissuedQuery> {
  final _orderIdController = TextEditingController();
  final _projectNameController = TextEditingController();
  final _ticketBuyerNameController = TextEditingController();
  final _ticketBuyerPhoneController = TextEditingController();

  @override
  void dispose() {
    _orderIdController.dispose();
    _projectNameController.dispose();
    _ticketBuyerNameController.dispose();
    _ticketBuyerPhoneController.dispose();
    super.dispose();
  }

  void _onSearch() {
    // TODO: Implement search logic
    final queryParams = {
      'orderId': _orderIdController.text,
      'projectName': _projectNameController.text,
      'ticketBuyerName': _ticketBuyerNameController.text,
      'ticketBuyerPhone': _ticketBuyerPhoneController.text,
    };
    debugPrint('Search params: $queryParams');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '条件筛选',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _orderIdController,
                  decoration: const InputDecoration(
                    labelText: '订单ID',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _projectNameController,
                  decoration: const InputDecoration(
                    labelText: '项目名称',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _ticketBuyerNameController,
                  decoration: const InputDecoration(
                    labelText: '购票人姓名',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _ticketBuyerPhoneController,
                  decoration: const InputDecoration(
                    labelText: '购票人手机号',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton(onPressed: _onSearch, child: const Text('搜索')),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  _orderIdController.clear();
                  _projectNameController.clear();
                  _ticketBuyerNameController.clear();
                  _ticketBuyerPhoneController.clear();
                },
                child: const Text('重置'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
