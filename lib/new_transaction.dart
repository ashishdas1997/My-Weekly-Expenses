import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData() {
    if(amountController.text.isEmpty)
      {
        return;
      }

final enteredTitle = titleController.text;
final enteredAmount = double.parse(amountController.text);

if(enteredTitle.isEmpty || enteredAmount <=0 || selectedDate==null){
  return;
}

      widget.addTx(
          enteredTitle,
          enteredAmount,
        selectedDate,

      );
Navigator.of(context).pop();

  }
void presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now()
    ).then((pickedDate ) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });

    });
}

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_)=> submitData(),
            ),
            Container(
              height: 70,
              child: Row(children: <Widget>[
                Expanded(
                  child: Text(selectedDate ==null?
                      'No Date Chosen' : 'Picked Date: ${DateFormat.yMMMd().format(selectedDate)}' ),
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text('Choose Date' ,
                  style: TextStyle(
                    fontWeight: FontWeight.w900
                  ),
                  ),
                  onPressed: presentDatePicker,
                )
              ],),
            ),
            RaisedButton(
              child: Text('Add Transaction',
              style: TextStyle(
                fontWeight: FontWeight.w600
              ),
              ),
              color: Colors.green.shade900,
              textColor: Colors.white,

              onPressed:  submitData,
            )
          ],
        ),
      ),
    );
  }
}
