import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingamount;
  final double spendingPctofTotal;

  ChartBar(
    this.label,
    this.spendingamount,
    this.spendingPctofTotal,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      return Column(
      children: [
        Container(
          height: constraints.maxHeight * 0.15,
            child: FittedBox(
                child: Text('\$${spendingamount.toStringAsFixed(0)}'))),
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        Container(
          height: constraints.maxHeight * 0.6,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal, width: 1.0),
                    color: Color.fromRGBO(0, 128, 128, 0.4),
                    borderRadius: BorderRadius.circular(12)),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctofTotal,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                          color: Color.fromRGBO(0, 255, 255, 1), width: 1.0),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: constraints.maxHeight * 0.15,
          child: FittedBox(child: Text(label))),
      ],
    );
    });
     
  }
}
