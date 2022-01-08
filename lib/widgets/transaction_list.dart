import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionList(this.transactions, this.deleteTx, {Key? key}) : super(key: key);
  final Function deleteTx;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *0.7,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions added yet',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                    height: 200,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 8,
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            '\$${transactions[index].amount}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ),
                      radius: 30,
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    subtitle:
                        Text(DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed: () =>deleteTx(transactions[index].id) ,),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
