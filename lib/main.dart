import 'dart:html';

import 'package:expance_planner_2022/widgets/chart.dart';
import 'package:expance_planner_2022/widgets/new_transections.dart';
import 'package:flutter/services.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'models/transection.dart';

void main() {
                                                        //// to ristrict the app th be not in landscape mood
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  //   ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Persoal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(headline1: TextStyle(fontFamily: 'OpenSans' , fontSize: 20,))
        )
      ),
      home: MyHomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

  bool _showChart = false;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  

    final List<Transection> _usertransection = [
    Transection(id: 'h1', title: 'shirt', amount: 67.10, date: DateTime.now()),
    Transection(id: 'h2', title: 'shorts', amount: 70.00, date: DateTime.now())
  ];

  Iterable<Transection> get _recentTransections{
    return _usertransection.where((element){
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    });
  }

  void _addTransections(String title, double amount,DateTime chosenDate) {
    final tx = Transection(title: title, amount: amount, date:chosenDate, id: DateTime.now().toString());
    setState(() {
      _usertransection.add(tx); 
    });
  }

  void _deleteTransection(String id){
    setState(() {
      _usertransection.removeWhere((element)=> element.id==id);
    });
  }


  void _AddNewItem(BuildContext context){
    showModalBottomSheet(context: context, builder: (_){
      return GestureDetector(child: NewTransections(_addTransections));
    });
  }
  



  @override
  Widget build(BuildContext context) {
    final mediaquery=MediaQuery.of(context);
    final landscape= mediaquery.orientation == Orientation.landscape;   //// to check if we are in land scpe or not
    final appBar=AppBar(
        title: Text('Persoal Expenses'),
        // backgroundColor: Colors.teal,
        actions: [
          IconButton(onPressed:()=> _AddNewItem(context), icon: Icon(Icons.add)),
        ],
      );
    final _txListWidget=Container(
              height: (mediaquery.size.height -appBar.preferredSize.height -mediaquery.padding.top) *0.6,
              child: TransectionList(transection: _usertransection , delete: _deleteTransection));
    return Scaffold(
      appBar: appBar ,
      body: SingleChildScrollView(
        child: Column(
          children: [
           if(landscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch.adaptive(value: _showChart, onChanged: (val){
                  setState(() {
                    _showChart=val;
                  });
                })
              ],
            ),
            if(!landscape)Container(
              height: (mediaquery.size.height -appBar.preferredSize.height - mediaquery.padding.top) *0.3,
              child: Chart(_recentTransections.toList())
              ),
              if(!landscape)_txListWidget ,
            if(landscape)_showChart?
            Container(
              height: (mediaquery.size.height -appBar.preferredSize.height - mediaquery.padding.top) *0.7,
              child: Chart(_recentTransections.toList())
              )
              :_txListWidget             
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed:()=>_AddNewItem(context) ,
        child: Icon(Icons.add,color: Colors.teal[900],size: 40,),
        ),
    );
  }
}
