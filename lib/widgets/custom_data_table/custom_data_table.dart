import 'package:efficacy_admin/models/club_position/club_position_model.dart';
import 'package:flutter/material.dart';

class CustomDataTable extends StatelessWidget{
  final List<String> columns;
  final List<ClubPositionModel> rows;
  final double? columnspace;
  const CustomDataTable({
    super.key,
    this.columnspace,
    this.columns = const [],
    this.rows = const [],
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 204, 204, 204)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DataTable(
        columnSpacing: columnspace,
        columns: columns.map((e) => DataColumn(
          label: Text(e)
        )).toList(),
        rows: rows.map((e) => DataRow(cells: 
         [
          DataCell(Text(e.clubID)),
          DataCell(Text(e.position)),
         ]
        )
        ).toList()
      ),
    );
  }
}
