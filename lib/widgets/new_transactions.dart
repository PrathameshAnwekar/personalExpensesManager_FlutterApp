import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/transaction_list.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  var dateSelected;
  final amountController = TextEditingController();

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        dateSelected = pickedDate;
      });
    });
  }

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredAmount <= 0 || enteredTitle.isEmpty || dateSelected==null) {
      return;
    }

    widget.addTx(titleController.text, double.parse(amountController.text), dateSelected);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 100,
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            top: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom +10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(dateSelected == null
                        ? 'No date chosen!'
                        : DateFormat.yMd().format(dateSelected)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                        onPressed: () {
                          presentDatePicker();
                        },
                        child: const Text(
                          'Choose Date',
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: submitData,
                  child: const Text(
                    'Add Transaction',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
