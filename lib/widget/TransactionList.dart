import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Transaction.dart';

// ignore: must_be_immutable
class TransactionList extends StatelessWidget {
  List<Transaction> _transactions;
  Function _deleteTransaction;

  TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraint) {
            return Column(
              children: [
                Text('There are no transactions yet'),
                Container(
                  height: constraint.maxHeight * 0.7,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 2.0,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text('\$${_transactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text('${_transactions[index].title}'),
                  subtitle: Text(
                      '${DateFormat.yMMMd().format(_transactions[index].dateTime)}'),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? FlatButton.icon(
                          onPressed: () =>
                              _deleteTransaction(_transactions[index].id),
                          icon: Icon(Icons.delete),
                          textColor: Theme.of(context).errorColor,
                          label: Text('Delete'),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              _deleteTransaction(_transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: _transactions.length,
          );
  }
}
