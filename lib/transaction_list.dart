import 'package:flutter/material.dart';
import  'transaction.dart';
import 'package:intl/intl.dart';


class TransactionList extends StatelessWidget {
 final List<Transaction> transaction;
 final Function deleteTransaction;

 TransactionList(this.transaction,  this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transaction.isEmpty ? Column(children: <Widget>[
        
        Text("No transactions added yet", ),
        SizedBox(height: 10,),
        Container(
            height: 200,
            child: Image.asset('images/nothing.png', fit: BoxFit.cover,))
      ],): ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(

              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(leading: CircleAvatar(radius: 30, child: Padding(
                padding: EdgeInsets.all(10),
                child: FittedBox(child: Text('\$${transaction[index].amount}')
                )
            ),
            ),
              title: Text(transaction[index].title,
                style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(DateFormat.yMMMd().format(transaction[index].date)
              ),
              trailing:  IconButton(icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => deleteTransaction(transaction[index].id),
              ),

            ),
          );
        },
          itemCount: transaction.length,

      ),
    );
  }
}
