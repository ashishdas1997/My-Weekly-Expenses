import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chart.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';
import 'transaction.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.teal,
        fontFamily: 'OpenSans'
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> userTransactions = [

   /* Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    )*/
  ];
List<Transaction> get recentTransactions{

  return userTransactions.where((tx) {
    return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
  }).toList();

}

  void addNewTransaction(String txtitle, double txamount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txtitle,
      amount: txamount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      userTransactions.add(newTx);
    });

  }

  void startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(
        onTap: () {},
      child: NewTransaction(addNewTransaction),
      behavior: HitTestBehavior.opaque,
      );
    });
  }

  void deleteTransaction(String id){
  setState(() {
    userTransactions.removeWhere((tx)  {
      return tx.id==id;
    });
  });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Personal Expenses',
        style: TextStyle(
            fontFamily: 'PlayfairDisplay',
          fontWeight: FontWeight.w500
        ),
        ),
        actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed:() => startAddNewTransaction(context))],
      ),
      body: SingleChildScrollView(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(recentTransactions),
          TransactionList(userTransactions, deleteTransaction),
        ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          onPressed: () => startAddNewTransaction(context)),
    );
  }
}
