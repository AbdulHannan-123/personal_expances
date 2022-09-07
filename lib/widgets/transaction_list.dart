import 'package:expance_planner_2022/models/transection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransectionList extends StatelessWidget {
  final List<Transection> transection;
  final Function delete;
  TransectionList({required this.transection,required this.delete});

  @override
  Widget build(BuildContext context) {
    return transection.isEmpty
        ? LayoutBuilder(builder: (context, constraints){
          return Column(
            children: [
              Text(
                'No Transections Added yet ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                  height: constraints.maxHeight *0.5,
                  child: Image.asset(
                    'assets/image/waiting.png',
                    fit: BoxFit.cover,
                  ))
            ],
          );
        }) 
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                          child: Text("\$" +transection[index].amount!.toStringAsFixed(2))),
                    ),
                  ),
                  title: Text(
                    transection[index].title.toString(),
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMMd().format(transection[index].date),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  trailing:MediaQuery.of(context).size.width >400
                  ?TextButton.icon(onPressed: ()=>delete(transection[index].id), icon: Icon(Icons.delete), label: Text('delete'),)
                  :IconButton( 
                    icon:Icon(Icons.delete),
                    color: Theme.of(context).primaryColor,                      
                    onPressed:()=>delete(transection[index].id),
                  ),
                ),
              );
            },
            itemCount: transection.length,
          );
  }
}
