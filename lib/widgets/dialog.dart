import 'package:flutter/material.dart';
import 'package:to_do/Boxes/box.dart';
import 'package:to_do/models/taskmodel.dart';
import 'package:to_do/widgets/error_dialog.dart';

class TaskInputDialog extends StatefulWidget {
  const TaskInputDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TaskInputDialogState createState() => _TaskInputDialogState();
}

class _TaskInputDialogState extends State<TaskInputDialog> {
  late TextEditingController _titleController;
  late TextEditingController _locationController;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _locationController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color.fromARGB(255, 246, 251, 255),
      title: const Text(
        'Add Task',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(
                    color: Colors.black, fontFamily: ' Montserrat - Regular'),
                cursorColor: Colors.blue,
                maxLength: 20,
                enableSuggestions: true,
                autocorrect: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter The Details";
                  } else {
                    return null;
                  }
                },
                controller: _titleController,
                decoration: const InputDecoration(
                    labelText: 'Task Name',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat - Regular',
                    )),
              ),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(
                    color: Colors.black, fontFamily: ' Montserrat - Regular'),
                cursorColor: Colors.blue,
                maxLength: 20,
                enableSuggestions: true,
                autocorrect: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter The Details";
                  } else {
                    return null;
                  }
                },
                controller: _locationController,
                decoration: const InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat - Regular',
                    )),
              ),
              const SizedBox(height: 8.0),
              const Text(
                "Due Date and Time",
                style: TextStyle(
                    color: Color.fromARGB(255, 1, 52, 94),
                    fontFamily: 'Montserrat - SemiBold',
                    fontSize: 15),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Date: Not selected'
                          : 'Date: ${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}',
                      style: const TextStyle(
                        fontFamily: 'Montserrat - Regular',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Select Date',
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Montserrat - Regular',
                        )),
                  ),
                ],
              ),
              // const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedTime == null
                          ? 'Time: Not selected'
                          : 'Time: ${_selectedTime!.format(context)}',
                      style: const TextStyle(
                          fontFamily: 'Montserrat - Regular', fontSize: 13),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectTime(context),
                    child: const Text(
                      'Select Time',
                      style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Montserrat - Regular',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          style: const ButtonStyle(),
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
              if (_selectedDate == null || _selectedTime == null) {
                Dialogss.showAlertDialog(context, "Error",
                    "Please select your desired date and time.");
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text('Please select both date and time'),
                //   ),
                // );
                return;
              }

              String title = _titleController.text.trim();
              String location = _locationController.text.trim();
              DateTime dateTime = DateTime(
                _selectedDate!.year,
                _selectedDate!.month,
                _selectedDate!.day,
                _selectedTime!.hour,
                _selectedTime!.minute,
              );
              final data = TaskModel(
                title: title,
                location: location,
                datetime: dateTime,
                isCompleted: false,
              );
              final box = Boxes.getData();
              box.add(data);
              data.save();
              print("${data.datetime}");

              Navigator.of(context).pop();
            } else {
              return null;
            }
          },
          child: const Text(
            'Save',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat - Bold',
            ),
          ),
        ),
      ],
    );
  }
}
