import 'package:flutter/material.dart';

class DateDropdownPicker extends StatefulWidget {
  @override
  _DateDropdownPickerState createState() => _DateDropdownPickerState();
}

class _DateDropdownPickerState extends State<DateDropdownPicker> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Selected Date: ${selectedDate.toLocal()}'),
        SizedBox(height: 20.0),
        TextFormField(
          expands: false,
          controller: TextEditingController(
            text: '${selectedDate.toLocal()}',
          ),
          readOnly: true,
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
            labelText: 'Select Date',
            suffixIcon: Icon(Icons.calendar_today),
          ),
        ),
      ],
    );
  }
}