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
  late DateTime _dateTime;
  final _formKey = GlobalKey<FormState>();

  void _saveTask() {
    setState(() {
      widget.task.datetime = _dateTime;
      widget.task.save();
    });
    Navigator.of(context).pop();
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
              SizedBox(height: 20),
              TextButton(
                onPressed: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _dateTime,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != _dateTime) {
                    setState(() {
                      _dateTime = pickedDate;
                    });
                  }
                },
                child: const Text(
                  'Select Date',
                  style: TextStyle(
                      fontFamily: 'Montserrat - Regular',
                      fontSize: 13,
                      color: Colors.blue),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_dateTime),
                  );
                  if (pickedTime != null) {
                    // final now = DateTime.now();
                    setState(() {
                      _dateTime = DateTime(
                        _dateTime.year,
                        _dateTime.month,
                        _dateTime.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                    });
                  }
                },
                child: const Text(
                  'Select Time',
                  style: TextStyle(
                      fontFamily: 'Montserrat - Regular',
                      fontSize: 13,
                      color: Colors.blue),
                ),
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
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                widget.task.save();
              }
              Navigator.of(context).pop();
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
