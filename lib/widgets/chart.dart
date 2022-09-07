import 'package:expance_planner_2022/models/transection.dart';
import 'package:expance_planner_2022/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transection> recentTransection;

  Chart(this.recentTransection);

  List<Map<String, Object>> get groupTransectionValue {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;
      for (var i = 0; i < recentTransection.length; i++) {
        if (recentTransection[i].date.day == weekday.day &&
            recentTransection[i].date.month == weekday.month &&
            recentTransection[i].date.year == weekday.year) {
          totalSum = totalSum + recentTransection[i].amount!;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupTransectionValue.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransectionValue.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                e['day'].toString(),
                (e['amount'] as double),
                maxSpending==0.0?0.0 :(e['amount'] as double) / maxSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
