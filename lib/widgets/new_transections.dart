import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: use_key_in_widget_constructors
class NewTransections extends StatefulWidget {
  final Function onpressed;

  NewTransections(this.onpressed);

  @override
  State<NewTransections> createState() => _NewTransectionsState();
}

class _NewTransectionsState extends State<NewTransections> {
  final titlecontroller = TextEditingController();

  final amountcontroller = TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    final enteredTitle = titlecontroller.text;
    final enteredAmount = double.parse(amountcontroller.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.onpressed(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titlecontroller,
                decoration: InputDecoration(
                  labelText: 'Enter Item Name',
                ),
                keyboardType: TextInputType.text,
                cursorColor: Colors.teal,
                onSubmitted: (_) => submitData,
              ),
              TextField(
                controller: amountcontroller,
                decoration: InputDecoration(hintText: 'Enter Price'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(_selectedDate == null
                            ? 'No Date Choosen'
                            : "${DateFormat.yMd().format(_selectedDate!)}")),
                    TextButton(
                      child: Text(
                        'Choose Date!',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: submitData,
                  child: Text(
                    "ADD Item",
                    // style: TextStyle(color: Colors.teal),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
