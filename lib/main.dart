import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/widget/NewTransaction.dart';

import 'models/Transaction.dart';
import 'widget/Chart.dart';
import 'widget/TransactionList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense tracker',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  button: TextStyle(color: Colors.white),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((txn) =>
            txn.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    var transaction = new Transaction(
        DateTime.now().toString(), title, amount, selectedDate);
    setState(() {
      _transactions.add(transaction);
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _transactions.removeWhere((txn) => txn.id == id);
    });
  }

  void _startNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense tracker'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _startNewTransaction(context);
              }),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _recentTransactions.isNotEmpty
              ? Chart(_recentTransactions)
              : Container(),
          TransactionList(_transactions, _deleteTransaction),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startNewTransaction(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
