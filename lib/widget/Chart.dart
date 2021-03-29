import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/models/Transaction.dart';
import 'package:personal_expense_tracker/widget/ChartBar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSumDayWise = 0.0;

      for (var _transaction in _recentTransactions) {
        if (_transaction.dateTime.day == weekDay.day &&
            _transaction.dateTime.month == weekDay.month &&
            _transaction.dateTime.year == weekDay.year) {
          totalSumDayWise += _transaction.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSumDayWise
      };
    }).reversed.toList();
  }

  double get _totalSpentOnWeek {
    return groupedTransactionValues.fold(
        0.0, (sum, eachDayItem) => sum + eachDayItem['amount']);
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionValues
            .map((data) => ChartBar(data['day'], data['amount'],
            _totalSpentOnWeek > 0.0? (data['amount'] as double) / _totalSpentOnWeek : 0.0))
            .toList(),
      ),),
    );
  }
}
