import 'package:flutter/material.dart';

class MyDataSource extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text('订单ID $index')),
      DataCell(Text('项目ID $index')),
      DataCell(Text('订单来源 $index')),
      DataCell(Text('支付方式 $index')),
      DataCell(Text('支付状态 $index')),
      DataCell(Text('销售政策 $index')),
      DataCell(Text('退款状态 $index')),
      DataCell(Text('购票数量 $index')),
      DataCell(Text('出票方式 $index')),
      DataCell(Text('出票状态 $index')),
      DataCell(Text('检票数 $index')),
      DataCell(Text('开发票 $index')),
      DataCell(Text('购票人姓名 $index')),
      DataCell(Text('购票人手机号 $index')),
      DataCell(Text('项目名称 $index')),
      DataCell(Text('场次名称 $index')),
      DataCell(Text('邀请函code $index')),
      DataCell(Text('套票活动ID $index')),
      DataCell(Text('套票关联ID $index')),
      DataCell(Text('售票网点机构 $index')),
      DataCell(Text('主办方 $index')),
      DataCell(Text('订单创建时间 $index')),
      DataCell(Text('支付完成时间 $index')),
      DataCell(ElevatedButton(
        onPressed: () {},
        child: Text('操作'),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;

  
}

class TicketUnissuedTable extends StatelessWidget {
  const TicketUnissuedTable({ super.key });

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(

      columns: [
        DataColumn(label: Text('订单ID')),
        DataColumn(label: Text('项目ID')),
        DataColumn(label: Text('订单来源')),
        DataColumn(label: Text('支付方式')),
        DataColumn(label: Text('支付状态')),
        DataColumn(label: Text('销售政策')),
        DataColumn(label: Text('退款状态')),
        DataColumn(label: Text('购票数量')),
        DataColumn(label: Text('出票方式')),
        DataColumn(label: Text('出票状态')),
        DataColumn(label: Text('检票数')),
        DataColumn(label: Text('开发票')),
        DataColumn(label: Text('购票人姓名')),
        DataColumn(label: Text('购票人手机号')),
        DataColumn(label: Text('项目名称')),
        DataColumn(label: Text('场次名称')),
        DataColumn(label: Text('邀请函code')),
        DataColumn(label: Text('套票活动ID')),
        DataColumn(label: Text('套票关联ID')),
        DataColumn(label: Text('售票网点机构')),
        DataColumn(label: Text('主办方')),
        DataColumn(label: Text('订单创建时间')),
        DataColumn(label: Text('支付完成时间')),
        DataColumn(label: Text('操作')),
      ],
      source: MyDataSource()
    );
  }
}