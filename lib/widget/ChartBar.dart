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
    return Flexible(
        fit: FlexFit.tight,
        child: Column(
          children: [
            Container(
              height: 20,
              child: FittedBox(
                child: Text('\$${_totalAmount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 60,
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
              height: 4,
            ),
            Container(
              child: Text('$_spentDayLabel'),
            )
          ],
        ));
  }
}
