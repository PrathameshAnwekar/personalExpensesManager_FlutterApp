// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';
import 'package:personal_expenses_app/widgets/new_transactions.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            titleTextStyle:
                TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold)),
        primarySwatch: Colors.purple,
      ),
      title: 'Personal Expenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart= false;

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {}, child: NewTransaction(_addNewTransaction));
        });
  }

  final List<Transaction> _userTransaction = [
    Transaction(
        id: 't1', title: 'New Shoes', date: DateTime.now(), amount: 69.69),
    Transaction(
        id: 't2',
        title: 'Weekly groceries',
        date: DateTime.now(),
        amount: 420.42)
  ];
  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        date: chosenDate,
        amount: txAmount);
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        theme: ThemeData(
          textTheme: ThemeData.light().textTheme.copyWith(
              subtitle1: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          fontFamily: 'Quicksand',
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Personal Expenses'),
            actions: [
              IconButton(
                  onPressed: () {
                    _startAddNewTransaction(context);
                  },
                  icon: Icon(Icons.add))
            ],
          ),

        body: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: [
                    Text('Show Chart'),
                    Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      },
                    )
                  ],
                ),
                _showChart == false ? Container() : Chart(_recentTransactions),
                TransactionList(_userTransaction, _deleteTransaction)
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                _startAddNewTransaction(context);
              },
              child: Icon(Icons.add)),
        ));
  }
}
