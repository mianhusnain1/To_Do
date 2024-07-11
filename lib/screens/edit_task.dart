import 'package:flutter/material.dart';
import 'package:to_do/models/taskmodel.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel task;

  const EditTaskScreen({required this.task, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_selectedDate != null && _selectedTime != null) {
        final DateTime selectedDateTime = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        );
        widget.task.datetime = selectedDateTime;
      }

      widget.task.save();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color.fromARGB(255, 246, 251, 255),
      title: const Text(
        'Edit Task',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 25,
          fontFamily: 'Montserrat - Bold',
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                maxLength: 20,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'Montserrat - Regular'),
                initialValue: widget.task.title,
                onSaved: (value) => widget.task.title = value ?? "",
                decoration: const InputDecoration(
                    hintText: "Edit Title",
                    hintStyle: TextStyle(fontFamily: 'Montserrat - Bold')),
              ),
              TextFormField(
                maxLength: 20,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'Montserrat - Regular'),
                initialValue: widget.task.location,
                onSaved: (value) => widget.task.location = value ?? "",
                decoration: const InputDecoration(
                    hintText: "Edit Location",
                    hintStyle: TextStyle(fontFamily: 'Montserrat - Bold')),
              ),
              const SizedBox(height: 20),
              const Text(
                "Change Date and Time",
                style: TextStyle(
                    color: Color.fromARGB(255, 1, 52, 94),
                    fontFamily: 'Montserrat - SemiBold',
                    fontSize: 15),
              ),
              TextButton(
                // key: _formKey,
                onPressed: () => _selectDate(context),
                child: Text(
                    _selectedDate == null
                        ? "Select date"
                        : 'Date: ${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Montserrat - Regular',
                    )),
              ),
              TextButton(
                // key: _formKey,
                onPressed: () => _selectTime(context),
                child: Text(
                    _selectedTime == null
                        ? 'Select Time'
                        : 'Time: ${_selectedTime!.format(context)}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Montserrat - Regular',
                    )),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel',
              style: TextStyle(
                color: Colors.blue,
                fontFamily: 'Montserrat - Bold',
              )),
        ),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
            onPressed: () {
              _saveTask();
            },
            child: const Text(
              "Size",
              style: TextStyle(
                fontFamily: 'Montserrat - Bold',
                color: Colors.white,
              ),
            ))
        // TextButton(
        //   onPressed: _saveTask,
        //   child: const Text('Save'),
        // ),
      ],
    );
  }
}
