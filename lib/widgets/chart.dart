import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';
import 'package:intl/intl.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      print(DateFormat.E().format(weekday).substring(0, 1));
      print(totalSum);
      return {'day': DateFormat.E().format(weekday), 'amount': totalSum};
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
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
            children: groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(data['day'] as String, data['amount'] as double,
                    (maxSpending == 0 ? 0 : (data['amount']) as double) / maxSpending),
              );
            }).toList(),
          ),
        ));
  }
}
