import 'package:flutter/material.dart';

class MyDatePicker extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator? validator;

  const MyDatePicker({this.controller, this.validator, super.key});

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.controller!.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: 'Date of Birth',
            hintText: "${selectedDate.toLocal()}".split(' ')[0],
          ),
          validator: widget.validator,
        ),
      ),
    );
  }
}
