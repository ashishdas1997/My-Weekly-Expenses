import 'package:flutter/material.dart';
import  'transaction.dart';
import 'package:intl/intl.dart';


class TransactionList extends StatelessWidget {
 final List<Transaction> transaction;

 TransactionList(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transaction.isEmpty ? Column(children: <Widget>[
        
        Text("No transactions added yet", ),
        SizedBox(height: 10,),
        Container(
            height: 200,
            child: Image.asset('images/nothing.png', fit: BoxFit.cover,))
      ],): ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColorDark, width: 2)),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    ('\$${transaction[index].amount.toStringAsFixed(2)}'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.teal),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transaction[index].title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                          fontSize: 20),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      DateFormat.yMMMd().format(transaction[index].date),
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          );
        },
          itemCount: transaction.length,

      ),
    );
  }
}
