import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChartBar extends StatelessWidget {
  String _spentDayLabel;
  double _totalAmount;
  double _amountPctOfDay;

  ChartBar(this._spentDayLabel, this._totalAmount, this._amountPctOfDay);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint){
      return Column(
        children: [
          Container(
            height: constraint.maxHeight * 0.10,
            child: FittedBox(
              child: Text('\$${_totalAmount.toStringAsFixed(0)}',),
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.075,
          ),
          Container(
            height: constraint.maxHeight * 0.65,
            width: 15,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: _amountPctOfDay,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.075,
          ),
          Container(
            height: constraint.maxHeight * 0.1,
            child: FittedBox(child: Text('$_spentDayLabel')),
          )
        ],
      );
    });
  }
}
